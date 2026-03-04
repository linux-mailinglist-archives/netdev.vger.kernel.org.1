Return-Path: <netdev+bounces-264061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FWBKRawqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:20:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B22086FF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2FF6301B739
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AC36308C;
	Wed,  4 Mar 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="An0oVEw3"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56533BBD1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662156; cv=fail; b=PFl6zQJoMQOIZCzZBmH1lvnTKjGtEVw3lKkt8iYmQR1VJJsmJyxKPZOpYxxUinXR1oChubOvVavZ/koab2x/JtgE1XNVQWJKn1E89R1X1bN47931G+zCAwVodCfxvmzGhfQ5XHj/VkJ8AINdHFMlocOWfzAWCJ9fn8bjg/Bdy/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662156; c=relaxed/simple;
	bh=c08+zqKs7OAM8ue3R27giSvAYhFtVG7ZiZpE71+eDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AO0lz/jtCwflK25LJQVpVKhq1+BxnWRaTRFiY1vETsbEMRne/PuYY9Y4VfJCyauaDWWU/Cv5orJa6AgHjGMbjxc3J05AY+corXjM/MsvxSDyWy5MuX2ar71+qoCtYphV7AEaXpbov/39OKGj5bidlwlVzbbH7rVMRuA0BZXDE+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=An0oVEw3; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYCbLjh7yipcUXilPYce9IDyh63NjA9qLqvvHEyfEDAjcUvOvZw//h2dJqt07uTC1LEn0nSJ/8XmyWsuM57zGvOKTTC26gp4zYCb4pwgLezpCbEKzgGHApW1n4BEOsuzzYDbE/9feJ0sch3X1sSxqLISfAFhVXJKypEdCqBXvcC+NIXPPgiu3kom6D2QlXznvRSD349EXQb42fl9ofYNk1kZxhNjhJWDn/bBa6Rwn8R4LY1eYzoS1fem7F6PKeBVTHVyU1y6McOVLrGagl4tln9Oct7c4fF7tO+DZg89PJvOWLRMNO3YnGnlQGbX47JJHOhKNxQyb4LbZ8V4P2egYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY45pijSRDXZ5Usx0o+MWCTXJPD2ZYgg7JpASsUOOg8=;
 b=BnKnQG5UWPazHsZRMEaop3R/nwNCqT4kWdpG8Y2pBs1COkq9GNcaJLO80Wx0mkaVaDvEflohel5zwWdVszXr2p7Vwkb9xfSBum8OnYRtjzA9+kcjYFpomS7MQMFWbDbY64cMMkxOfO+ymIlaBLCzMZRICrBQ9fxO62C6u+/Hk9CDdk3T9PhkHtSq5TIOSSOvVGbM6sJLvIVtoz3pzAtiRCxvQEARlGR5/I1MHbd0HVnEWLJwJFBujfKkl6y3qY5Pour8Yazt1+pPfTnEgKUOEt17HpioB5K2tCSA/340ihq+gBhFRLB6h7WOs7oRJFUC7hdhM9KN6riqnHgEWk0APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY45pijSRDXZ5Usx0o+MWCTXJPD2ZYgg7JpASsUOOg8=;
 b=An0oVEw3tQt+j7Fxqqe9jBW4rLemkBXMyj+jMSpmdgja7Kkm0Rxni8YMtyxrfiHl+XXrjhxskQ7C343aGQb13fz+hxwtIVClY84SoKGq8oxeQNVx0LoeO2HaD1pEIUCwgnzUJSfzdiqQd/5DUyUXYU1kRo6KfbngnYM/6uVrrB5DfsjXneBHNcNnrMZ81sP9l5X62DOVJ/0GahNnNiLn0NIUoECnuA7Bb9UuLgDA9b1JdI+9e832sdZmf95iB3khWKZXj7e7RuqQwdciDO0b6CQrhEpTwYs22cc5gaL88+r6hKwg8bYRv/QC33rD0p2cM74nQ6tH/p9h5baP7c8MZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB11097.eurprd04.prod.outlook.com (2603:10a6:800:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:09:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 22:09:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net 0/2] Further SJA1105 phylink link replay fixups
