Return-Path: <netdev+bounces-128149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D449784DA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A885283072
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5D383A2;
	Fri, 13 Sep 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mu1YkVfN"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422331C2BF;
	Fri, 13 Sep 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241392; cv=fail; b=VzB3Y43di7saTdVbEh/i8Uudy3gwmGdKITo/QCSstJkfYrWE5xZt57MFWH42KcVB2qPrdyP6/PDHitalDEl8w94PnBBY11WDCCDD1B1tn0JNfT4Iu5Py9MpFJP9iLGrYbswJy5NfH1d23gJnyeYyKXFGB0vK3VK6yoP1BggQW18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241392; c=relaxed/simple;
	bh=TnDrmLIL1FlzYhqfC5Mw6+TmWKB4yoKImpYsHfnRx0k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ad3j5Jeox9xO6JyE6csMnTGC9BiPBT3dfRrbQoP/Z3nczUsY4XM98w7EENy3k49UlTUKASsMq6xa5eBfiXS+IDdsrU/YHvpWK+3h8NyFXvQLQrnxY9hp7uHdgNISpWyWTHz/kqAVEwaBo33DmK6rfMXG1eht7cKZJ0GBMa2TRB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mu1YkVfN; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4o7ysm/DthDeotWzkiesq6kSKQnHLU/do/prcZZwrDAgat4cJUBcKYwbVv8OJ/eXORroBJXoXtuSXmhFESZC3DGuxYIRbVIbMUy4mXNmgTMF7kkVt1j+CNcx5pb7TrSnHz3AYFrpM1uoarkoQhphsJvRrqLu9uhZp1PRLW7oe1bcGWZf4LD5wVghqtyb3vByCf8bpZ7LTxvceSaYSBfxF2gfWbPkPTRSArozZkmNfcGO/InJeXllu+zYMmHHjl1OmMtG6HffMOTmtFxYI7KnjeT401S9VvrEgsq/AQqZlfqkHF+cgXSfI3myEuvveVG9MBmf48jD9Pl7HU+pYYDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KybZnC1tn7bkQVK/mBv185H0fK/cJJHttW34s1JR0/8=;
 b=PxUA6NZsY/lB7KavGAWkJnyp+Ak/E7JvDvCObQd95oD1Qsr6WcIsG5dKlk1NicpxB+LMjndg44Uo2dpJx9zfWueZPeSuay35QWJcGAgTQlTPFP5HVaY4dWUmQ7Tlhi0OSvNoh09cNKu7APLwxAvEfFu6k6tcoyPOrZM/R43ls3oNgH1oV9GyX+dj4HTmgs7SYnvyfdCbDm1KIXuCemkT+S++OfkbFErCcybvBf8lXYNETQbG7Q836jBawVgMZspxNBK6zM2AnN7aqCqf8d6a+YEn8B585W2i3RYt9HMCHSPRQYL3ItbyJj5iPa0Pjf0yfiqC+Xyi/HqwYCcC71bPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KybZnC1tn7bkQVK/mBv185H0fK/cJJHttW34s1JR0/8=;
 b=Mu1YkVfNHUo528DrUXtTauTuHQImqu7P4ZgVRPZDmrRQXTQU9IJnUtFC/VOzAAOEJSDnYzs93e8pTgngImtDx/uLZ1b1X87C0ByBOUQahghG/xJD9ENmnbFb1RmUbGWEQSfc+UjDHSijjZrk/z3CNWwkaO3Qlf6CZneQmefCn9yfoV0vgpw3JfTuoIscbNxfm2UEzfq7SGnkCgpFcNg1bkyTlKf0/f7sYc5QG/bcs6abA+Q4nBE3rZ1LK8MIECUfC3jKeUIjt6ncXk62I37QHH9WXvYn5BjJynLyugbiZe9p0d4sRSzFS5z3O6GqbJVoLI7OyZRSRY7IzPaLH5g1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:46 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/6] Mirroring to DSA CPU port
