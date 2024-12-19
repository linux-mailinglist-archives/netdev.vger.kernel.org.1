Return-Path: <netdev+bounces-153430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848FF9F7E93
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE67216767D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B9226882;
	Thu, 19 Dec 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dsa16VAq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19071226889
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623665; cv=fail; b=cCmXRICvH4k7U2Y5xx6G1zuK57YVbmtYh7Mxj5OCOka5CCcjGZFr2S4SHZUc3UT0VKwOI5B6mUHEgkkyMa8tFUBYEkgBUPL4DgsAgwl65CO5mOaKjJpuVbLZnsOwvxTZ+m+OdnzwuKD67KsnTdUatCu1LG7SgsvEep0PAxT2pDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623665; c=relaxed/simple;
	bh=PWn8YYsnwOu1LVWpvrAkOms6t3KfdwGDs9mzMJq71bE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dh+IXH8UK3Li4Y9hwimHQllzcrO0qzbu/ugBB756T5tx5SgiQFsiIvjgmm0PbUDwpP1a7/s5ExAeUiYYHVRP/b6evfqC5dXs1ETI9QqdBbuFI6SqesA3KsmvJx6bO9X0PwLpr0maZ8ASB7y7hxyqxxVQbKUnq7VKHw0YT5DvXWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dsa16VAq; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTmYHr0YVsLvBfWQnWBCO2sCa/Gt96tnhNdNHy72n0lNxfoVNDAY/pXpAVeoDAR4lZt24lMqfUslXeJSV1UB085M77uNYPMqupFqhjndnNXW+VoVSCIQqxV9sMCtiybOtHhgqo10zZysr/6tPZoDiRUJP49teFHFENwHKn4zxvtimVda5yN1Y+YxsI3N17vLmh7BynCjgwbGS1F1WZDVOW24m0ry4oxAMLQJULaPRumVIXi2I6AOMYs6a2weBYSXndpYsydr4O3BVCIfdM9rmsSSMe+nG3CO5dLVICjy3jhkSX/2szA/cyEKB6VHZiCJb4xf79bfAYX2r3SWUkPjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeLzv3s7gtbyyKaE0JiWjOcyPOsUjUhMJq5iFuKNelg=;
 b=bHFTEmf6yj9GSKjfLmQo1WZ+mQgStaM9pXTowDkDu0I6cIEsp3sj1oUnEEBrXwlMNWx0KMlfPpmGFmBgj/RDGOBNSqft6DLSJGwwishvfbEZmJDWjHhzq+ZwA0s9MU6zgie7634XeWblYnYM1dUgz2sGMRrdJ43iTG2c+plxbnlQdjllf78znCKmS4yuLxi22xUXyQhKWWkNs8ygBHOFR4mT5+APfF+uYHv2OjmREtq43VaaJedvI4E4xFp+Ex8xvT3bWg9UcpuCWm4JcR7MdRWVT5yItSmYD+dLFmuRvVkIdvR2nFnm+ygR/Ujp2Vmk7I3Gngt17ps0/8CO1kjM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeLzv3s7gtbyyKaE0JiWjOcyPOsUjUhMJq5iFuKNelg=;
 b=Dsa16VAqzlB9B6LO7pt4hEz0su2y5CBZPyjAQb2XCHZuX7b9jsds877+qhttKkuqzrMfAzx53ixp+gUuBbcYo4XKwYmiXQQ0vFccKt1Xz38fleJ6cSqYjSAjpSF4VTgZv3F4QSVVjHcHRzsYabJzBMBgMv2sCe4IWyiQs7EDBmRJttSHjnKSAYfF4+PHAHCtt6irrvP0vHNcKsurewz3LP9prhcddJXjLyWdL+gNQtbawfqrxn7M4aa9E0cFWUNtpZY0d5LmJ+ZYc0tuQxxlDJHkZe8KnsFE4gKbWRVBohVe/t7Art86Suv7gGEmbqDfOnXkFX3hafXz8Bo+nlD2Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 15:54:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:54:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: net: local_termination: require mausezahn
