Return-Path: <netdev+bounces-299807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CUhjKpUrMWp9dAUAu9opvQ
	(envelope-from <netdev+bounces-299807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13B68E836
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:55:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=S5Al0GSo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299807-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AD723018D46
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D34C436355;
	Tue, 16 Jun 2026 10:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51242E009;
	Tue, 16 Jun 2026 10:54:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607294; cv=fail; b=VOPJgcPuDaCgsuc772PR8l71e71jTEwgaIOHrO5dCFjQfE23mydB/UvdbwR/I51QmBYOqdu2bsJD3moZ8f+vBiEx/sRvWymbRzGsEwljdZN51OvWTE5OR4WNEghshlEHS8X8IZW0wGhSHM7QekhIZYXCVDHf6fqOHzh6kwVj2E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607294; c=relaxed/simple;
	bh=zBViJ/MylGgw94NYbumaMw50Wo9oEEw9YkGKW2+T3sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ptm58LAw6sL/vNzH8d+s7vWyIti/7Q3c/FTpGziP+ASNIZPar+XMJqRkdKAycaw2MqvxdVjvaVG8E7icLohGR5irKsfKTzk2HqLDLecQlMez/5kJU6WM5XDIZyzkLvIDKF7wfsddknaTus42cS27JY9wONNbk6Sm06ZIPcw7ntA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S5Al0GSo; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgWczoAtpmh1GzZEKX/IbVqL/BR12R98s8kW88PU+x2tfMhxwMwCqvA67Fpv3j1DbYN/hCiR6elqFXeJ9YAXOj1P8EG4+/TTwV9fuYlmbz2eOapLsy9m1mEMaQ/TZ9JvlfWzG1YKJIxC98jwvchlmgPurN+vXiqPJOJJr+xY7V5Ttc4Xt1u3vmjxMLqt8bROoBmqgE9NlwslL9UGgNlzP3+KJk/n/NEFHfMgM+IGiNcX+6fCY9yui5Ld0hh2WixdpUfiFR7UkmhuZeWsLFnzdDtK4tDPXtN/ISwKKpBy7+s6p4K4MXY1+tDxYmC23AcZiGwH1RG/NnP4YbTrJuZ20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EvwMYWi6v/8wnWTSXx4fa6ny7mQAe0pW4ygu8QaKHs=;
 b=N2h9viajfFQSkqEIf9cDrj+gH1xhIVkZGYzKw4KSGXivSZQ7TueR49BUYcODS7YIFyDVyLubwWi8V/jFf+YyVhhX0IpgDkq4Pg0rTdje3lECwbzqmA3agCt/SN8hHt3Bg2gI2nGNL6zAUBtUIs3hLpUHWCaGa+82gi2qjn1cBlgfg3Zw4ktUNb1U3qFH4qSrC3Vu+qjqKa1/KlQIlJrXsup91r+C6ILsfoi0gKMqhDvgLMxtChdMw2h67vBVy928d15O1MipGcKkaAEZDs8MfmArA2aqpiwJGnkd7tEGnxW7iJThEjceOst1P1xSw4iRnTSA12cyaSoYAUJpLrbF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EvwMYWi6v/8wnWTSXx4fa6ny7mQAe0pW4ygu8QaKHs=;
 b=S5Al0GSoORrnr6XVlFYrOYFkstFi6FnYt5qKrDbJGtA+SG7fg4jd6+OuriTW5M/HqADwx//gfNAb0sdbjJr+Ti3JzJE/hFOzWXPhZkbjByGhnOLJglM83BT0QF2um6NzfJWahxMc8dEqfCvTdWGq3dkSY0WCcgAmy+48z8YZuoNhiasBaV4+EJ2+Q9oihqF5VaMX0WaZgpGGgo0iL8j6klf+Q+3R1au2Rbg37jy5h3nCmiaRhtEE/a4daxz//DKibcCSWjt2i1DXekNTVjhPIusIWd3EsvLAVTRFAg5yGsg6F4BSH5w+50BMpeZJ+d3SrUNx2bFX1ZuegQu25BEJHw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AS8PR04MB8932.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:54:51 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:54:50 +0000
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
Subject: [PATCH net] dpaa2-switch: fix VLAN upper check not rejecting bridge join
Date: Tue, 16 Jun 2026 13:54:30 +0300
Message-Id: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2327fa-254a-4870-bcd5-08decb95b076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+lmzRcDVR1MdCFZKiHqLZsu9/LVX3KqZlvbxxvWu9tAd1v7MfSoNX69FcBhCoq/h0Bmm1tG/YcRXv3M6KS+DuV5PURfEcTAdSjmq1H1t0+TyD1qNrRNTHpq6v/XAEL49EURJxetbgFafI4tA0V8pZcjZcciR26l9WzuFSnd33RcHsyH9R+fvlLprBXdBDfUfyJCHV6gkT683/wVl+C4nfayrrYp3whHPtGBejxaf9Ys1b+jid93hwXwWEaGSRyHosuB85TRtbXZkjiAklprnchEdBpCXJszaZWieUPw9PIjFUDoozfswg+ORvB72WbyA8XKs31DOLUeKXkSPqXRt8OkI9pKaDad+zG0w6IjhpAYv1+Wt00BbLEwUTYW/vB2/q6c1k3aVT+AwvPnHBsgQ1pQA+CdGwfnR1kOsiMzLy9G+92hwsx8zpLpp/eRQGjJTV9B+SjWSEvoqVH/BvEt0JTmTTJwWCmwt0IAdSCOBNstzWq9hs/UBElUW4s5KgDRTo7PVYy4K8+CAadoOD8snecFxC41q9JKXcqz88kMgw7c42xvgA2H5I59OeQG6rqTw5wpAwiB3itAfZxpmloRKWoPUjMEC3rp4Q90/+zKwl2/pSnBRfzrVqXgXbcRxgavyfJHv3rYr4B2smIOV93cMlnv2XdPVD6pgsC7UC6qbrY4xSHYy1V3yNs0Tm2qr8niZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mtc5KUzZZqhOeuqPEmguxoW38SAns0oq6CevDcChhZtU87tuNTJxUzwVQSQL?=
 =?us-ascii?Q?hns7KXsIdA2YfVZYbty5zrZ4ZIq+P+GdtY3Hef5BRx0IzEB4FhKTi/zDEUxL?=
 =?us-ascii?Q?WghpbYT8zRtrW7Y3/59WOeMjOx4kRh03kKx6oup0/uNYJUXddIi71/NvaCO0?=
 =?us-ascii?Q?cvTvlahGOyrCDPwUEBmBjMSfbgLDqYr29JPHo3q04s3Xdw/uUGFv9M/8641v?=
 =?us-ascii?Q?vdfGpKJND9yF0RscBNmVd715elo+Lxy50LYG2hgbutNayMgDza9JjqpSDjPX?=
 =?us-ascii?Q?tIQvFqXknQ+40jbZjTdLfbn6VyATuAF55pV0CZ4i4SbS4HxGkFHoK7Vyljk7?=
 =?us-ascii?Q?NRY4PJ6xr5E+Nc7jZbi0nKmanKiNsC4K+LfUWQvz0Ak16WN12VuqOvCONWLd?=
 =?us-ascii?Q?gv5QINdXwyV1cQ1FDysgFKafFkLMdungdnZFuzwt+JFJWOaBBqYmTfwiy6F+?=
 =?us-ascii?Q?671LRLdqZ2m8sgb/wDbhtZ0ScZA+jpB3jcsLKCgtDF5tsbfP77wMH4o1fYoh?=
 =?us-ascii?Q?ua5aI8bHkXnqlWOofBZy2Mz3HjP28NxT3ferFaznGgL2K8ViraF4/QWADnzW?=
 =?us-ascii?Q?jgweky6MmON4aTDpK6s82+iVJ5qUwg/SY3jwr24IzFTVftAPsWiYBx6XxT1R?=
 =?us-ascii?Q?C36iffvQxlI8uC7sK5mDKxff+dtRYEZdDGjg938sGw9g2Qaxe/rxsr+axex8?=
 =?us-ascii?Q?6We08qw+AeMzCvaNwS/9xLwsz40Mmal3wvkiRP8MyEkxSuO76KWJfcsVgY8o?=
 =?us-ascii?Q?l0ce7z5mMHTQyrxXM8k1g27dIYOY4lLoRyT2UZNwpAF50wDzlkWXQZR5Iy1T?=
 =?us-ascii?Q?Qc5WEhu2V4owIJxrkxK7bgGMxukZjLtro+5FFiy0i2F4lT0WbTTw921+mHqF?=
 =?us-ascii?Q?tk3bs2JE0IgEgoHVKmF3KU8TvoqbHQ3SQAsesZIWMrE1ANKB6lN06ocl6ou6?=
 =?us-ascii?Q?vGpit4QJ1xxaXYE+tA7TcMOg/aP0n49rrY96Urnem3g8G9V+iy4Zcm6aatx5?=
 =?us-ascii?Q?8yWZsi11kX4RRuLh1w4Mp4QYBCDKoGA9sLrBz9U0zVGHM1SsfDJ8UP4+mZ53?=
 =?us-ascii?Q?Vtkq8qXMmeSf96nj+t6LJ5AyhjR4XBqT/4Eq03VPQAdJMhmy1X1pXCn7rVGE?=
 =?us-ascii?Q?bPa/JSPWkV9pBSeKCyBf2sUAhNKC95mpZLSq+2wh6MfOk8SOxxzp/KMAqrva?=
 =?us-ascii?Q?0OItD1w7WY7YHYBoNTc1R/Vstsq6jGKZkGsCgMksET3HCggqo56zJQ6sHSzN?=
 =?us-ascii?Q?qF25GRnHHsx7SF+sMSG5EsG9HuE4cikH2o0xpSKDqgrxwJlRV9BMqt2wue8q?=
 =?us-ascii?Q?PR5NUAuGvSk3FmYNjBx234DOeOwV2RDuN+E2Ip+tljmlGdCidXbHUGezu/vY?=
 =?us-ascii?Q?E80tXKm7a1MR+mAw9VX5R4NAI/wnt8qLgQ1aqB6qRPM84ZXB3QqSZ1T4xi3d?=
 =?us-ascii?Q?chKUuqIvA9BbzMUETGz7Z4kJWBkI4NojdRvwVh6svf0UPE0CSnuDs1boD221?=
 =?us-ascii?Q?jBg1z0MwLuWu2rwKwhYKJlcf5VrOZ0dXcFcQKNAU861blpYHC98EV+w1mLrN?=
 =?us-ascii?Q?3K/zIBn6QRlye6PeoFJLqz5QtOOR3eogAKiIA4QjhGW1LlpsyBfOOVdLYOtk?=
 =?us-ascii?Q?aFNmnIc25WCUe8m7ecRWyiA3G65txOONY3+xegMPtz4ob3A+ZdyQiabEKalc?=
 =?us-ascii?Q?v6PxhTdpKz66CE8jYMLTx6AA+d7AScw/sLo6wyn3vOGbGKEhBr3ndXIH7kT/?=
 =?us-ascii?Q?rxE0kRCp4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2327fa-254a-4870-bcd5-08decb95b076
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:54:50.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usbXeTtFqlH2rHdXMwI21+CULEEPbir26MHbUXCWS99fJTNxDevdlb/ccdnkU8pbWcp8DFGMKOY6sa+H1DLqFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299807-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B13B68E836

The blamed commit refactored the prechangeupper event handling but
failed to actually return an error in case
dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
on a port which tries to join a bridge. Fix this by returning err
instead of 0.

Fixes: 45035febc495 ("net: dpaa2-switch: refactor prechangeupper sanity checks")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 52c1cb9cb7e0..46ae81c2fa01 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2177,7 +2177,7 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot join a bridge while VLAN uppers are present");
-		return 0;
+		return err;
 	}
 
 	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-- 
2.25.1


