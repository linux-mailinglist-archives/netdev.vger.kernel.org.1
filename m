Return-Path: <netdev+bounces-214964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC72B2C4B0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC5624060E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F935082D;
	Tue, 19 Aug 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDebw9Ll"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F780341ADA;
	Tue, 19 Aug 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608438; cv=fail; b=sjRfz8ApX5uhuAzvFubVnISvqdxBPoyX5Ss035IeH98WdB6tKXh4OTWNse+jNot+S89uaZ3KBrcVkaxQ9WA4EYNTl+KgRfeFNwlvwZBuPrHVCcrrCwodgiXsx07Yo/6UEIUymwgPTDPuWuV+ZI+9zE8J+moKO8EnX7LYKL1XR4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608438; c=relaxed/simple;
	bh=hF5UNdOdmYEvr3YO4bJQXUPYEmdEGigM7FH1BEk/g48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cj/Bhsh7FECevd8Q47LPLXkoR2gE6tg449dVxD5nc/c7x5uQLpA9Qv/VS5yRCB7z3v+2kQQd0JGN3Xp+ZHDo4GUWqy/B245EeuM88Suw7vv25fa+OEj7rxxCBZV2R63dW2KzIvD/wgq2tluCbfeu33ZqJOBkkwfGB7tpN5VKHcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VDebw9Ll; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHCCLsENDiXYN/yn05R2z8tBseaMVfZBybSWpOmYTM6by/oDDQnnYLXm8tYdBYHDHFAMdoJ78bk9Ww/1gq/Z2dliYZXQ58JRoOr06nRJy7aMTtPIGQUPSKnnZkWaggw3sYmZ0J8bWT/dIu1R4Hbib0puwZMirOgnkcDaCgkC1DWOdwR2dobcLaD0ckQHTik3mz7rn20IjfrpP6UVRDeASJhczWH//mdD97P/goXS9vXyHBeidIClRQIp/8TYRUNQnbikRpwmWvxPXsNRuuU82dbrTfeV22haZ4DYWaTVAavCg/th6P7Mn903rW95FB01rfoEq9OgK/lLw0Hpu6uRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=BAjbZi2oQydQqP3LmAGlkP0AGZVfHCBevFutblhmNRzCIZJ0FPliWkJXlLs9vHSeB4adnlasWGuGkBQZUigchV2RKUrdW3svpa8WNeNM6dQ22RaVbz0zHh/tM2Cja5tI/bZNFSJeWtAAYtB7snxyQawvJdecAJEd0UXiUORz61hwmnyuWg00JJBPLPbVzi/FlXgG12ZdscDZ2bVhdLTKk3Ji/phO2lG6ikgzekeg7m+gesbJCyxPrx028LZoFjFpO9/PzyrQTHA92oYS4jW3nGWVbErM6QGPCyXOFpS+DYJnU7mlVXhPbxG/EWGs1Cp+le3+gojSANOVKzWjE83Mgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=VDebw9LlRAOu9ZxE1sSWIRkvU9ZWbERIVuFwqsQmouyTbNER1i8Z9k06bnnICzs8lmiXao8VkVDqLnj8a7kYs3viQ4Q0MeLftLzfTEbtrn1SXjdWP5Roh0p4Qvh2qSyyIFk5bokqmdd9WBT4SOAueK0MH+DJ4w0XMxexOLrjVjabV+/TmonVgD3/r5PV0iSGX0iaV3SrfEs/IBKj8AuMWm07WwWziYYrSSNt/UKC6n8TIeLZQLtLbvH1erTswwGY975s4PUsS+eVZih6cyjo2DtDPoQ8MlldkiU4HMj6RnbXgsQgLYcj3YheKq53+rA/GtbFPSRBZUyuy5V/8+wRog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 net-next 12/15] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Tue, 19 Aug 2025 20:36:17 +0800