Date: Thu, 19 Dec 2024 17:54:10 +0200
Message-ID: <20241219155410.1856868-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:802:2::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b75a9c-6fca-45b5-c8ad-08dd204565d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itluYSB5peRdoOJBgp7DUJgZKFb7ejvZHTRXOlL4I+yV7pWRD91ekFDcYpU6?=
 =?us-ascii?Q?31mlb8v2M7SyAm4v+jdPflgYvxFVtlls2pM9boYk+V/e5d9Z5lRb5j6HaEfC?=
 =?us-ascii?Q?waupKDVq74vAQty8NYW8i47ochsPqf4LlwGqWVABG7Vje4jdPda28dGk10J4?=
 =?us-ascii?Q?cEe4QMKS2VSZBdm40a8o0nGLPNOxvDMlQ6dclOjgSop7ZvAhFLZ0grVimO2a?=
 =?us-ascii?Q?GwcdXy+rhHduLvT1jXJgyeJtCnf0DyiuChE0a/cfk2mN0rNSun+4Olrp5Kyy?=
 =?us-ascii?Q?13KE41ls1Mt2LtM1mF/8WhDyrGiJ6GaJhhNbtrBuggy8K7rOP8MysA8sB7V7?=
 =?us-ascii?Q?iK4bhfbzO+M/elmUcFwR3qk3FDmeWIQWuNARwMqLQ6s1CWrNStI0ROivkEJ5?=
 =?us-ascii?Q?IGNN4y3fxSW9q1qXMuOEutCkkZ21O56RQ3avdmfV5lOqtf5NXc2O6rVcvO+3?=
 =?us-ascii?Q?Psq/tHsacY+6rdlVsqBgM4g1O8MhG99EvZH3GKhvCKP0vR8iKduPjd9ut6pL?=
 =?us-ascii?Q?wONF7JVTjA9yHFU2MzfZU0HHNA0hSM9RpQ7G86MRe0EZ6hwsTupYj9bxcBRp?=
 =?us-ascii?Q?N0MOWcmGtZMnEp8tGRcrBzN7jxLNtW7+qez/Wwr+ghQZpK9GY0rLuMrJQ3w4?=
 =?us-ascii?Q?M+4QINna7/VJRUOa5rT/leghTuTZpD5Ru6Q9vWx8XmozHxLQBlLXWEgmcssY?=
 =?us-ascii?Q?Tji/m6vWs3pE/oE3APR5OKLiCE8LT81GP6lRZp2k3mQdMyiMLt8Nx7zNKEC4?=
 =?us-ascii?Q?2wN6gAdBJnYypS1OCbcdxREqqVgOA98W20BInUaVZW6YqDv+3FW0C/orblNf?=
 =?us-ascii?Q?4+b6Av35FE2rrCwZbSv+GTVrBC0b6SzZBfnJbbNo9XpeiVfLOIBpcmSyzxbP?=
 =?us-ascii?Q?dVP+fvKIoCPWTLZTRzvDUMfTgtDvyKLRKP7rtVq1/kX+cvnpWcIjds5p4GR4?=
 =?us-ascii?Q?O8bjnY6PS82ZhKHd1GwIAir4dxsg48tfXN4TJPl4VsAjzVKknI6hE/BlvWQ5?=
 =?us-ascii?Q?BzGpuUG0Oig4l+VE16MXqdyVnk0BXqwwkNEXAcSxX7lpha5iA0ouXzBvskTt?=
 =?us-ascii?Q?ekiGIJcxLIdckt5gvBn1v65e78EQAZJWdTmRwGWaXkyiwdwE9mp2k2YvyBW7?=
 =?us-ascii?Q?uqMCTHEzawqAqnvYlLyxMLAlQa74oR6TVcDpwW6RzqPieA5qRx4tEPC5BLJM?=
 =?us-ascii?Q?6Ebuv4e2qOoN4irV3h84BGijas/PFhP2z1+EpHsA9FZKTF4yLjmT7HYNl7GH?=
 =?us-ascii?Q?utjxFk6dg8bQRKGgdcH19bLElDC0CkSOrbCkuNQX4418vF3D5TZCXXEkU/nR?=
 =?us-ascii?Q?h3P/eHALietcBpGC5NbxNUzClzHtlcDkCFeOcPBO1Y+6jBpi84B/cqxixdZV?=
 =?us-ascii?Q?HgvegJS3zKHRvq77nPA1cwFZv77ehpFAiKJCJsBNpbE9+/6cHGHoTyC7N+po?=
 =?us-ascii?Q?dc3w1FFZuqbjj5dAy4MlTrSZTwdekEWE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/ZmsDVZqV5f3HR0Oh5fRXk/eiSZ/PG+gjXfr61xVQrgw/UpTLk9/ls/+q2K?=
 =?us-ascii?Q?7os+sMM9Kz/ym5ZGF3GiFzJevaaGBl/e4MfJ4f2dFi/zNnSJv/Eh6FWChzbY?=
 =?us-ascii?Q?9TENHbW7xPr61nJQnFjjEg451ElTzIeHv5+4dDc1rBBVwj4dxnA5oy9MIDeC?=
 =?us-ascii?Q?6gbV7ebOJcv84DtGJb4a3ObqdfmlsU5RbSAEHC8rx3Dn5buvJTxoiI3QWZqf?=
 =?us-ascii?Q?exHXJ9IFVroSsBMI6Qlzgxkca23SVAdCB1CZ6+kKlUVI+6TMMxvaXcDi4Twh?=
 =?us-ascii?Q?JjtywXjAAyJbLSpLEeW3NFH6Bo16wSqSDb2irkNxE0LwkyhWGthYManowPlN?=
 =?us-ascii?Q?5N/0hPmjW0L/oB4B3kkVW1I5Ua80ouDvVIr67PpOZ9+T9u655lnOOY/Ry9V6?=
 =?us-ascii?Q?LN4i0lo6CWkc9gp0UiQdQXQCEAcz3SsJuk8tufV1TZ/7fdtVLvmYJfkXr20A?=
 =?us-ascii?Q?54YiOM23pvcx16S7x+Rc9QoX7jaM1iiRjzrc268X901Nt8i8ALgFIXls069Y?=
 =?us-ascii?Q?thIC9wzYjAEWSQjsrDDWi7S0C+F3ZRG4gQiv8FVoujowJ2wCC9aHNv6uRa29?=
 =?us-ascii?Q?RhpRoD3BJKWSqMvt4rg3b/jpFPiSUD8o9jSWZJH79e45EmD7dVNrU3gTAXe2?=
 =?us-ascii?Q?EfYUTcNKo1nkNZY1SZO3JP/gjdeINnqHuTy10IO84tIGkj072Hm+l6j0N4qL?=
 =?us-ascii?Q?9eYwRrggsiVm0axuPFaOfQj/vNON07n8YTVwetvH1iC1DcMwjOxV8s6E/fxp?=
 =?us-ascii?Q?KKk527SnYpvWB+IPCgXfM2Qo1DYBrU3KyxUcmsz6LaqJI64RrY9B2RiEwTfc?=
 =?us-ascii?Q?QtUt+Sb2jwVT+At3vUwk8F6b65DKC87ypbP74n4N2szhiRvZp9bRSjifY4Xt?=
 =?us-ascii?Q?8N8NvMDmhU4h5p/p21aE5t/efsXB95t3IZul+MGX/N928JVJzVwaNeZnpsan?=
 =?us-ascii?Q?G4mJIEWxqPcQElijkSirkGDbgeYc+e+1X9it3GotqumsIwfCQVSMTTqAq5ys?=
 =?us-ascii?Q?U1UWaIXX6YZo1tdhFdbUmJQAlGjf29peDmXAhy7weKk9PrajojsP95pj/9B5?=
 =?us-ascii?Q?L/hFotc3tsslsDCq1t1Pt6PTTjhX9BcU4fGKAsnmThhulPt6i3g5akCvYq/a?=
 =?us-ascii?Q?qpud5D9hUyob4bXVodeiC49cgRXrUcxCsSzv0IKSXvNME0u6sc2Q2NlFYYNp?=
 =?us-ascii?Q?2cOM3cCEUUnvhlEmM9HLPcfbzodPgo5Nnq7Bll2aOew5uufT7IyXM76WZtCp?=
 =?us-ascii?Q?GrLXaKGSLK0DRwgMjzx0PWHskhUdWuWoll4lsLNzrYv8VrdAHV9efWRUvZO+?=
 =?us-ascii?Q?wdhOitGd+A2TcFSmkkiH7+tZxwCDP6JHF1ulIQ4fD65iJTqd0idRxkKCwFEl?=
 =?us-ascii?Q?HcV7qvMAQPTBEp9ix3MQe1fIxqbngicUaf6MBwoJh4U1NFT3zHqACQZJdam+?=
 =?us-ascii?Q?H5p+enkaJDk1Rus5CopOmOOmTu22mG17OuMNO+iQa6FwyABkz8WTpZvi6KeS?=
 =?us-ascii?Q?PhSV/pPa0M3s7IU85Dxp7yy2AlEr3YZzgx8EvRJsx36MF/Y85wVuF1rqn/TP?=
 =?us-ascii?Q?8I3a6fl6JhRoymoGqSTTYUnHwXkSW5/iXXcK92biM/XjNa0o0/DgKjd52Lod?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b75a9c-6fca-45b5-c8ad-08dd204565d3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:54:19.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcMBJeAliyQCFIhixnpo4galdn/8w6S7RYYqAGalSL6jbvEdTRItsEMHEarJVCKHJxLMPr0JAR6iPJVfpbBPAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

Since the blamed commit, we require mausezahn because send_raw() uses it.
Remove the "REQUIRE_MZ=no" line, which overwrites the default of requiring it.

Fixes: 237979504264 ("selftests: net: local_termination: add PTP frames to the mix")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/local_termination.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index c35548767756..ecd34f364125 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -7,7 +7,6 @@ ALL_TESTS="standalone vlan_unaware_bridge vlan_aware_bridge test_vlan \
 NUM_NETIFS=2
 PING_COUNT=1
 REQUIRE_MTOOLS=yes
-REQUIRE_MZ=no
 
 source lib.sh
 
-- 
2.43.0