Date: Fri, 13 Sep 2024 18:29:09 +0300
Message-Id: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: ced69933-641f-4fbd-80d9-08dcd408e5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crzLDwS5QtdXg6Y89QNs3/wB2CIpVVn8LgPL9gnTeEbL5g3nC+dUVwUOfdSU?=
 =?us-ascii?Q?ZsHM8/VgEsa/+Kubcbe/rbgYC30dqF7/H57p2485sP38ldGSTOxt1WLCqBDe?=
 =?us-ascii?Q?OCXbyQy8YXnCQf+gAYZADkDduB9ZAL/LCu5ygUWC2zTv2PJpl9YlHMnro1Sq?=
 =?us-ascii?Q?gCCMj2ZtZ5EsAbiWGiPhOL9XPjymqkLARVbL82o6zUkJV0FXfOvD06y8PriD?=
 =?us-ascii?Q?kGzC4+XXVK+wrwummoxbTc+KE/f72TsfE/FJETMiUg74876hhKxvzeRis26y?=
 =?us-ascii?Q?K7ZhswIZ5HWXyEvbER68Ral1SVRHfm5Q5yLmz/tMw9xGX+fWrjFpc7FFGHAh?=
 =?us-ascii?Q?6g67qa25JZWfKiRZE90Gdq7REuHa31hGYFYA6F0OqN+VJxTs4/ShcMkxda6t?=
 =?us-ascii?Q?U+CJs0CVHseqBDA9P2YCY/TqBwmcmlBxqflKDzuohRZ6aTd/Jgn+g9mW4pIc?=
 =?us-ascii?Q?z7DPKwOOyWwj10Y5+YMW9jEMDnYiZOBQQEUHLMI5p0rl6KKmYeB5N6MDrbtG?=
 =?us-ascii?Q?GyTnrTv/R2N/RLioRIfDrlCb+IHUvmfzOd2XlrVvQbT1ZhqI7xLQRgIotyvs?=
 =?us-ascii?Q?kWOMKX47FMqevT2N5mPe9O077sNeIbc8LIX7lhSYQ94u7gLcVajsAln105Yo?=
 =?us-ascii?Q?3Nuu6cLmNvaXt7u1Gkt+/EAHDA3JQdQb8eO1mmXG/HhhRyE59BZy4OrXc4z9?=
 =?us-ascii?Q?OMGrcdUweHtJx4vZw6mdLA6TAIz/0RBIRr4PCAc/GIyvmjcjxNEffGIBl4qH?=
 =?us-ascii?Q?ccztkFX0ZkO9k/VM3V5LxrTA/9yS6n6+fGEXarTLV1WLWyPQrSW81hPTuqV4?=
 =?us-ascii?Q?1gdf5PSs5IPjkgMyTLrg66DYcXVjo5h00r/Nr0NGUNbeJI5zh6r+J8T62oV7?=
 =?us-ascii?Q?qCM7gU3AndYuHqo7SAsuboVEPBpO7ikf9gcxqh/SO8wsraUjFaCXoGh0gcMr?=
 =?us-ascii?Q?OWfasJIM/773kJHb6msnsRWKirfq1UVv22jIC1FtbUdcW8HUUTH6yHcj/5ZY?=
 =?us-ascii?Q?cGffQ1IA4t6bozf1VYhZphlxqap7D+G4xAYZnzuRF08dVkzJYyPK59SLx1la?=
 =?us-ascii?Q?zPWIjp6PrhE1IFDvc8zw9SJvjZJxTym1Kkhzzx8S4S4VOQG18ic0JJZ28rOn?=
 =?us-ascii?Q?CJfniURzatmvxygVJt0+ODLzmCfYv1EM/dpKy0DpMCYikIR5YCAgwEcgd7DP?=
 =?us-ascii?Q?wBPfjgJ4za7KnL40R/iVsfZNRYS6qUGHHu3p7z9nTVB1oK7hodwQIWfkmKks?=
 =?us-ascii?Q?RfpzH5SfOz5gljmH0NtJHuJ6nHgQR2vA53kQNO++jaivhaxKefDuFRXFehCn?=
 =?us-ascii?Q?l1RJUWWu0u+x25+yz6vbgk6ZDVtrH2H3sAGmDjGF0go6xuHCUvKSxWDsDE4g?=
 =?us-ascii?Q?nZY4F6hBF+ujKkL0Ckx0uEjMK5fWeB2EEABAaaBMBkFi0NRjpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGbgPOpyy96wrEXWOpnR4Q6gg0iCZCol2L7cn1hN0XkZ9MDLEVv7vtc+JZfK?=
 =?us-ascii?Q?1tKMl7M2l/PrfhOF0W3dWRht5/1LnQlv2yq62XKCDH8qowd2JCd7kE26R8Xu?=
 =?us-ascii?Q?RcgHB+4bCUpzgsGvwe1ws8HelLeI1ooHgA2MtDrYfZIn98souC3e/izOD+2L?=
 =?us-ascii?Q?aZisWIMQF3HqmAMoP6OfMbIdpuSwXoQZMdP2PMXSSaGniuiH/Ray+u37hdhX?=
 =?us-ascii?Q?Cs1w730VwXHqJBYe72CcwUth++0Mjmzs5YCzn8+LxKfkVUMaYQwYL35bvLjw?=
 =?us-ascii?Q?JMQvGpHeDe2OG98j3Tqyb8aXRsU6gGZoYu5UruTuPMHLLqHPSbDWWc4DNl5d?=
 =?us-ascii?Q?GkFS31R1FtRiiqtz7iRDseKdJRJeZzuIt+zOKSIxdcop7F8nQV5z7bt6FVhH?=
 =?us-ascii?Q?urWirGgweCMLlGy5wFwkTPPx54g07tuk1cIsSPET267NdllzAfiNGHLKhNMe?=
 =?us-ascii?Q?OOPYwQaFoEZkF5py8NGLATUjaXAxTJjoAgORH/sIp0JJJGWp949QAmEKnC3E?=
 =?us-ascii?Q?mdRqbBswYhUPCxrZBZWM2z45FIhRGCnkHkYxM8U8BisIJcQlDUWR2UUvrsue?=
 =?us-ascii?Q?IKtMkQQ5YR+GK14BbHJ4cRVd1bLgLRTD2itgpjtp3G52viIvRo4WDArV7jGN?=
 =?us-ascii?Q?YB+wFhkQuNESyDQ9jIH3vGpY/1Qc3wHHf+V8pO3ZSathHtONMRSHdcayrYpU?=
 =?us-ascii?Q?VybqwhPoxTN+fFG3Qeeb7g0v9FsV/pOyvHn8llmqFpsPKWWjkuYbCcz0/8Qt?=
 =?us-ascii?Q?nZArnc4SJwC6FeGR5fp9Z91855JcyXILjhy0WWd8RXXEDut4aithkzc7dWZU?=
 =?us-ascii?Q?KzD0I+i0fvQ/Av5PC/TkkEqS3kyFfiGKgCi8sPWvu7N2mmla6B7i/ynRpQ7W?=
 =?us-ascii?Q?vUfcozZuUJ6G1J1+uqZDGT/DF4UXklhTttCq8z9QGCzyejyeiJgO0hy5QHXd?=
 =?us-ascii?Q?eqFpzZS9pX5TJcPPo2fJw3pct+oNGDP2qIEFc8qmbmofIJogfQbGvHm1oxqR?=
 =?us-ascii?Q?Y+Gf5xWUbPFIV1k6YOGzv1AKQrmV8tcKjkMCidwXBrbv/v8/xAvZqnSELfbH?=
 =?us-ascii?Q?REvzM2l/S4/DJt1JZi1tQ4kPoQyFdJmeVQEh+6OOl6zqQXpRlZ27f/OAuJjD?=
 =?us-ascii?Q?rF7+sznh0/DCHzxkr0qF6LhGhbeRWo4KUDgwXpg6zVXqQXqwVjcw/ELnn+FO?=
 =?us-ascii?Q?bRqDECNDvabyi6fuB1vamndz6tfLjIHLFyDrMtlPoMA1m07NlcRk/hKboTov?=
 =?us-ascii?Q?FNlZ6ergce+Psetai5av5DiqdQralGG1+tOsbayMAWXdAzc0qE5W/G7Rc80Y?=
 =?us-ascii?Q?atfW1VEEveZeN+HX2Sjws1o8AsY+kN+3Eb4fILvNzQFs/Z4V+lplWmMEN35E?=
 =?us-ascii?Q?NpIvYfE0pkiTzRUyP5V948/zF2GBKlFt7Lfn7AxL4udZPZ+xhjQ7o4w8mAxw?=
 =?us-ascii?Q?WR2mGLMstT+jraKrI4l1PdnC5ttd2pM1ot/a69S9jOJkWBtSR5ATUekuRztJ?=
 =?us-ascii?Q?wtmwhRu32slKodbjn2eIllbSr86z6zYMi1lWIWBvN8gDjZv4QMpjs6mNy/hu?=
 =?us-ascii?Q?5xJMZyAPaHJsthp1FG67ludU7EeaSFbl5DCNs7VSkn9bM71cVIlptkSvBepB?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced69933-641f-4fbd-80d9-08dcd408e5a5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:46.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXt8vcntjd2wOByAudAzL6Bw/5/998Q1IEBC1+0OupJMFgGpDUBpqNnGgE2juhZWNu/hV9PKZXm+DhlTsIV69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