Date: Thu,  5 Mar 2026 00:08:58 +0200
Message-ID: <20260304220900.3865120-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::40) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB11097:EE_
X-MS-Office365-Filtering-Correlation-Id: f7438dac-3631-44ae-e9d0-08de7a3aa944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	c1rtyfHKjj8W7mWe7hp1ATXNR6b+s+Nwu/5HliTFWNYR+AMBkD2E7N2BMXIJMsQcTHzU4COEocLKNCmD/d9/Fkj6Hu+P20RwQHHYtvdGlxIlLSo08sfODf7rJBnAz97qkZItTHvxjTXnhr1NOXAF6siVPXmcRB2fXDRZ/sl0YWio0+1WVlTqYqOHLhWV2pWa2RZPpIANb/EvsrEgKPwarCP7YzOgeHP9W9Jza+ZND3DuzNzB0o6kDQ+Sk9hTkEmhD71FKBA5ALtJWkvDPLHghyQsFd9UaU7Jqe0LPeHpDiVp1mDpRt61RmR/SReimpEKAFiTPQReYKpUwufszNbqubrQaVlub7gfcAVCxvlwtaCxiBMbsex8lNFBbtRKeMVDwv+PC+j1mSO8AyalEfrk+8qLQUht1sCmSISq2KoYXVqXFyoSeP4xiTc2WJRm3pDAOcYIYokKAqWhy5FA/JAK/QLEFKokK+IhtCtcFxGV3HCi+mYJrWgDvKEEAeSXdNB5WYdpSKfx8mpkdlPcD1jQ8PEkaAmGYMJZM9EJ88l2qPYN8kb6nEBB7pKfIZK2WmpvVJyTklWaxTGqDQsJn40B0R2DYjY3/rFqAVeQ9t3Sn50LpHPliy5qz+qr5FAPuncVrG88hU2oBdX8twS3Hu1SQU/sxgdPwplsK+1aw7FONE9uFmz9aTInAsp9L/nykmQhL6DgyCfVLSx8azvr36qZ+xui92BcaNaUIS/cbxeV2QM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IM6smZQIoTzGg5qtmzShPJkRuHOSAYoTPb0AlxHO+GdKMKc8sSXJ0UYUipDe?=
 =?us-ascii?Q?5yL7X3Uo+Zjug2vk6QJiRtIMM6NX/weiNj/vnMHA3IPIYHYadbyy+UM61u5K?=
 =?us-ascii?Q?2QMxOhuEkvwfjCh7DTnD9w6NZjIlr8y7t2U6ulu3LNV7I/tqJgqzf+gxP6X1?=
 =?us-ascii?Q?jXU3oV2imG2D84ATYV+sQqFKvXB1jlTSbgHi8dbHMXq03Dj5NicdBCjOOf5r?=
 =?us-ascii?Q?jOLlJOFqVUX79CM6FiRtrcXSoSaKp2lFFHPwfPZeG3TYlj+gN3U3m9JyB8sZ?=
 =?us-ascii?Q?Aw3xZSPI9pacOIEw1+9rWTGq8Q9ne71xJ5vCQZ1Kixe9nmBmrV8dyzNNNtwA?=
 =?us-ascii?Q?9wDnarIxKuiMO2bCwCfV4/JeCiaDT8mMoY89GI54o8xdJz+11QYlG11bhBbL?=
 =?us-ascii?Q?hTEHsfkXnPlTSYG/Zc9THrdlKq8J6DJjavkoDMeKBblotPOYSqlrHEh2axLB?=
 =?us-ascii?Q?yz575cQkkL6w7Uvru8xt2d6NbDfJFTF91+AfECCxZM/IjrvQya7cuXr6hF2g?=
 =?us-ascii?Q?7FbSedTUqX5g2/YKKD8LXKpvNSP8i2ND8qMOQgkU32Cr4adbTrLo910ilMQx?=
 =?us-ascii?Q?JKT2At7JAQDEg8sR5eq1weP0k8arvt6vv7p237oocr2eAxZaNJqKAWP16BIh?=
 =?us-ascii?Q?xB9M/16OJ6oI+PbLVDEpibJym/p/9lMZPl8T0Pb3XJHKLzxWcvydXd9L+HSD?=
 =?us-ascii?Q?Oac0bvtk9IUXl4eQCeQAr/Ul+s5SZZrJbmrf3Hc4gfGeaBJKdyRzyiF7atT+?=
 =?us-ascii?Q?5mXRVvM9eRqL+YI4kVy81B7cvrRSjn2kM7DA84Q0Mt9zaVJZAdCgaPfumhuJ?=
 =?us-ascii?Q?oZBNGJizuPEpO6X9PodO0Kf+HzQn/Jf89i5gFJ38kb/8t10w8gFS0wtIAUA/?=
 =?us-ascii?Q?cltAy5yds0+82jE3Ys+4raykby9JqFpChG7nHaBMx4Do1HABNwp6ULqouBmy?=
 =?us-ascii?Q?DiCNyRwHeFl5mxxZAOdD1A5Ea6GScaXlru9dFsAo+lyYXM3ObvsJbwzTwDqr?=
 =?us-ascii?Q?1BncJBFP/C/87velP0Ql8Y4MSzkk3Uvo6BT5plPMcOQnwkn05FUq8L8zvinf?=
 =?us-ascii?Q?nBzkEAbqX7MQcUaF8eDVXone0r/rtmvSMDTEO/Do+Qql0WFPTch+S8XoZeOa?=
 =?us-ascii?Q?hVSe25Kx15GgQR1BgdqVT1h8dBIaNzKaPKRhnQwzINim2m3Jjp0v5i7NUwBk?=
 =?us-ascii?Q?84aj/3CQLQz8HmHtcujb7XpXCreyC8qv/HO6nXuX6InuetLp7cu7KyhghWft?=
 =?us-ascii?Q?Ne67BQJhvNdAESlv0UmtiE4gM5nDqhY/YHRf8fbBgiXtQ2rlEb7Qn/mazBz9?=
 =?us-ascii?Q?3/Xy6WWBpvsFnAIGH065jaLTV384ichwvxhCdZ5z/TsN4cTJ476efX7BNXRT?=
 =?us-ascii?Q?utrTTOZstilrjuGSFbrlFNh2SW2PPIMAv8p+idB56rB4r2oZihtzzZlR7SdV?=
 =?us-ascii?Q?lHzlr0a49D5HQEdm9rMyIw6bzMf7TTgtSh6K/odFPfHcCG5Kc6tsAoRZUi/W?=
 =?us-ascii?Q?4oBAc4r4/RKZ7uQeUvLWlOord72zbF2lVbHKYUuraZofDsgRRtxtFvU3Es0j?=
 =?us-ascii?Q?39OM7q6Z70a0Dv5fvY23ZV/OZJrq2w0E0KjWro+A1GL/B35CE0KGTrTrsnYB?=
 =?us-ascii?Q?fMOm6MYVTIFi4aE5/s9BYZKOJVwHB5FFWs3oPym6xNN8U+ExbPPvBdPPsgt2?=
 =?us-ascii?Q?Suonvr+48ZsWbmmCQjdyBhYXr7MSSunCn7DKVTiyIouKeec3BK0tk5qxAvB4?=
 =?us-ascii?Q?Wgj81PTzkjEYZ+0PSiCeBHuMll8uQUw3l2zuJ4JuE0/xCwjsdWUa3wcJqLv/?=
