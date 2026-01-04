Return-Path: <netdev+bounces-246737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DACF0CB9
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C2293009C02
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059F2274FDB;
	Sun,  4 Jan 2026 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjVYYKvq"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41A248F47
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519614; cv=fail; b=I3HtBvFuPJWpTpG0RV2+BUKHXAd/wgtCkLDCJxEalJdKI1ggIny5woc1T3ZdYvMgVtmn43r9ri7y143vmqenv1QnJbDpG9cB9iJPm2YCyrwVB7Shbzw94NO1IhAgJqpDwzB8YAjTTO3JirmN8QinL2BSzcnvcvat+Q/P9IDD/g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519614; c=relaxed/simple;
	bh=H941PMqaBMA617JCZlnoafsqjtwSNPREjLpbzJlhyMg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KmLSv7rbL3wUHeIFddASHA4XC88zEHBFsQ0llR3wa+sqcsn6z27h0GvtW2sUejPQtaYJh3dtYIc5WXDd/eNDOjgF7IHukmbpz4HniTgmHWX2aKn5YY58NTAnK3GTJOlyADAiQwDOzx09rDncKBYMJW9ioECGVlE0iojhWJZK0Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HjVYYKvq; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ22XRSuA0pYFhVXVl2KFeZWKbWabhq8mw6FNBSwD1CTYqX290huc50Ig5g6Iznl5IS9dK5wIT9gXi7e2Rv/TNzBIths4ShZ7Dx7DyPGnFt5U4X9p6s2v0xRFVlXAOiKi3VYj3goqEm51hcNvrWhAqeVG1IB6sitBh5VmIrjTQGzdv12vyI9wpunX2LAQARKVcZcddTVkyGBzETKu291z8EyEbZY1/h9bWxzP+1gbdnLswb+vfy4mZCc9iZbyBNZm9Bq00k8JeNW2aDhoiP4c1e0yuNW+an2MKd3EgKXHOXHEw2iK8PFZYElRwC1ZPEyARcLhej8EESSz+KGAlgTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri2+7KxKcg+fUdfzOTYuaVmHmqlyGdWt6ZNGZxJ9KHw=;
 b=xL7OVRiWPcAZuYy4enawtTdpfVb5viXGayPUJiS+SbR+wNp5FQq46kdMUKSUjOHnW6IQY+Abl6Bzo8OYzjQQ5k8Ys8zqx1FsEq2Jm6pOETePmJXJQHYIrItKPe6dYQl2qALjra7QN69Ly6cJ/2BZkIod1FoOb+nkKgjLfJ9k0tVQfd3e0HKQVVbqbqA9uWFqxiz+Mk5K+w0I7LsqMn8nrGj0Tga95rZi6w5l1VZBIRURhiKbxwyt1hkkntrUDKELkpobwz6Tt8hr1T/1xE9sbnfbzV7UhqnGQDuBtD6eNA+qvMT92YBkv8hqYZGf0Nx2pat5QI+17WpuiT9y777EsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri2+7KxKcg+fUdfzOTYuaVmHmqlyGdWt6ZNGZxJ9KHw=;
 b=HjVYYKvqnXQWFOisknpMYhX37ZwZuRNP5VQxELXucgIM2CDvm2yc5zhlPrnzu6bXkao+9ODPLeMny10DbP8Xww7y/se3io0p+dW5MElYuzrGwqn+GeDIc4s2n04LGvVRPeWIhM6vTY09W1kGrIQwncLu+PF4zETgcLIbyJv+f938TPY493TUt+XVQpXkQcO0gfKPww8QpJ8D0RIyLr9CYyTaA33ISmwSLggdSNW1vr0Nks9u+Aa3yRDqjQeb1d0diuVJre8T2zHCcAGCiGzslVMSwDkghNge5AVaxS6PxtoTeVJdS5sWNX6V/aHySsU81cjO04nQipyrNc4tJjMkCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV4PR04MB11751.eurprd04.prod.outlook.com (2603:10a6:150:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 09:40:07 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sun, 4 Jan 2026
 09:40:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable"
Date: Sun,  4 Jan 2026 11:39:52 +0200
Message-Id: <20260104093952.486606-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::12) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV4PR04MB11751:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dd0eb1-84ae-4eea-05bd-08de4b753edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBwnhZOgH5pEElxql1Y2OhJUXEuyrfY53+zIZa2iU2oTu9HkPSjulHiKg83J?=
 =?us-ascii?Q?2riV5Bcelb1f/ixA5niYNahlTcRAPU2RawpHGReHbsU8WPYgtJoCH8ns1jRg?=
 =?us-ascii?Q?3lcyIabzOgSdeqNS7pJAcbLi5TuT1EL9ojMnhF1eATQwfy4HS5n4tkfcjnYd?=
 =?us-ascii?Q?mNQ8Dh2ob2MDn5Q0adJoE276y4JAmQmFSupZlZz3eIynOScYH2TA683O6n/R?=
 =?us-ascii?Q?L+bwQERKdzrm5ZAoyGbuPjvnZFNzoJGZjT09jMd8SroOPzpMhm1XwwtXgN9S?=
 =?us-ascii?Q?a4n+D2xaZAWswaAUXwXjQAIn8kC1sLm3W/Tt8Q0+yyThvNC8KYHcvzUzZ7mP?=
 =?us-ascii?Q?Kh7S8QiVFe92sizbx4a2c45UuxaPKbIJL2lz0+nDSZz2dRsyIqhtpSFyKRZn?=
 =?us-ascii?Q?d52KerX8tuae5S247I3ng1q7ifGXYPwxnFtlg2tBXpHnPaBvnLRmkEBBJc4h?=
 =?us-ascii?Q?0BxnObv7AVAtrjWyesJUMEHhWf/fXncssqdIpYIaN6sqcqJqFVA+80OgPdE+?=
 =?us-ascii?Q?++qvODUDNuBuE9teq/7YKLuzITzZ4sRQ72JgNXqGEVnwkupIb1kkFkssqvzw?=
 =?us-ascii?Q?CP7cFo7vYkGmnQhxBVw539YHLBKbHY+2a2TYykLtQtXxTfFoaC6nEtSLnnPp?=
 =?us-ascii?Q?23wZf9mMn5zrFhlYyTPKdxkMKZa4f+F02k+LTSTFphRH7yiEZcL9aNg8R7hG?=
 =?us-ascii?Q?nop+df7XALO+kDTa7why4zqNagFf1QbfFCQuyfgxzTCt0UZvSVsgBUHWKrQf?=
 =?us-ascii?Q?+ZXSCbQoSS3cbmBMn8yIecxCZCyVtsu0nvehCK1SHh7BCKSFECR7GIMZqqcH?=
 =?us-ascii?Q?BHJ0IWv0NTJRqSpMJYgivKosNyYjIgF4XRGzIoMPjASLbqdZgb7W9N7bNafX?=
 =?us-ascii?Q?YF7DKw1gLdAxnN33cFHPN9jZ+VePg29NOnNpvusiodqxaUETXi+oqVdeuGQG?=
 =?us-ascii?Q?oRE4lblh+1y6DZgtYYRDZ6XR4+MUAYZjyCgS3j3YaUW3GXx1jOX5pJiI5OZ7?=
 =?us-ascii?Q?Ty++VUastGzuEP6vqYhpMuOcO6+evAPdKK2dDfYtC9Gk5+3RgFg2ky05EtF2?=
 =?us-ascii?Q?CidAYO77qf0epp902UAyWBuGoVCxYr4mfKiGYrQoKg4UQQjzTJ+fANCWn6hM?=
 =?us-ascii?Q?/KQ58xvAX50B7czO0bAMPZeuQAJCbaceKN+vVWSZ41QA8QaAYlRgvUJsA8WF?=
 =?us-ascii?Q?uURCuQusuVzlYUcftHUoOLZyJcu3mKdtxvrHc+Gd57fgVJ0GNBpSJgPWFhWE?=
 =?us-ascii?Q?qVIV4u5S6mFowU37kSOMaT19XWaIQh/LuqzWQKjE06CFqXLQiL19deKGuRvE?=
 =?us-ascii?Q?CXOWJ8YrYcLoV+fqkMV9QCVfK3hHIao0RPB7WGXS+J8i1/mO9VDv8aNXaHtQ?=
 =?us-ascii?Q?cVqvjEWC/saYQnAAOq6wKN9ZX3CmeZTjtUwFvLfEmcw/NYFPNNW8nwz8ovTE?=
 =?us-ascii?Q?TTCdfEughBegx+1VqPHvUz20z6G2y4JyTvqeOAqBNUVZ6zlaxH3MkyOKJN/Y?=
 =?us-ascii?Q?9zMGHiNpSKawbtPXtNxrlfDe0s9OvAFQYvF6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7142099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIHIoIKzJppSDJnXbIqcVYTK0Fm54m5ZL17730NTKz/5BlZXhMSvb9E0s6Zv?=
 =?us-ascii?Q?/mEUL6pcJ8O8CbN/20t8jWyRNWXpnvbY8yIDcTh2Jzc5vaPQxxGE4tsE81u/?=
 =?us-ascii?Q?x4ygySM3RDq5h3p+s21QT+ohp7Y0xOq771moF19qICBxaoOzxYjArixEDuzb?=
 =?us-ascii?Q?1E5MERTWctMu/2MpInTTnSkGkwjXtF0FDkwf9XW5kI1zuTECuhetaoq1eRyG?=
 =?us-ascii?Q?7NSB5dsYQ5mg7fB6Z2eT/gWClNyTQg6d5E2K9fF3H93ZAYo99T3yD8P/gyCg?=
 =?us-ascii?Q?aaFpCz5zRWfOfZDT3j5xkpLSmo5Ylva8v2g3PBqQ3cRuCnQaMRqAJZunEPhE?=
 =?us-ascii?Q?OPehSDn4bLxXUIriYf6kbp2CB5ZCU7Z4PwHuWnRTGv/wEhnA1gjnwqVGRzLp?=
 =?us-ascii?Q?I6Qd8o0DTlBAlwVqUKESkpTEs8njdfnnUV2ENhfYduRZnjRtin9+c6wEbjHk?=
 =?us-ascii?Q?e6xWPHOb+Ue71RcbOlYh58JFJb/1BeAhUlEXjHBaiWM62CaEy/c3VrP0ThEa?=
 =?us-ascii?Q?LJvovT+JvA7zwPdzm2VJsTPj4u2aB/SbkFOsiGHl1Ia+G1MGlrlqr2Z3MFfv?=
 =?us-ascii?Q?idKWuZk/GqbFeccM9D9YkKMH2bn3lJ3IvusXqEvrNjkLYY2nXXvrgxx1RYq/?=
 =?us-ascii?Q?AzNVNx/psy16ksx0Yaufk9EdryET0P0OJe1fptSq7zeseJOQTvmkNA04edVx?=
 =?us-ascii?Q?2B4wM3GhL594Xdvs7x7NzCMdg3ttrLcrXs2k7TmwTjzjLUaeC2eJnctqJnso?=
 =?us-ascii?Q?DnxcqXh0bszW8OpShB8eYpFUnjkJ8Ty3+Nzb54cUWWRBejfk/TgptOyxqyLz?=
 =?us-ascii?Q?IGzVo6cgmNJL7BImM9haLn6sQ+7GjaCEKgm2yGlF6eONiGNPAJMqbnLgb0ve?=
 =?us-ascii?Q?/V/CEbOVgSFYX5X5YZ42hmUFFidpSRKOvJzVCYHVPhjVBWo9ATxBABWfbrCi?=
 =?us-ascii?Q?fDfRcOiiktQPbDJ9NUgaOa2XHOqKOA9RdTjwG/314A33Qd2M7bXygoSvwA33?=
 =?us-ascii?Q?Amk6lSbiN3YcXhiikoIF8nmWFXWplmby/VpN1yOsCI9LetLM3pzS2VqlC+NP?=
 =?us-ascii?Q?z1+0MPBJ1zxnJTR41wEOR0am8LakCFbTAkapWDx8d4vCh0+H+InOJwOKXNpf?=
 =?us-ascii?Q?mu4k7cNIHHAlAV9iPE3nifkx0/wwO9cp7hvv+D8Kxchx/wcj2G2/9eefIUKU?=
 =?us-ascii?Q?x/j69WbtnYMB+H0lTpv0KHcDwoZFigBlP+g9rYb14DzTkeWs4WQk92a14uU2?=
 =?us-ascii?Q?Op7v1vZa/U+gxHNt0O5LS6sm6jxxQrVegDH/EPcVM4lRD1RH8/iVzVXgOK/G?=
 =?us-ascii?Q?LEP/2ySJ6etWIZEF3T0vEefuVHz9EUdDOPuXLntLSfkHRyN+TN6FaOQSXPPG?=
 =?us-ascii?Q?oQk/5IVvlhGJM077DLL8MTlvbVJXiZ9a3SYZxBmEH7ke29nWTrKejzVHeSvS?=
 =?us-ascii?Q?AzzXovgbqfiBgFATqY35WlFhwcYMZYlnjKPDpE8+VOt8RGXwzwJV1pu0HOLg?=
 =?us-ascii?Q?kLBKkCHZztsy4TtuRZvTqKa7vH+6nv8KHxbXcd3HOwZPl2K3AU4FFSJry4Dd?=
 =?us-ascii?Q?puN4BF2kE7NPsrOUL+wuLtgx894R/C7SpdTY9wnIwCu8rfVFZXRrNBSxDAg+?=
 =?us-ascii?Q?Vdyxj0OfoREFPLuxzMDLOCSAM5d+H9i13NsTyYwgbNm3qH4lOHUYhUrH8z12?=
 =?us-ascii?Q?lCDaXj0UMUkyw1KP6nb3Gt+umUyj3KXhxBtYGPMcjBBWGCMaAtPQkIi6/Ump?=
 =?us-ascii?Q?HN6qwynUHCZp6sB94KE61PVXc3Ire/k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd0eb1-84ae-4eea-05bd-08de4b753edc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 09:40:07.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm/1+fT60AmTmAvGDkv9HINb/EoDpOgPyb5kzAvvt37H/UOyOKiDA/+KFWt/l+4WNLvaq59eAtX9vEn+y9nGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11751