Greetings,

Users of the NXP LS1028A SoC (drivers/net/dsa/ocelot L2 switch inside)
have requested to mirror packets from the ingress of a switch port to
software. Both port-based and flow-based mirroring is required.

The simplest way I could come up with was to set up tc mirred actions
towards a dummy net_device, and make the offloading of that be accepted
by the driver. Currently, the pattern in drivers is to reject mirred
towards ports they don't know about, but I'm now permitting that,
precisely by mirroring "to the CPU". I am unsure if there are other,
perhaps better ways of doing this.

Vladimir Oltean (6):
  net: sched: propagate "skip_sw" flag to offload for flower and
    matchall
  net: dsa: clean up dsa_user_add_cls_matchall()
  net: dsa: add more extack messages in
    dsa_user_add_cls_matchall_mirred()
  net: dsa: refuse cross-chip mirroring operations
  net: dsa: allow matchall mirroring rules towards the CPU
  net: mscc: ocelot: allow tc-flower mirred action towards foreign
    interfaces

 drivers/net/ethernet/mscc/ocelot_flower.c | 58 ++++++++++++++----
 include/net/flow_offload.h                |  1 +
 include/net/pkt_cls.h                     |  1 +
 net/dsa/user.c                            | 72 ++++++++++++++++++-----
 net/sched/cls_flower.c                    |  1 +
 net/sched/cls_matchall.c                  |  1 +
 6 files changed, 107 insertions(+), 27 deletions(-)

-- 
2.34.1