X-MS-Exchange-AntiSpam-MessageData-1: XxH3jV9vJpcpDiNAOGTg+XC1o1bZm4reohk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7438dac-3631-44ae-e9d0-08de7a3aa944
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:09:10.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZP1jJB1k9iJhYKemxgs/zusCjyhWVmr2wFEJT7KaJbFJ0aBONG0C58lvdYm0D4Zq7PGh5wSKp5+j+jGBpdplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11097
X-Rspamd-Queue-Id: 523B22086FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264061-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Action: no action

While I was playing around with the subsystem knowledge in Chris Mason's
review-prompts to see what LLMs would have needed to catch the bug
behind commit bfd264fbbbca ("net: dsa: sja1105: protect link replay
helpers against NULL phylink instance"), it flagged another issue
instead, which IMO is valid. This is being fixed in patch 2/2.
Patch 1/2 is preparatory reordering for that.

I haven't noticed any physical issues, it only has to do with the
soundness of the new call path introduced in January in commit
0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of
link callbacks").

Vladimir Oltean (2):
  net: dsa: sja1105: reorder sja1105_reload_cbs() and
    phylink_replay_link_end()
  net: dsa: sja1105: ensure phylink_replay_link_end() will not be missed

 drivers/net/dsa/sja1105/sja1105_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.43.0


