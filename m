Return-Path: <netdev+bounces-240962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDDC7CE1C
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD9DC341392
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0852D8387;
	Sat, 22 Nov 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lwi4Evvy"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF419C542
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810610; cv=fail; b=E9qCFqznL3bdXPKaA9LU+KTb3kaLD3YEnOf7X7OIFPpUMcDllt8ECqHG9eyRJCuH6w4HzvppVdeIu2RwU754rH6H3gehwr9jgT0AKKLhALg94Z39heA6M/wQFyPHW5cJQ+7A3znP77Wqi+SgwRq9rjj6NyomW0m5UPwvN9d9z20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810610; c=relaxed/simple;
	bh=kMrVe4+C7mhPHrtoR2dnRlzWb0I+BpJCX7mdTgLAuko=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q4YiB1D6KvSwfNdRmdebKNS60evFHeyy0vX6X0ZRF3GF/+wdxLj5kWbFoSotXXZReXI4X9/cd9IQfguABSEeRsaq0r+O9UK4JzseEfagnaov510ugor6TxVeOT2w+EVIm7gjqZDd3glpneHl8fnsXr1/0wThF01kTA5yuL551Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lwi4Evvy; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7ELvxRqHD/lH8nilXfwARSORxgEvzhYeQ7csySDWmTJxU0F8PIoyxp68xNWotOWCOmCChD6mL4LaNYcksSDtdv20xfvLCU+YT5pRNxYRo/yhvkobDHp9X5TD/XmSMXyzhdCA/6YM5xEcHoazCFtF2aG6CnwpfwGDBj470/4/NIMHqSistcixwOuV9EtUQYdVFQYCofq2GqI4XEUsF9KT/Mg4c4bjaQn5ulR3/cGeKujufuQXk3zS0+VujxDV3yoBaP+gujX4ak8C5M0kfchyPc3H4Ek14Um9SptosdQ4M4U//ktNo70OiD9a7CO0aNiaILcRqtbKkOFX0NdMF9ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cnpjEYtOlT/dxp/cJQMSwxRnMk0yxLi9sS+WZN4t3I=;
 b=xkVkZHU60nDi4RErJN2vJtsFBXuQcBirJwWRgGKSKevlKN98rmHpMdgRAZ3I0CXvW+l6xNLrZKrpR4mo+lrBMhGq+ceaPY2eiyW2oR3h8NL2wn0ZqQ1zIVuIsnSKLh7DUKhVZHiwRIAw6MbMgYO/8RyPpphNIwOE8H0QzyezHZily8PkaGVqrHd9FTCSoiT6wOxR2q5Tzv1ZrUuD3gAZi565v9WbR50QTkFRzXNSzoerWLYkcSL5mDdRNEB2JcMEXmQSCHOR2VfLC07xib6PVBYrb3O46RX3nyNk+SCTKPYjZRJh9iPLwz7YbA8mu7cUXKLcsmNQBtxubD9bbFB20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cnpjEYtOlT/dxp/cJQMSwxRnMk0yxLi9sS+WZN4t3I=;
 b=lwi4EvvynVBUaawLascPV6gPa8SUvY7IGnw80zVPIyzhmD0q346c68ctSe6VAOKW4V2n9hQZNLJqaUfVMoPEup//CvHJEDHtP6zKFBO5Soju69Qo1igyQ7yDlLNGqXxGale/XO3Xbo0sdMwYOqsJO5Y9JDf7ng1AzXBHB/W7uJxi/WyiC6SvjhcYjhq+kejox8HI5pvaQAgtHLFIqG2Tu6ZnBv1VW2wHKklVbojTNBoUMW6hgz78oLejnu/O469Z49a9fMpLGqbC3cbPraBs11pKWbg28WGjxtFJZ1TbudGp2mtx/JPktuS/XNYVS2PDj2ruPLmRy+u2TnnQOGR2fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:23:25 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:23:24 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] Improvements over DSA conduit ethtool ops
