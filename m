Return-Path: <netdev+bounces-54877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964EC808BB9
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B771C20930
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09BF44C80;
	Thu,  7 Dec 2023 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9G/B98+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA4010E3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 07:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx+gPFq149/v6SEpQ6gkN/JWFLBucm/q8GuWa9KrXMFsN298aKAV86md0U8qBqNv5NfIa5cU/1hA4RIZCqvkoeyvxxhjR7fE24PUVSnBX5Aws6x6KV8Ma3pBaCi9rh2C+JW7Xqp+l94BGXAFJVijRNSZYkRzhqsgTDhOAF23pfUnRfpARx5FNQfo0w151vTl1qUsPm3srjDLGSAMbZNklQ4Nkxyf230KZRRhQDm6WdDwvsDj5UD/wNL4X47l087qfYn9silzgxBa/TrNhEmlCIwXN+9dPmSWEbxgb0pY5QwFglQorHFmslac8T9+Ih76eJO+aDjRCjHNxUocj5ZicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsPtZdOF//qk65P4Q5dbngff+nrmdjLE6FWSj+nuL80=;
 b=boeWMkdwnFpxu9fIh1PxO3CDlascL6DxWokqf/L8UPfzM3kCc88GpFUOU1+T/30oSS1oBIxRoZfhP9NZQ0caZVqrHR8eh5hPQqveHzCMFYEcfSRyZny+Mr0UePl0zNj14BEMLwvujAiU8deQEsQp7pK670cddLALkQ4g2qC3F/tgTIuzoBqa7nqSfZvVDenM0l5mJryW4NNFOS/HqOxZxYt8HJmkeTSmOXmzW5AzP/wEihEx2+HYcWaNCJiq5NHTVqmlI5I5XjZfaEd/x6j6C3/37kTDPROBD3O9sIC/S4TA2UOGwoblbrqOGuqhOmCKKbme70O63tNvzzdsF4nYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsPtZdOF//qk65P4Q5dbngff+nrmdjLE6FWSj+nuL80=;
 b=M9G/B98+4Ufoq4rYR4XKcOB7w1Z3+arrWzQeFp4zanSMKmF18KYsx6ulVSFhkBPxgIrhr6gwzOsciyObwyif3a4e/Ni+YM5nZV94/9Ydh/TvYbCyAZouQG73BfeP7CCv4DCFbV4BX1dfWLoDAmovaxXnLyAQmZ/bAnzs7Iybfxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8746.eurprd04.prod.outlook.com (2603:10a6:20b:43f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 15:24:13 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 15:24:13 +0000
Date: Thu, 7 Dec 2023 17:24:09 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231207152409.v5nhbgn4pwdqunzw@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201135802.28139-7-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::49) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b7d519-85e9-4c28-019e-08dbf7389117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j1Rm2hPUN4bq5DyQ93hb7Wpf1qRL29HfgVCxthBj76MKGirNOOskcQj6sYNeEWpDdkKQawjDSJFYW34BXPir372i6a7I3MhtMKD02ocNMVgVkijIEzJzXzBUtWNwi1clJZbIiU8bxQ9OFBJVnjm9M7Y2gRwf1ph1/DysBW/uIR9XKgDucmIYziAp1OaISBCO7DpPzVP/8BtkgEdKZT+MD9WhRgYzKr/WvLxedVQB8qPVtLWgnKXA6+UMT9kNyvSZUiZL60aVAxeU8THAQbYRxnGbQ53rxnJt6lGpYslgHfxBMbfHgorzfQ7uZ5vUoNjGg0aZCwabrT1Ty+3VH9aqCeHljwelvmHY5Scln/CgI0aPZRgD/fLXBO5Cj4acup+Xh/Vc0aAK91kHz8tXZbziyH6tE1J03+RU9dT4ZjvPPTF26V5P+fYgHaJPqbtiZpo61rbnFTAuLWG4W4NEPpn/cyAFj28ayfZOn+OsM0+NcpJ7egKQfDp4r8UW79Dufle6iS2YJKw5zY1r/ojhECJmfZvXw7a7iWAvoIrD1ZaP78iz6Xq9+hz2OhiJon82MdU/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(7416002)(44832011)(5660300002)(4326008)(2906002)(8676002)(8936002)(66476007)(66556008)(316002)(66946007)(6916009)(6486002)(1076003)(478600001)(6512007)(6506007)(41300700001)(9686003)(6666004)(26005)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dJQRBGS+Qytb6IEsgfSVWWRyHjBhzMikhXl9E9C8w34lYI02vKc62FrDcks?=
 =?us-ascii?Q?pwBxn7RNkZoUuQAt+qi2NBy8ijw8fuutewsmGLRuH50O7lqA6CAIEtaGRes6?=
 =?us-ascii?Q?Q2ZEF85HFZQdhhqHjFmmr6cjB73W3332oTiYhLK2daC33ErjuO4iGDGiq6+2?=
 =?us-ascii?Q?/I2b+mA9k3slrpFJqDZM8nUft/LAIeAtto6UhkTDnz+vzhNsldxMEnmXl3C4?=
 =?us-ascii?Q?kY2kdRuwxHfJd0lvZ7Jvqiqc24o+B0QBrgFsdGacmGFGgKHXWDMXAPDo1302?=
 =?us-ascii?Q?2zE2BzUJoFKF3/Akzne3mpDF3WUNyDZqM9h1MHYNatRe1p3N6yIy/GDlvnut?=
 =?us-ascii?Q?cwFSQ5TdaJGZshP1qWaSLIEr/AI6smDoiT9yeYas92jITzqlP2u0V9aKeTgf?=
 =?us-ascii?Q?A/yxle24jvw/aZxICkSF3Fxn0+dCr1IozgQ5TZvW54z3+34f0WJzb24EmsgJ?=
 =?us-ascii?Q?DE6TilArw3qNGRwKkLzxmK/WMi80kXnDfoe5zlwlMRMv5X3qYg3TOhkmTGgq?=
 =?us-ascii?Q?NJFzwCJg1Ytls2X63prWk0+U9OXBaaYkTKYj3QZjyL1o+8ErrIgr1pU0gC2b?=
 =?us-ascii?Q?PBL5XwQD/tzijXTrd1kiGLrnlPMo9PzQeYOnA/relQtLRm9QjaHYJzx9DyYk?=
 =?us-ascii?Q?LRexV8cTTJ+Y91WUBarQY+VO2CxKpGw4KpbPgs+fKZF3iNoyn+ODQM1Nl9Zx?=
 =?us-ascii?Q?EKk8LNE9TSe6tEk5Jd12RcC6LZyZR5dU/d/uqqyxfnonvYJ3xk0WJbH22xD4?=
 =?us-ascii?Q?Bh30dPgWepM71cK24xtpx8AYYNIensOGQ/TgdnnFSn8Q2kExNJv1rGDFX0LT?=
 =?us-ascii?Q?wh7fKJUwq4dFceF3/HC0wLnO8cdHyYVv13+c2LkS+fMFVfgDt5rZ8I3c0jei?=
 =?us-ascii?Q?muRnaT22ObH13jPfYsVf4vn/p1hoMVUx2Qi9sdsprnPrSozU9HKaIA4Nc3GZ?=
 =?us-ascii?Q?gSzxtZZP/Zq1cmJV7zI+P/JkmS6yj3yqhD+/P/gh1WInvPTI9gtEm+iXeb8F?=
 =?us-ascii?Q?vR2aMHIlm9MXRrAz5lNvizpPrlBRY4SPNCl0x0UMZJ4zH1TLjDy8Cok5aLer?=
 =?us-ascii?Q?qgJlxdcnoGpWeoNGDOjqbKC/ezBeLb/xmJVnGvj48O/7xbDdp7/QUG0235oQ?=
 =?us-ascii?Q?7/mvXlyenii4v+eko0yIPoY8Zk426BNQeoVgQVlstxXlJ9+SLcZ25j51/iaM?=
 =?us-ascii?Q?LQm3o9F5gihulEsJBSSSxwv2tzUB4lEOQys2OKBExjYv0AJ1l/6RMPt3qFEX?=
 =?us-ascii?Q?hZNWEAUXWswA9+OGX7+MdBTyLxtpgL+k08J5ccw4J2iJc6+aXw8gHvsR9dgJ?=
 =?us-ascii?Q?HbfyH0Sb5pr9bDXJgzRBAxzxdW5yBJxNWV4VnbScHD1abktJDSWqKYNBR8oQ?=
 =?us-ascii?Q?i3oLxSazGLotvgD6+hPH1D6eXlBl1ZU2C0cBSFTygicPnIEQV2cOA67frJrp?=
 =?us-ascii?Q?0IcRjieqO1N8Zr5ETk8VJ1u3QOGxyOwTOVET/70wKhhF4gpb94RQzGBjxb+a?=
 =?us-ascii?Q?e+hTozxmg3dymhmxxDAaQ7BKuezPwk2elZYkXYHrA0rLAFa3SGBFyaSWAFCc?=
 =?us-ascii?Q?7irsrGbk7z99f0uEBiph4Nl3SHjI2BRgLXRVLPAmkfm5E/45d43S8PxdErMF?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b7d519-85e9-4c28-019e-08dbf7389117
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:24:13.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUqoqWG+E2qzFOh9ALdQo/j2eENYXEfxBXChOijbBDyUJX460EWdXWviGXVkYY588caP4hdBMCyatbVGYURrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8746

On Fri, Dec 01, 2023 at 03:58:00PM +0200, Roger Quadros wrote:
> - now passes all ethtool_mm.sh kselftests (patch 8 required)

There's another problem with your patch set, leading to the
traffic_test() selftest passing with the "emac" and "pmac" argument when
it shouldn't.

Drivers which implement frame preemption are supposed to be prepared to
distinguish, in their ethtool get_eth_mac_stats() method, between
ETHTOOL_MAC_STATS_SRC_EMAC, ETHTOOL_MAC_STATS_SRC_PMAC and
ETHTOOL_MAC_STATS_SRC_AGGREGATE. You don't, so you report the same thing
everywhere, which is incorrect, and it also fools the selftest.

I would like you to figure out which source are your stats coming from,
reject everything else, and edit the selftest to do something sensible
for your hardware. If it's as I suspect and the reported counters are
eMAC+pMAC aggregates, then I guess the most sensible thing to do would
be to probe the device with an ethtool -S --src pmac at the beginning of
the test, see what it reports, and if we don't get pMAC counters from
it, fall back to aggregate ones during calls to traffic_test().