This reverts commit 926eae604403acfa27ba5b072af458e87e634a50, which
never could have produced the intended effect:
https://lore.kernel.org/netdev/AM0PR06MB10396BBF8B568D77556FC46F8F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com/

The reason why it is broken beyond repair in this form is that the
mv88e6xxx driver outsources its "tx-p2p-microvolt" property to the OF
node of an external Ethernet PHY. This:
(a) does not work if there is no external PHY (chip-to-chip connection,
    or SFP module)
(b) pollutes the OF property namespace / bindings of said external PHY
    ("tx-p2p-microvolt" could have meaning for the Ethernet PHY's SerDes
    interface as well)

We can revisit the idea of making SerDes amplitude configurable once we
have proper bindings for the mv88e6xxx SerDes. Until then, remove the
code that leaves us with unnecessary baggage.

Fixes: 926eae604403 ("dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable")
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 23 ---------------
 drivers/net/dsa/mv88e6xxx/chip.h   |  4 ---
 drivers/net/dsa/mv88e6xxx/serdes.c | 46 ------------------------------
 drivers/net/dsa/mv88e6xxx/serdes.h |  5 ----
 4 files changed, 78 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b4d48997bf46..09002c853b78 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3364,13 +3364,10 @@ static int mv88e6xxx_setup_upstream_port(struct mv88e6xxx_chip *chip, int port)
 
 static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 {
-	struct device_node *phy_handle = NULL;
 	struct fwnode_handle *ports_fwnode;
 	struct fwnode_handle *port_fwnode;
 	struct dsa_switch *ds = chip->ds;
 	struct mv88e6xxx_port *p;
-	struct dsa_port *dp;
-	int tx_amp;
 	int err;
 	u16 reg;
 	u32 val;
@@ -3582,23 +3579,6 @@ static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 			return err;
 	}
 