Message-Id: <20250819123620.916637-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 39262989-c452-4e57-43cd-08dddf203fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tu44T9NglIzLyL65biItPb6IGA0G0fhZyopmBbMP54riVGa7SuGCFmFewtw?=
 =?us-ascii?Q?62Ma0ww/8VnarIFHhhUr8/ICnpxpRYSVmgh6lzYwpqGbz9mKgPxaJsZT4SMX?=
 =?us-ascii?Q?GswGt73YruEVoJn2FF8FmTV2WijaNH9ODLI9ghLeuxrTB15sz7VHM6amXCmk?=
 =?us-ascii?Q?zhn5HuVMe/X24mgCAXa89NSfbm0fppQFdMUtRfR3V9kgELJsfu/UcjB0ghAv?=
 =?us-ascii?Q?D1aSMy8QZ38+PJdBfI0iIreywbbVNxoLvT38fMXNhxpNzaRjwpijZtZ0L00a?=
 =?us-ascii?Q?2ubxvQyVEmhc3yqiBq9Z6+Y+j/lM5h9Wsf5lwLBQPWwUlqKW1qdGwXfegiYk?=
 =?us-ascii?Q?oj8OKOMSF3TYLvt0ITquIc+lEhqGYZCMwyBf+gcLhWnUmtfF0EH0524lrtj+?=
 =?us-ascii?Q?7D0oNrN9N8eEGX/YraWWLBE/f/WLyKk0+UuIdNxYv8Ya3E8Mr/CZnwFfZNb4?=
 =?us-ascii?Q?u4LZW2WBM3pu/fmF3+XF+uqCB62vKWvH33ttb36nRZx3Qa0uV4KyNdkBe1du?=
 =?us-ascii?Q?3skYXbElaaAlUjK44KTmkMqTjUj9nRTyqijTclUHgNHHXGDwt7h0FV4SSaJL?=
 =?us-ascii?Q?M7kM5D0cpgWGM0LrEzBmrOnmGrSVtAO+q4ngKGwYZaTxq1FhMWsrzR6mI22x?=
 =?us-ascii?Q?VoOB5AWJ8VJf2p806QLYDjXsjtzMM+aXXSNr2xWHWzgJdZqESdmwLKVPtXJH?=
 =?us-ascii?Q?X0SQYY51HpkE3AxA9ibD5Ru+83qrSxuMkeIYcPisShGOlheI+pb9oBklPpEw?=
 =?us-ascii?Q?as7HI5KuBm+cyYkfBCGArpEuPwo4N9SG9mmbmhE9bBVQzVlr1Rwa+YtsHcd2?=
 =?us-ascii?Q?IgZkS/HgqW0zcwfgI/5OWvAPVENj6X+KfUDCaieLryDNpdnnyQlwavbu/In8?=
 =?us-ascii?Q?8FLoh4t3zEhoDt0idooLGNOYKUvqr6qQgA2IfGwS4VN9RFg2uUb7HXGisD83?=
 =?us-ascii?Q?q08Sqz4dSMYeOLRfi2IFRro9Kw2Wb19xJ9xZ9hcjbgJ1iu1JPcUwwZPb0b4E?=
 =?us-ascii?Q?9M3sZV6dZo11WhsBjr0cNRVvRKNmYO4xraOgSjGmAID2spNmZlYlHxaQqhD5?=
 =?us-ascii?Q?24uaDe/wIvGCRJp8vOTCqYB0XWfKMlwxB2xROaAJMUcwE27ID9+dt+HdBic4?=
 =?us-ascii?Q?mtciBQPl626tTU8jRJq9JuejIj7MgEAuYJUfkEarrg9AAPf1PkX8k1U6goRJ?=
 =?us-ascii?Q?RkVnDyz5qFBOV24j+0S1lK+PauR+2gTLQvRclp7BjSj9vp2ax8hwK9OwUYAP?=
 =?us-ascii?Q?PLNDq5gXQXpp3w9kZzXpMXqmLHqL1AL8cyq7cVwIFhg3yW2R5FNxoe8AWPc4?=
 =?us-ascii?Q?MRY4JmPvEYrFGg7C4LCaj2r+l1RYKu2XjCXjL4y4P/8JMAmGKTvK/ap0JKr0?=
 =?us-ascii?Q?DeUiBQjo36rpp9vz4gXDJYLiF8xLrIeZ2MKNK0KAvj746MdqlxzQfR9a1Ske?=
 =?us-ascii?Q?Vt2U2BBewTztLZkphUgEaLt8+NF3dKWNgfHdmITYAEgifc5AXRCMHRsM76s5?=
 =?us-ascii?Q?T6b4YMpXoUEV8yc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqime7cn56sSwo+GgEkuteqc/lBq27K0Q9+IE+QbQFoyODkNeWi9zKxZ06cG?=
 =?us-ascii?Q?3bGtU8w+rLIo9LVcBZGTHXethngLI7adRhGQNamQra0n7ChWM3kznz9DEQw7?=
 =?us-ascii?Q?e9TqnAQwpQYPGFTXgaWvLnxHefb8KZxY6L8PBj7a5wRO/vD/g1N98XbSzZWl?=
 =?us-ascii?Q?pw83lkQy2mW5NbiQVTyCfimBoAaT/BT9voeSxpzAlaDXzYK7XURtsKwigOTe?=
 =?us-ascii?Q?PBazCVdR7e5qoO5HjH4IaB3QINrZWrblx/qgpd2RsJv8E1A5I0hgE9ANzgqD?=
 =?us-ascii?Q?jNQlrwMCKbktAwYOPsUl89DHsGTu1bJOM8by4MN/Bok6MJAd/FhymjaVeEn+?=
 =?us-ascii?Q?dAqqmEwrKKugdur04MyE/RrkTg5Z8sqhlsxoNYTYIiqx1GMFHlUjRrPvSQxa?=
 =?us-ascii?Q?tQiSwxc6eF9TvMpq93LPRvqK+dRZy3j68jYUQrW/tsCDtIyJqVJLtMk8LyPT?=
 =?us-ascii?Q?BRiv5MHaD7+QBsNUBjatJzAfQvnWfrpvjs6HKTylojY7h8xF7ogsNqk30PMu?=
 =?us-ascii?Q?EzrxUbfLOoBcY8pqr0qxkttKIsRHm68n6Orp/jVAfp1N8Nj17+dFKVZRaYTc?=
 =?us-ascii?Q?XWQ5obEZJPbC89wmRsA4BwBDYs4cDyAjW+Wmj+C9/ruzr9530t8Mr3CR9yNM?=
 =?us-ascii?Q?5FpKj3TofAdZ+NstZhUwol8e4ivWT4YdqsS49Yokmi9ZDmoXFdC0AvGHmlWQ?=
 =?us-ascii?Q?D4vDyYru8ezYWo4ISNd+DuKUWu1m9SQgFvpY7D9xENquQAzeKwN5LDs1qCrK?=
 =?us-ascii?Q?V4fCBSeOgZN1yT/crZMPZVyUf8K6pezJQ0nhARotZuFzHNcv3f/0tXprNxi8?=
 =?us-ascii?Q?7S0wG/2BrGbrsEfstTAxCEobyln2CpLQtwHrhK4NWtYxn7jN7otNdaYW4AD2?=
 =?us-ascii?Q?LZly9FvqyGWio1WIgyskA/tcreTFdhb3lMLDCCV3EgFMEr+KTBp7dUS/U4fK?=
 =?us-ascii?Q?BagYdq1+o/tBNUA7FqLtwMfi3yLrAARVoz8EJCDS404WbkPuk8sJSJHjChqW?=
 =?us-ascii?Q?FbM5w2mv0r7aNpppWJ+t6LbNtkI2na5VYUFmE4Qr6GoEiuOJdGdjEasObEsa?=
 =?us-ascii?Q?+o2YSiyu2oBWdK2RHvQr5wBQNLi/JHqM2rZ+KtI0zDTbYEtd67xHUefRIwBv?=
 =?us-ascii?Q?J+Cp6ojxgC3Nsns6WzAqE0ShAUfHYGgBWk5AyCsbigvHJbOeKeKW9bTTlOXd?=
 =?us-ascii?Q?07uZ9mHkeKtoIZ7KwwZhNpBNrOY9FEjcugdyaCvdcs0yMvHEVOsUIN9eIwRp?=
 =?us-ascii?Q?cMYQfyx53JRRoWDAL9VqkOMnSpbtBRivm1Q+SiAW2FeQh4IB5MxLzub6Cs4c?=
 =?us-ascii?Q?16tTTFsfVnOAFCnXGOPEMreIhrVXaNZAAYD6aV5VY3E6A6OehfzMWy5dxG5X?=
 =?us-ascii?Q?kQxDGjAexzimPvBFqRJy78ktuVz3/W0Oj53Egk3Ld9HTaVw5x9WmPE1LJCGR?=
 =?us-ascii?Q?1lhWpbcp46qrMGPzGYfdj9T1es3crKGI0zACEgg4DXO7HGnj7D67EvS4k5Hv?=
 =?us-ascii?Q?kN5sPZXeSzGMTBkbEeU9yxt9unhCj8Ja3zQ/yaphe7TlSrrw7+sXG3QSlva8?=
 =?us-ascii?Q?UVwNiFNNV2mpzAREPV0xXxZ7XpvZcw103TrO8Itc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39262989-c452-4e57-43cd-08dddf203fe7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:36.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48PCweie8B9dDp4jKMhIoPd23uZXOdS0ncmgNn053ESfHvohUwXWf4xbjwYQrn+CPWyoE+NiIaxO4IiBj9/CWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


