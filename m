Return-Path: <netdev+bounces-239686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E0C6B59B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6A0BF2A042
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F8349B05;
	Tue, 18 Nov 2025 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ea4Ia+un"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F72F7ACB;
	Tue, 18 Nov 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492764; cv=fail; b=CJTRlfGQflXTFRQ4TWfdgYnWV+foI8oNaq0SJBE8JL6ag3oq3LGuJ6heuxRB+LJ0PZ79eUxR6X4iJZ+9T8tBPLpdC/TYMHn3cYfXwrrqgOULlgVoK7Xo08QEatj3OryAjJAmbUuUeKUW8y9+AFuO1TOtdHp6HFdA+y2HSBuaGyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492764; c=relaxed/simple;
	bh=u9fkNn66G4TGtXp8W9cP84Ch0Or2WwBQEGOQ/wKYGHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpFdjFBrcOPG/gjBu3DirEBxU+2LgUmUGITSKn7Og31555uc6mKaMaYCbYLVke3Qby/IXOtUKQk/TBG4SWQrZG1nOTgRLIKHKBYrFbMNIAiktG6YE7XI46dI3qk77a5lM9SCjFFbMfEv8PJ+Ax9jBt2OgDeWdm6wNXDA4T8ahkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ea4Ia+un; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYa5KszfpsjQ3xbxRen0lPBXeEhdbBKFXitr6aYvunVKjExy8KEXcFNw97gbD5X9NvKfGAHbYqjFu2/ayRaoL19Lyn6Nd8ZcJXMg0w5HDHh2CwBxMaiEtoDYpB3giCbmGp62A5dBTLwSYehKrYJg5DTGEzXHJ9VvwUG2qeDemxyZKKlE4u2QbTbHerNoRxQw8ebzBwyjaFWW1BTwEj+wa4btVpsO/4UZwgSBB/MNr+zzpu0BK6IzlK0lOdX3mU628BycB0+tJcTcvS2tIJc14zzNKKRQQtqaGoyA2swy2CyTHWqug53O5AMjh8S4e0JgT0IRvfqQFzSmPLMlzjdYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a5lSqa8GBsDbFz8sp3x49Kjk+tlNgiBy57EBHlm6qs=;
 b=aDP42t/a0iYYQtkVY94Kdui14YTbvwKg+hGaI8aWpOfDkt8m+8VtNPP0WknVMErfApL0p5Hbk+LYEcSB+4z7ytGF1UhdA5mUKG2WWnpt5e9zRMnaxuF1PO0+/vKR28MAkSFDWWaYlDo1pVGuhXSoDqoajnFnqgpc6VieaJmo3wQOjxAVqsyBDy8zKL7iCbFTb3xG4tcjb2tRhiE0QorOpg5SWY/WgGnenZVYoZTTXYGMVELPKi1b4jX5fMTOy7mrewMq2wmbbffm7m+05yzNQpe7eK3GcUW1PF46OZMlMMTB3aoatklI1miOJFYim56L+DHOp7w8cMBTs5vY0u+s5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a5lSqa8GBsDbFz8sp3x49Kjk+tlNgiBy57EBHlm6qs=;
 b=ea4Ia+unHNKBohsZRs6DKQGOJEtnNWIWL708OFiU9I+wqJ+3cHvBP/VWx9Rp5vtvMJ4vKQRWjIzL7X6bPEN1vfOlXU3awQLFsWBKd9bN877Hapq6BjmPz9F8qAA6WU7keBGM6OLTOxge1vf+fHzrCsGojFbrc8OslgZcqlOByX/M5kRqYZ2ALKYxMxLGnqDSSsLbT0wRpNZh7X4d3+UKButSIwEzROWwojAQLSwgV5P2gG8nG0rqeakaUShwBVlH0oGcQecHEw7mKkFaSW2WU7XxfOVyptT6bgw0FwO4ifwTAnG/3gtBLZqyyZyWeDgRRdwJxZ1qSdRBNc4P+pqKtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:54 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:54 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/15] net: dsa: sja1105: include spi.h from sja1105.h