-	if (chip->info->ops->serdes_set_tx_amplitude) {
-		dp = dsa_to_port(ds, port);
-		if (dp)
-			phy_handle = of_parse_phandle(dp->dn, "phy-handle", 0);
-
-		if (phy_handle && !of_property_read_u32(phy_handle,
-							"tx-p2p-microvolt",
-							&tx_amp))
-			err = chip->info->ops->serdes_set_tx_amplitude(chip,
-								port, tx_amp);
-		if (phy_handle) {
-			of_node_put(phy_handle);
-			if (err)
-				return err;
-		}
-	}
-
 	/* Port based VLAN map: give each port the same default address
 	 * database, and allow bidirectional communication between the
 	 * CPU and DSA port(s), and the other ports.
@@ -4768,7 +4748,6 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
-	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
@@ -5044,7 +5023,6 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
-	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5481,7 +5459,6 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_get_stats = mv88e6352_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
-	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2f211e55cb47..e073446ee7d0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -642,10 +642,6 @@ struct mv88e6xxx_ops {
 	void (*serdes_get_regs)(struct mv88e6xxx_chip *chip, int port,
 				void *_p);
 
-	/* SERDES SGMII/Fiber Output Amplitude */
-	int (*serdes_set_tx_amplitude)(struct mv88e6xxx_chip *chip, int port,
-				       int val);
-
 	/* Address Translation Unit operations */
 	int (*atu_get_hash)(struct mv88e6xxx_chip *chip, u8 *hash);
 	int (*atu_set_hash)(struct mv88e6xxx_chip *chip, u8 hash);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index b3330211edbc..a936ee80ce00 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -25,14 +25,6 @@ static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int reg,
 				       reg, val);
 }
 
