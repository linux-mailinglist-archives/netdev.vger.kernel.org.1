Return-Path: <netdev+bounces-251061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE28D3A887
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 505D2300EBB4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44E7314D25;
	Mon, 19 Jan 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b/KAuiXd"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DC27FD5B;
	Mon, 19 Jan 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825211; cv=fail; b=cMekfarbQq03C/hjkk09XhYcy5J343+Z9ofgS5pdZ4ZI23Hoh4RPQQd3r5Wcxg4Lc353j1ZAKPiLfn3g6veqqCrwNFeYs+nEE0LuKbIbDJfp4Mc6TOo1GricQyn/BCyUu9t9McIV3SWAiAo/oQqDu0LMUSBWF2+AFznSKfekV4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825211; c=relaxed/simple;
	bh=iDMi31sJ2wHq7cWyi51LShzd5DFkcYP6xjLX3vSkBwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvBecJsOLln1sFiGubMP2kEaFR4TFT1kTxzEVuiq5c0YVkkwAwZQ+9fDdsKfmJTJSZomsIsbhaIZzrp+TsGmVmbRWh4QUKMp6Ti47+E9aOIVzrKwntLyJA39tIYH/Fct5ko0KCtA3YYjo7Ad0kcBxrvqoMXdzDut3QAs+9NLjVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b/KAuiXd; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7E4RcRscSp6BsrgT1n/fC8jg4U6xDXeZ/EWzzHZ7/AkYW+2twzugbygIM8OVibYx4KgZoZm7nxPlpITmqSk8akhJG2kv02d/mS2yOZURIhDtc1n3Ojll8wLzb3QhlYZgjRZxLZeTIvCGOiFFsrSSMc3Ac0+vRJnhhMc2XVg40KTND+k5PbX6OueNDedZB7DKn4XxC5GYknlhiZjqx2vp2KakTPoZZMqTAAOdDVWEMHk5RqQ176yixE5f9oHUr9JXN5fXNPQiJc8XhvbPEn33JLdv42Mefk0rBNQhK8GHPuqAaPiSM9kXh07ipXnZKEW0/JFp9pgJR39gZxZ3R+QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsvApbAT2FOrbl+bCtAQMonWhtPIBDGr57sCQgKuieg=;
 b=zUzJmFHgI/OpNzL8eMqgayFRr3LBw12IGvVto9mA58V4oBzDWtLREC76nFnVbbEmRudrPAZcsq9UubDf7gNqAA0mUVosu1zfwnG0nlxH1x3CLJQfN425E5maNuRzQyqmetViq89SlVXFyd58QWTlu+hoTJg95zx2KyIz9mDHC7MfxrK8CF0Q0W9uD8pTueqcKTC2fcewNM9EuigrYp9I7Jay1GZ4HZSpwDaemupa1XWCeXAwjXIgNa6Squ3DCJdneXY2HwC98oo3SiS7j9Y/a/iPTsU2CrYlKPGBKlf5pm+A4t2Qso8xj/ZL0sOEAtiy6B012jOJO84bO/WLSVKBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsvApbAT2FOrbl+bCtAQMonWhtPIBDGr57sCQgKuieg=;
 b=b/KAuiXdqb/+TSV53q2DfGCoABZT0ptb2oU5a4GYh3WgVDd/SiZrOKdYyQNUPBoJApwhM8rkDsOFgfDL82oOtXdbfNpyNEA3loFCHiCJk5EaP6BNOL0i3OwWxbdWoeLSDEBKaVBNjgVPGzaXHp6OQZbh+43Ws+WQYfbWjd+i90td9k8aI3tSnPKIlaXE2RwXPJ4CoWobSF8W9V9FedLCwcMaiggjWbC1591jrxcjAxWuu2iuICN4ka+5zlTUBcNr+V4huyGt3YQxO/GaC2F0dRjfWd8yBStYe7gyB4K2mDcK5yaaW0zfcYtIV0gRtbFgmuXnNJA78J39H1kO/xA75w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:20:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:20:05 +0000
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
Subject: [PATCH v3 net-next 1/4] net: phylink: simplify phylink_resolve() -> phylink_major_config() path
Date: Mon, 19 Jan 2026 14:19:51 +0200
Message-Id: <20260119121954.1624535-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd21293-80a1-4326-8b14-08de575513ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ldIoQELgjx4qINhqT3mZwmjVs90rjwmz/pBEIZVkrpZEK60hV5rtvokuFoW?=
 =?us-ascii?Q?Fs/HyGzYxqE46RDryyfun7CrwHCLYFK1BipjBbcY6dJH/wL1NAFqx8NjNnrT?=
 =?us-ascii?Q?NlVVzk+/Rr2RIHZAv07agt92IY4CK43Mf19ycXlmLs1fgdWcR4vlIVR93yCg?=
 =?us-ascii?Q?5r4y1oQHvMNhMwo1tEaQQkU34kbDaQxDtR5ZTmKveIifOuXHnVLztj3Mt6EX?=
 =?us-ascii?Q?gj86woUOQjvMa/ZpOO+joID2ibWF34TVMnu6MwSCSnNyhfNYqLwRkskP1EF9?=
 =?us-ascii?Q?FtnJta5cOIaInbWwNM2zeo6UH+mQG6mm888bWxnmSOK0isQfXluerQY0F/MZ?=
 =?us-ascii?Q?rRHVrWPgGTZ2crqmtwAURX/ONDex2K9dYLJEyLHlQLWd2/1JJnHA7pbJwuko?=
 =?us-ascii?Q?tFXaL0HRBbZkPSJRZtAAgxH4bWAPkzdS3zX/x9n2AZljJGqbKo4tMuCoK2IM?=
 =?us-ascii?Q?KWA+iNGd1Jq5c7UzM9tcAVlopyBsbnXJ1NBgW0zyHGH4CoGx/wBxBTG0GynE?=
 =?us-ascii?Q?/6OVYk2byPEFIoo6KonrwxA40EIPy8j3FNQ85oh06jaOsz1hE9FwNbuX4wVv?=
 =?us-ascii?Q?/37EXv7iBF5cIddUOHFowVXj834S7MrIaKUXWgk8wIhBDNwBDC8ID4sVEMYL?=
 =?us-ascii?Q?vMOM+LN8YmGULV7eU5zLnyKC2R9xIPCD5dSJ8BX8KJ07M5lanFkQGS1Ugvfp?=
 =?us-ascii?Q?ymxCAyPuDg1AlUjs5qH25LQezeUqtPQCLSLCKNSIWvHAZ5fOnds+nmQ+mKht?=
 =?us-ascii?Q?GKeO0qBJ2LCSbJUMiGs3Ii4L+SlJ0n4AaA6jdHBEaQUjw2r3JbUoWiLHW2oy?=
 =?us-ascii?Q?qlVsTkVmfzMNzU9kHHDqlTnYqlLY8AvQ/M+OrIxRZaSsDfls10M1VvKYCqDn?=
 =?us-ascii?Q?71RAXBL4K6WU/Qv5jdclIwODV2MJTdGIx7DnF1GqKE26KpsYoxE3geJVzeJC?=
 =?us-ascii?Q?qKtkluQKftnTZEYjiD2xTYr9Ut4jOP6Zh2r0O3epG36YpvvVZXm/5cDNZWcs?=
 =?us-ascii?Q?WRyHjxaEptoP4e6X8ShOlBwCWo/SRms4YSfyZ7XaC0r+Sxc1QhHN20JH9cxt?=
 =?us-ascii?Q?s1ktKWIgFekDWkJUJ4/v32KY8nTenn0V/9pgjHM6SmC7Xge5bEvuLBR4aXmZ?=
 =?us-ascii?Q?Jnkh1A/rtebjllZ+5/poJ+OMkiV6u1Zhd8New4n1J3Fxkddfh5vW3Zo+Jbrl?=
 =?us-ascii?Q?UTJjlckq6bk0FVg4X+SK0480F3Iol2/D5Kas2YLfg2W98QW0XbnTqyuly3nr?=
 =?us-ascii?Q?Z4audPyzsZ6jTtcTb0n8g+cQ5gKY0P+w+W5Dh5hR2rCQZ0gwjHzsFcf03J7U?=
 =?us-ascii?Q?E6c86EvzgsaqFjlQqLmODf5w4ID6S+qyqgloScvPy3Lf+zo3tX9DBPDEErNV?=
 =?us-ascii?Q?fzEfPZmnUUy11QwMCnl8tk8XmPRADCCa4t31LDKC2Gj1GUu+RuBdw+D7MRum?=
 =?us-ascii?Q?wsdWxF6V/oZKhdBDP969FfbtqHfjCepUEFnkp7guMUylafIWeKUXwiA6Vj6K?=
 =?us-ascii?Q?Ilt/nYG+NAQk1Ybwbq1kcBUN2S5tGKyZPkzHrl8UdFpwWoTxG7ckcMdxzfDi?=
 =?us-ascii?Q?t21HjTZIIBrDpJjDnEEiRdnYrKKL7CstEMD+hAo23x3oUC9nX2/rnlQOiq5d?=
 =?us-ascii?Q?YZ8OzsQzTIBTWNf1gtFO0g4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PqkOJ12oMFlH3kNWbm2BXucWNbJVC7XZNujDxGri+jmYshz3Nfor1MYEtkQc?=
 =?us-ascii?Q?1mZlAtm7y2HvxcbDORO1MSi2od3wGPeOW4axbGleSvq7u4OZinuVyVEivaEL?=
 =?us-ascii?Q?lPr33JKjizWTs6hu1TMSCdtdPqXYY9N5cWg13gszG5JorkT5DyBR8PBYILXu?=
 =?us-ascii?Q?ID3lehobLFRAfNMfptrlyA48xdsTCOEmckWQm5ErPVzrh/af+EJRzFLijg0J?=
 =?us-ascii?Q?Pg/yT6Y56Sr29kvC/bJzLkSkU9oKkuiipgpJZNNvAOl1Y3wk9gLq8DueB6QZ?=
 =?us-ascii?Q?ETFQHPBTJkBK3DRhoMohvDgdVYVyddhZis7u98zKDmjJPJ/Q9jcgS5AkqY0W?=
 =?us-ascii?Q?9+NKWWAsuaECGAu2iIhJ+sQMAHrg7zBcLAVyP20C3E5X/w78Qf+RZ8/inJOi?=
 =?us-ascii?Q?qS8jH4gGy8V/1TSP9PNFb5QffmBRh6N92t+Mb4ChizWC8ZoRmn04K92V+F7X?=
 =?us-ascii?Q?3jndts8KrkWHhfdINRTidIwAqoLGNmj1oOqq0iKBpAJK14x//Yqk+7anCUL7?=
 =?us-ascii?Q?gJzFgOeAOPmI6SWviNVyPahTQ11p9vlYm6QtbHUAe9759NYKNNpJ5tW2TOiZ?=
 =?us-ascii?Q?pja/ye/yrlJTXJVhY/W+7fusdNNWF9fcYQAz6UouIDhOvew3huCdrmrmGg+9?=
 =?us-ascii?Q?irGW0fGhBtkmhzNycxqIenGc6OTBN6Io+MsNjWe9xNf5tBqsYIiB8ZqeBPGE?=
 =?us-ascii?Q?cjwbWwegWR53HiXjFCh8LO/tkVp3HODajzo76UwghIC6eQa9HOu5Moqhc56W?=
 =?us-ascii?Q?FMGVXWyDI7xcjIxUoafMoasNlBJ7s2iYGokTZ8HfoC1WHSvjqfV0wtSzpHmp?=
 =?us-ascii?Q?YExxqDkJVDknVGlh/DGb8b4ACekaRG78ETLFodQCzudnJedp7U5MlP3vMx52?=
 =?us-ascii?Q?zCnmN9H8HaRDhzDYH/LsaSeErzcIs4JOarfz/MqMS3mPKxvl/2BGzlLCgbGH?=
 =?us-ascii?Q?xMZ/acfoH0RFlxzZgSmAuu3CjxYxotTiRogyXdz5w8OuIt5F4o6stX1j683D?=
 =?us-ascii?Q?glcMjbRXrBmrRuPTrKMseVDGaWzoUP4IBhNlv4BNtuN16aidW+Q7AL9PBUow?=
 =?us-ascii?Q?3WCmluuWm0oZLTjXL+MFeotHG1Xv/3xs4yTxknr4weJtEcrj0mcrS90bj2M2?=
 =?us-ascii?Q?phextcMS+GKuObo65KiyNOjvLQ02mMiRZmbVgtxNJbnn7FF0WuGnKUV++lvu?=
 =?us-ascii?Q?WEkahSDfjSoxDDEzU1xT7XnuSH6R/z8d8KtvqMyVZVDR4yCq/gzVRMmkuVcI?=
 =?us-ascii?Q?CTNVBewV+fbrL1IqLzCK8Kb4w40XKVmkC2RqEXP+MJ4hnyPyvmODz44h4ze0?=
 =?us-ascii?Q?19UK4BO6nliLUeiGYZzpNM77i1cplrr5YlzK7VgazcQFq2anLfbtnkRSpEQ2?=
 =?us-ascii?Q?nl/M/UXuP+i0CbjSbkk66yCMXrcQ+8vulJ5/5+yEvnuLDU8RfXgcsRRzJji9?=
 =?us-ascii?Q?UJ8DqrE5p0d0U26OCzhO7kXliX+NMWX+50ufmfGC+NdzQ9tQpts2hNq8U4NW?=
 =?us-ascii?Q?LRqAfHj9eg9y+zPB3Uu/Hh9ygCKg1xrj/uRDjVWkC/qCui7g5+1QjePvXLdI?=
 =?us-ascii?Q?+kx0gcYDn+2qkJmnNRjoDP+zZtg+P0Zx+4OtItt9eCklPhlrOX7qWdoxnonr?=
 =?us-ascii?Q?gfR81YJ5YmQ74h5+uDMPMS1YkhYz2B91EEiSweE7YZWKDRqM+A/pDHv3hOqB?=
 =?us-ascii?Q?2e2a8TE0RIN82EKMvAQdM/W3QotvT9iwy23KozbEGqpiucU7EvZJjK7cmNYE?=
 =?us-ascii?Q?95wkfx84Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd21293-80a1-4326-8b14-08de575513ec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:20:05.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aoD8M9TdkPzgUHz/RFdu3vWy/z09L3BiAKVYTx4ev2lCajEuEpQ9pxcdBvbOj4tHqBctBJ7pNsnNxOYHQVo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

This is a trivial change with no functional effect which replaces the
pattern:

if (a) {
	if (b) {
		do_stuff();
	}
}

with:

if (a && b) {
	do_stuff();
};

The purpose is to reduce the delta of a subsequent functional change.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 43d8380aaefb..b96ef3d1517a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1683,18 +1683,16 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->act_link_an_mode != MLO_AN_FIXED)
 		phylink_apply_manual_flow(pl, &link_state);
 
-	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface) {
-			/* The interface has changed, force the link down and
-			 * then reconfigure.
-			 */
-			if (cur_link_state) {
-				phylink_link_down(pl);
-				cur_link_state = false;
-			}
-			phylink_major_config(pl, false, &link_state);
-			pl->link_config.interface = link_state.interface;
+	if (mac_config && link_state.interface != pl->link_config.interface) {
+		/* The interface has changed, so force the link down and then
+		 * reconfigure.
+		 */
+		if (cur_link_state) {
+			phylink_link_down(pl);
+			cur_link_state = false;
 		}
+		phylink_major_config(pl, false, &link_state);
+		pl->link_config.interface = link_state.interface;
 	}
 
 	/* If configuration of the interface failed, force the link down
-- 
2.34.1