Date: Sat, 22 Nov 2025 13:23:08 +0200
Message-Id: <20251122112311.138784-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 743e739a-3c2e-419a-b1f4-08de29b98cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dUuDhIMvJ15agwCC0xahXvoG4prf1+ziVUFvQOJLw7gQM0xCVL/Q2vogLZkc?=
 =?us-ascii?Q?hvVxlJaKK7C8tvRQ25fo10eejE4PdzqyBmU3tdWSq6WXVcTgjJXHTZJB5HJm?=
 =?us-ascii?Q?/CT26lHQMr/jJhK/s6KKbPoh6PE+0ySfAQjEUZkYz0C564mIXM2GFrdEqogm?=
 =?us-ascii?Q?v1yYVYuFcRw7MIAKri7yGE11eoJcgsFa0EzdxqN2Axv8L6uQs9yPUlbJKzxh?=
 =?us-ascii?Q?a/uJUo7dqhpWRqlVxPdnLmyrP7V+7s9mmNmmQtUF1q69ARr51dUZGcBl988i?=
 =?us-ascii?Q?peOE1SkaBl+8MSPGBexou5LHozPJZvitGeKHDiJB6CvI12+nFR2dDEephDZS?=
 =?us-ascii?Q?EucZ1HKfKH0bXr/gYlHcPc768IUJtGs+TmAiR7ql1oXtEKYTH+VFMvGIpQo1?=
 =?us-ascii?Q?FPXf1TBrR5ihiR+uRYOuPNrJYERErufZ33AYjaIt8mucATLeOuVLcd79s9t5?=
 =?us-ascii?Q?jkfmg7gcEIENiHJZ99It0EsKqXgSZFnqzyK8R2cuIowqp7YP5Ndf8vNB0gcl?=
 =?us-ascii?Q?GsMdtZ1pIudEp2i5B0NR/nsQPKGD8wAZkit+B8WpIBmIsQa0cgiMcEHIIEZ5?=
 =?us-ascii?Q?iR/8A/AXqv2r2jn8psu7irSI/GZgtkPorBED9T9isvuB4ZI3YwVt/pXGqVcs?=
 =?us-ascii?Q?gNCHRUI+4XzxPiUcZjcik977lnG/wAEdDvDNUfUrmm0zejSYFnq88L7+xZfk?=
 =?us-ascii?Q?vxTIDXc+l4dRkJzHUi7+DTIt60wVyl7PFyWl5lZ7sDTl40yZEDxM2LuN4cCl?=
 =?us-ascii?Q?Lou/xpTwaiT2LhMihXTVhYWjmz0R2DS4fYDCr2pXR0W4+jAHfZorwTKIsgTw?=
 =?us-ascii?Q?KX2xztRmz8caY+AG6rqBVNfAHRfGfj0nSvIqXok5aQQfnlN3psSLw5zlo5Rp?=
 =?us-ascii?Q?ihu3XfoGe/k0B66s8ZLi1l8tjTPWmB6i01GVHombhZWaub2WvxPpJtuM7fLu?=
 =?us-ascii?Q?D1ih83tAbBnL0oPpOstE7DD4NrQbbvULZhIESiaOD2mdxrfXNDb0QnCjZ+p2?=
 =?us-ascii?Q?szfLN3e1rRPRVPvZxnAtlh36EdKqM61N/brlovarx+O+v1OGaozNCNThoXF5?=
 =?us-ascii?Q?Ar/mvPFpXxjbQlBt692gRYn0MbnuKxM0SpZEOWKU+uqKxu5xsSzXLThP6tJL?=
 =?us-ascii?Q?2oUYK0Rv5HcTqxjdiADJyzo3piKEvXG19S7lLfdjdxB+aY1Du+JksCWJ3N8g?=
 =?us-ascii?Q?yGY/1Ja8/oNxi7YFax+s6vazN5goQtvR1wH2Rz/sZOJYHCn9tIclBdiE+fQ7?=
 =?us-ascii?Q?OCV7KLtCJ17AFf/bmmSMXnX2Kk4joqcMFdJg+F43U6RkI4QSgpQvVaWUjcS0?=
 =?us-ascii?Q?LKn7QSPoIaFMbhatrm7fTNExtM//rb5ndZZVA5VZdU8YhnWbzKIPpxtRYQAh?=
 =?us-ascii?Q?nIEJzoIPSSVnjRClVGrHhHEjzb2uUPLwj1HbvaVbnVO0br918w0kGeI63/Ge?=
 =?us-ascii?Q?QcsrK/8l1V17I/q7uV9+B4irrGi7o7JC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdKCrpqcWcoGFgm6I6IkBKiud1/VKkpvUZzP3DugeIpLfvlDbHl6l6ijxGN0?=
 =?us-ascii?Q?5x4AtRC9M0bd1kciKzzwgqv3hSAwpSbeCOKyPP8/ijvD+sRJdlSjQROafd5q?=
 =?us-ascii?Q?Phw0Tn7PgNYGwgmnwwRy5WWIE9YCrUSRnVdZeV5JWp5ByHjQS/mVrg6vQrH+?=
 =?us-ascii?Q?0twuRvGTqBdnx6/Rw7oxbze2JVt7EycL5Pr4nIGk/OXyK2/lEBBvTFbb4WA4?=
 =?us-ascii?Q?ZHbVsJyJYyiJxD4T5A/J7Tdn1zqCTjb9IDLo5d7NC5r/c1vHtmJI6bEIktzL?=
 =?us-ascii?Q?+rXoHbkzIJLKft5ZcdqD7sp8W+r4lpK+j5lRVk9zSolm4y48gu35g+phHPm0?=
 =?us-ascii?Q?kVBiLfEjGjMlPMoXGef2lwkUt8dsl5pXSCDy+GppUYKYKVINQVjKSnE28i8W?=
 =?us-ascii?Q?pO4DQSdnjt1ZieKzS0rBrPZcP//gIfWQx093QV1fsNUFdP79fIpO26RFZbqM?=
 =?us-ascii?Q?ZP+Vr0cr2MqSsyeyKVXbyCbOUBXkV+A1n6BgKBYlP54eBA220TrRpILaTQFe?=
 =?us-ascii?Q?llcTjGuVOvDSRTHvbjGuRAEbiKjbtJowRITzJIL/QD7MXsF0TFs67T0xcFLD?=
 =?us-ascii?Q?d9Q3PCYcOwdmpfIlB7qRMWO3xSJG3mhtDnE6WOzALtzZ3nOTwqD/yM0ARFJ2?=
 =?us-ascii?Q?pFK3UNYod5xXnhD14uLmHI5TkPKD/2QJhOM+3F5/wRaVYsDXZpjcEzpWqJT8?=
 =?us-ascii?Q?hgwjKgz3KJ0XbFizuphGkxPW9tNZXMyU9JB8fpHfW19dUOag8ROtrqv1tfFA?=
 =?us-ascii?Q?+8d4VREjZzC3GlA5BFJ5ZUgevv0frPNbXs3+GOZUchMuco1AfV3SjjSJ6Vlc?=
 =?us-ascii?Q?Os2FJ8S972vrBajtRkP73zVG1ZPoY4u+XGVNt7iUAx8iyQIP+TYv891qD3Ke?=
 =?us-ascii?Q?D+8aI+oUDfi5ASNEs23Bj3kjmNqmHMIpwkHzyNuYG1vsnauG0WNshbnJFgso?=
 =?us-ascii?Q?aneEiXAAiIbL84aZPodG3G1C7+8iMiWdJhsNTkFKgRXeO4+skyS3nYcfkdiH?=
 =?us-ascii?Q?7QsZG8GaKHuEenpntSE5ppZwoDPyX6mwNO+lS+b0g4czo29KI8i64hIxxORL?=
 =?us-ascii?Q?20K+YLyE62BekRWuDHpmT0/aZjTMNDVT1lF8rEvtVLejWL0O6zRbfTDMmcgZ?=
 =?us-ascii?Q?13FI8Wvqm0OpyHln8pjyFGeN4yHXLnGl2v27ep6h5QA5V87dHvn2L/niKoNx?=
 =?us-ascii?Q?Ce3SBd2P7LxGajzlRTa9kKX+J+3a4RIeU6eBVOD2Wgk1BaLMtRypJpg7faqW?=
 =?us-ascii?Q?oeK60IQaWBgTcxNapeGN6olVPLrot2oi5hUUsA6oFeOPhscZ76ljzNW+1OQn?=
 =?us-ascii?Q?jsZRewnNt10iij2y9EgG+IYuZMG2KRrS4nDegumF+cEaFiS4z/HtotcFyoDX?=
 =?us-ascii?Q?dA3ZLD7hiTkZM9QLlLy1qMCETgZLmrNN1IbmzJ0OTs0McuVpWXtmvQoz0wvr?=
 =?us-ascii?Q?1BFKmRsSyetEO1SqOCpYZfkPLzl8wOBjs1pbWkXIyrnSy7FygQgTGQ63mVRf?=
 =?us-ascii?Q?iDMtwMmlex7a18KA5HnoLwR9SX2mRVsnK1TgREqoe/V6VibGBKe51BrCA36U?=
 =?us-ascii?Q?rooFl3ddqalDr3Ug1QqM9bBoB6oNfpnFpaTwaTCFesEt7G0bveGBUkfyUMuO?=
 =?us-ascii?Q?z1TAtEMGx5V2RKBKaviYNfM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743e739a-3c2e-419a-b1f4-08de29b98cfa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:23:24.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqHH4DD1ggNrL+yG6MWGRjhDnBo+tHNkWLHIjzK+09+Tn/omxLju4u9gId9IxTp4WTMHRnWhseBdY9l8G6rd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354

DSA interceps 'ethtool -S eth0', where eth0 is the host port of the
switch (called 'conduit'). It does this because otherwise there is no
way to report port counters for the CPU port, which is a MAC like any
other of that switch, except Linux exposes no net_device for it, thus no
ethtool hook.

Having understood all downsides of this debugging interface, when we
need it we needed, so the proposed changes here are to make it more
useful by dumping more counters in it: not just the switch CPU port,
but all other switch ports in the tree which lack a net_device. Not
reinventing any wheel, just putting more output in an existing command.

That is patch 3/3. The other 2 are cleanup.

Vladimir Oltean (3):
  net: dsa: cpu_dp->orig_ethtool_ops might be NULL
  net: dsa: use kernel data types for ethtool ops on conduit
  net: dsa: append ethtool counters of all hidden ports to conduit

 net/dsa/conduit.c | 145 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 43 deletions(-)

-- 
2.34.1