-static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
-				  u16 val)
-{
-	return mv88e6xxx_phy_page_write(chip, MV88E6352_ADDR_SERDES,
-					MV88E6352_SERDES_PAGE_FIBER,
-					reg, val);
-}
-
 static int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
 				 int lane, int device, int reg, u16 *val)
 {
@@ -506,41 +498,3 @@ void mv88e6390_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 			p[i] = reg;
 	}
 }
-
-static const int mv88e6352_serdes_p2p_to_reg[] = {
-	/* Index of value in microvolts corresponds to the register value */
-	14000, 112000, 210000, 308000, 406000, 504000, 602000, 700000,
-};
-
-int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
-				      int val)
-{
-	bool found = false;
-	u16 ctrl, reg;
-	int err;
-	int i;
-
-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return err;
-
-	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_p2p_to_reg); ++i) {
-		if (mv88e6352_serdes_p2p_to_reg[i] == val) {
-			reg = i;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	err = mv88e6352_serdes_read(chip, MV88E6352_SERDES_SPEC_CTRL2, &ctrl);
-	if (err)
-		return err;
-
-	ctrl &= ~MV88E6352_SERDES_OUT_AMP_MASK;
-	ctrl |= reg;
-
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
-}
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index ad887d8601bc..17a3e85fabaa 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -29,8 +29,6 @@ struct phylink_link_state;
 #define MV88E6352_SERDES_INT_FIBRE_ENERGY	BIT(4)
 #define MV88E6352_SERDES_INT_STATUS	0x13
 
-#define MV88E6352_SERDES_SPEC_CTRL2	0x1a
-#define MV88E6352_SERDES_OUT_AMP_MASK		0x0007
 
 #define MV88E6341_PORT5_LANE		0x15
 
@@ -140,9 +138,6 @@ void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
 int mv88e6390_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6390_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
 
-int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
-				      int val);
-
 /* Return the (first) SERDES lane address a port is using, -errno otherwise. */
 static inline int mv88e6xxx_serdes_get_lane(struct mv88e6xxx_chip *chip,
 					    int port)
-- 
2.34.1