Date: Tue, 18 Nov 2025 21:05:21 +0200
Message-Id: <20251118190530.580267-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b10b8c-4a23-4c69-ae91-08de26d57f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybBytcK6p4RiUYSDXzSXHR46PeKoKZt0C0iE0sToy0j+96aRlQt7AObUILtO?=
 =?us-ascii?Q?iwOU2B6Xb/ZLFVxWCFP9gWOp5tpLBJbau8K/pPI9r/6zWeNvDJw0qXWgMOp5?=
 =?us-ascii?Q?cWf01SP+PMweqUzkVxB3gvgX+OU2L90zwbo4QVoGq1grW0W9tdFA9hPz9TIE?=
 =?us-ascii?Q?z8P+BNMW04du+Q9qhtLZ4CLRt9btsm53ztLIfi51Em4aW9c97uTY9Hobpok/?=
 =?us-ascii?Q?xrBW/VKKes1qN3JKjPEW10lZDsR5O3TkzdKH8wGOCKAvvNMWMf9rboxZ7b4b?=
 =?us-ascii?Q?lp3tTS8f4tnXuLlIs2AZ4wt2bx0S6B+9dXeHdGLLZPBmnvKZ7Xi7x8GKMqnr?=
 =?us-ascii?Q?cLfnocqyes52FkIsjgAFp22LIetJMmwYDyXw7Y12/Pf9lMxPUS3N4LHsITnw?=
 =?us-ascii?Q?znElze5wcsdt0G0OTnPu1P0i82MlI6eJHyMpOeUScrF+rxarA2OxS00ucKc8?=
 =?us-ascii?Q?x+I5mmmhWZy1p9V2dBGOTTV3rY0VKJ8C/MQ8Jl/xEOjbZAzJWezJbt3rWONb?=
 =?us-ascii?Q?wepHoLHiwVinxD/v30KQJTGOYUKXNiUwT77C+/WJhpeS5WzEDVBdZ03BvepR?=
 =?us-ascii?Q?0p4KmmZ5dufCf518VhWhBcTHotii5Zk5MoI+B9FbtIULzWdm9pMrChDi/HcQ?=
 =?us-ascii?Q?LyxGYb62G+0lllKm/eKhiNZGLtFL9A0scXgGnYl1mGxPNQz9OsnUfmiF8w8v?=
 =?us-ascii?Q?XyNS8O/K9TMY13Ott/GQzEz8/8akRFK1VedNJZ5TEq3E7stTpQjSKnLGcKSF?=
 =?us-ascii?Q?vEF3jaq2XmFxk3xvdIyJP5UegwU+EFV0rE7mj6PQVBc3mr8czOlZVGBZGMgM?=
 =?us-ascii?Q?6DeW+8Zlt3x6Zih5spAxEHaVkigwY42OOPbCiqKuHpff5KDFRVzSh+wrZvDM?=
 =?us-ascii?Q?+0Gv/S8fQvxGsQj1mfxWM99PoCJ+Mk2LSwKvQHiMuduVRpSkTc7MnDFSAXmr?=
 =?us-ascii?Q?ODpZ0ebH+V0gstBbItreNgZRHG4/BgDxV4YIPcPc+xGS4yOZWY2GAgCATYr4?=
 =?us-ascii?Q?rvoKF/54q6Ug3MdNIrkFPIibK7g/lS+QjNNqhKRfuzLsBiQ/0DENCcvz1w15?=
 =?us-ascii?Q?XURZ6HGsWqQ6b+jPghtYcuaADQzfLZ4Z0o7UBhRwXN2X3Jj6ufbPcZ/HLd96?=
 =?us-ascii?Q?GMTRAtLXTQ1SYs8byqx+UoK/KemDRvps1m9HBwBj+iaJHxqVNbi3lTxnDPae?=
 =?us-ascii?Q?AlOUeWuYcZlP3ajSWRry+p11WR32at8OCPx9KNOZKu3kUgiyDflK6UTQ/rxm?=
 =?us-ascii?Q?SwH2I8fPhc3fl8E0dtWXYM05ZLgNMmW1csHRL5gpATJ+J5kPBKxzncPOcZ5D?=
 =?us-ascii?Q?P3p7+r2yoN/3uVgQcUdDc4Loe9KMLXqyAX+vrJ0x90lQ4MpGILVVZvYycozk?=
 =?us-ascii?Q?9Y3az3pSxXveer40T/Hy1QtSBO4W/F8O1qqUh8rcCFk1xTdpgnioapEBiR+5?=
 =?us-ascii?Q?GQe2mYaC3vZlom5O8R8IOqP2dA4UOCjU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQ0eijxVBQMEGP3UK3gd8MV182bHt6BEmzz9cjRO/w30YEiIkGg5C+ZvTexr?=
 =?us-ascii?Q?2JN+dBG0t7hhp6mYEFwwnkC0NHLlZOSj9sEyJnH+kBYYENhgdOHkvgaE5QeR?=
 =?us-ascii?Q?8Be7OjtzzUDcFbuK3tku9xbDbGWkvCj1K0k9+J4aQHN2hQjJszecIQUS+H59?=
 =?us-ascii?Q?rvPvJFJ0c+UGge9FoOHvwWNJYpjQPj8OwhWYXu1dqSeK8CgVqQ/F1jiMZENB?=
 =?us-ascii?Q?KcLvZqeFzDnuiGqV9X4iZy33WjchJR6w/srHLbipDMl3E7gb89YAYRg7nEtD?=
 =?us-ascii?Q?WqndEPES+UmzE23RVVvqj7x8l5QYgIbsY6Q5PeFAyHCgWx5U6OZ9DDLh1lMl?=
 =?us-ascii?Q?q3JIugW3M5DKeve587/jmW7K+DW2CHDJ1sSZAX9jJC5dnb5vc8qyLq7//8ld?=
 =?us-ascii?Q?FHcbnI82ok1ygyNl91+VeXoYbw7LNJ9f9PclgrroJ/1ipyFcdwlWolqzWQUq?=
 =?us-ascii?Q?VITmvROuZxtPpvwmlpG1gYghdsIO9w5CM5bXG3y2KB0ZaU+Z+TT/pLUFKYHG?=
 =?us-ascii?Q?yFt3WZANzgCQVQZCWh6lphTX+ZXAaaY4//7U3aQM9Om0thV3w9NTiEiL+R2t?=
 =?us-ascii?Q?w/M3UcI+vIEuXExBuWEZ0H9zGec36eGjrNR630T6oFCmVdz5JXqIC6GR8bXk?=
 =?us-ascii?Q?qaInng9DuAUC8xxC521wf2jlUNdwBjzK/3y1jSAw7MIWo1M9iA368QRbx5nL?=
 =?us-ascii?Q?hAyMHYDsMpo7HdmERZMWgVSX84A5lb+JbRNsHOTBKWx03x1t+vZaxNuKLs4p?=
 =?us-ascii?Q?3j1mwDX8u1SohMyi/qIIbKqjJ9RisU/HQNAEKjBNSXXzelVgWuo6b2HXTsdi?=
 =?us-ascii?Q?vcPhr3k3HAfQtUxzCjfiZnYVAEgVfKrzB+6CliPvOhuoad+pQWo1SdpYHvie?=
 =?us-ascii?Q?n58sXIjjHpUKqL9TxoFpjGtaLDJun2aIS9UVatJorY8S7RRE75dkhoH8XsNH?=
 =?us-ascii?Q?iuHsDZudFL3VnVEwGDSht1BSOWAGQLPZKWcrIfPe50ZLsZfsx3D+4BAI/wEM?=
 =?us-ascii?Q?sTBsRFyLPra2N5z5jEONbW7q/axro2Z88Dq5sjjcKoGZEvbDQk3TCjndZV1C?=
 =?us-ascii?Q?KZXPIth/wcNuNh7gW7NXgy9Bl+gx+/3iPmGQYfq9kEWqPDEPn2G4mBEWy5C6?=
 =?us-ascii?Q?UNIaLWzXe+Kfyy+MwTUEmIStfuNng7Z+EN7qAtsdD+qqKAie1WjlppGeOKmk?=
 =?us-ascii?Q?/QcyeQU1gdV7IHi+3P4+2XzBhy7x3ojTHcY+w5jMOUj5yQMQacbcC3/qHOE3?=
 =?us-ascii?Q?zjYRGaRLArArToo/oYqr0kLVcUdVgA/FsAU/ezLPk8r4X4Nv0hD9Bae6hOu0?=
 =?us-ascii?Q?Qz6tvN9rRoXjjl45qIb5BgyFT2E7yDDZKjUsmgXR07nzxQ8WP2irxqjf6tDo?=
 =?us-ascii?Q?farVnf6JXm+RlLkr/aRMcC6kKCshGoy0USeZLzJs2t3hHPMNqhbjebjaHkeg?=
 =?us-ascii?Q?6qN8IvZdf0YYXKIEobGi6lml8ztIWr5bIETk0y2lcCT414l/xUVzChnVGMbY?=
 =?us-ascii?Q?YeOjhPIfwM9V6P5wgDqek9eLtA+TjpP1LFhM1QTcZNuP3r3JPMyi2vMR1VT2?=
 =?us-ascii?Q?807OCZ0o7CKwZoE5mm7mjF1zi6ERQySPJTY/yruenDS3vtOR+8yIBrZGk6e4?=
 =?us-ascii?Q?qCwM5sG2D/qJzv0jMCl0Sco=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b10b8c-4a23-4c69-ae91-08de26d57f67
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:54.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6ThlW3h5sbcvJ5aL6TuJ1IMZRDvxyWergZDZJfqbpy1kybA/cMAGYmoZ+aaSFXFQVDPZ/kczAVFrPE4jymcxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

We have a reference to struct spi_device, but users of sja1105.h cannot
dereference it if they need to. One such example will come in the next
change, where sja1105_mdio.c does not include <linux/spi.h>, so it
cannot dereference priv->spidev->dev.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index e952917b67b6..4fd6121bd07f 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -9,6 +9,7 @@
 #include <linux/timecounter.h>
 #include <linux/dsa/sja1105.h>
 #include <linux/dsa/8021q.h>
+#include <linux/spi/spi.h>
 #include <net/dsa.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
-- 
2.34.1


