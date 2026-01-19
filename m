Return-Path: <netdev+bounces-251060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F319D3A899
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18F073039861
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBD263C8F;
	Mon, 19 Jan 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHlwFYNm"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3C3FC9;
	Mon, 19 Jan 2026 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825209; cv=fail; b=BxTKt1pGlnL3Jb0Ou7BhH8Jr9eCNvsi1N4wabU7VW/YB5dL0wqvEHpFMBH6fqy6syt63VzszL6eKaGU0D/CLQR4ZpArDGIL1v6nWFN7w2naSwAE8nEqjtasI9MaIlhYKE0ej85H2KveoykL1QGymf/fDU31762ElnsUO1aXlVK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825209; c=relaxed/simple;
	bh=ZhmutZ3gHq+wn8OZgME61FUDtyUNGji220oYh1YWqvM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eObIBEfSYJPc/RlUC7bSO6zac2aK7WR+runn9PGeM6Qc7n13SQ/wkhQezJ+5BMf6AQ2rEvcHQlDUxo3wIlhdk3oGoVwKmdPfU2mz+0UHgXW2RWFy/kz1V2vM5PQHOclYosOyewdXxaFrSEXuwGogw5iGEHb4d3GqwbKbAaTdVYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHlwFYNm; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpuYPeR9jgpDkQJc1QmBwKh5B7FzqkDPB7Od0X67YGAymITobjOVPnA0OCRcoGgio76ri6SQPYKoa6dv8Vjai2fOX7tjstPJvcfgZE3Bv1OhtB9l8hu0bkqQaGzVskpWPgfl+jG9Y050aY0co8SagWFPbCqJKTs/TJg+PzeL3bzoqL3u5a9mUWZaGu43q9wf61KSEpmoQUMbm7BQaAjQE8yA/2TsTog2ppZ/WHr4UhLpkn0uEVqqesEzULSMB1RgR4M/Zhs8Dg1847idFXN0Jo0GE+DAOJSzxbM+C+hhEZXO63S7Ivk65myJCzn3LdsiujocSBmFENWFjUHcnoYntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfAV2RfWEy5/KH5h5K0joQa2GArsyb8iKitCkenDBUg=;
 b=CYz3b6pctamC6VW1MPtugetN+QhXFNAnl6mBi1ClSX+VTucrNropxpzia/gwzfNzN4TxnOkn4r4HIW519dS0jGwXqZ3lt7IWt/5zbBaYw7PsPwk6gxawWDqc8wEASX2phGZXUG0WhjsNHzsY6Wr5pxNgg1r+fDUcdF9d4APn1FL8GQb6oLWd7z6JQkDme+53R/vWjE9e39RqXj/yFrppVLGHTr+tQIMb3wYNfQNpe7IV09vPFxGJ4xiGZWkTm+zAJniPkbTKZme1B4izkaoqcM8hq9ERnF0dJi0zSIqD7ZlANI67W0UiX8FPlbzPpajZhDRYaxwWwg/5iGaaJ1zNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfAV2RfWEy5/KH5h5K0joQa2GArsyb8iKitCkenDBUg=;
 b=NHlwFYNmY8caCWbopSq08CIMR/5c9Trb6quCUa1G6oOxQG+lmG5OsVBWh9KKMLCYQXB1WWzDePw0bNXCMAoC+RuBHm1eM4fuxDxEtiV5NbODVhovFVfY2YYx4Zl3vGAwzn5rmwfLhKavUOsP6LVa9DlhntXLj0WEyq6+XUMC3f3ag4G+hiwvgh8BsYLkUAmkkZBR+pTO43GImjRI6X61RC2WNsfv0/FmZsWVgbUuqOMvCBJ4ZMkA3T99lBoJIRo6qOlfKhq4yxa1sWGV7sHo/kMxaDRjzT9Xod5MCmvF4QUFj2zQfpXVcJCyUfCmEPcJpNct9q8CKZYUeQ7cWNeHYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:20:04 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:20:04 +0000
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
Subject: [PATCH v3 net-next 0/4] Phylink link callback replay helpers for SJA1105 and XPCS
Date: Mon, 19 Jan 2026 14:19:50 +0200
Message-Id: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: d13d26d9-ccbb-4ee4-37e2-08de57551355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbqbWQJpeTFo40ApxXDSsors9E69PaWGOnSXVLKVCk9idjBHIYTQEZoQZB4G?=
 =?us-ascii?Q?ofGyr5R9Q6I2MY1E54Nb7UOokGCbzGFLSXv1fbHkxcssC+p4RZdJGoSYJbIL?=
 =?us-ascii?Q?h8L/XJqYr5cYaGwlJaU1NbseY6V2tUIgmIl2XwhswTvy/yg3AjJEoVGz5a/G?=
 =?us-ascii?Q?JjBoI4Ru3J9WB//wIM+kab1QgnEFYy00nLDFT00YcxcJwKt9nr7vxBs6Ie0q?=
 =?us-ascii?Q?ZEgpnwvk+i9Ohwmu/BeMsoUrBZLO6iJEQOn0OvpM6YCKaor9D+bjzSPOFdpS?=
 =?us-ascii?Q?yp2/Jur5JO5pkwLTI7vK6rJGMCLMXDrk/kWZJXNvYnIQ0CZxqTCGXbZxdKLn?=
 =?us-ascii?Q?hZJ0QdDV2hmwAqb7e4H6vySMKo0CcxbhrBJWnjwhc7bJghccyuv+ykt923g8?=
 =?us-ascii?Q?QsUwUn/LpmeGJVblXiDS5KGVe7bWvaw4fV3F7uOfvfD6M3y1FTnM8NymxuoT?=
 =?us-ascii?Q?FbKGaLkvTpHcpzlig83uYz4MJBtl9bIP9210FSoo8Mo6HXuZomMQhx6jTH1e?=
 =?us-ascii?Q?DEv991l7LqZ5pJoYd7u4adDPioox2oVV7+/4zAEII4dOezgMoJC1G+DAWMkf?=
 =?us-ascii?Q?14Lv2xLQcFB4bVOs2Fa2ZyiqfiW8aXBAt05pQcetBbyjQ2xOcXg2x+Bfydz7?=
 =?us-ascii?Q?Y0ojSU4RJYjp+IFHeJ8i9xmxsC/if09Z/N3txGjpv5L5f1+JjmLXzbYzqLNZ?=
 =?us-ascii?Q?kVjNdPqX0f0eF+T2G8RLjrtzUf6xcGpKH4O/aK2yq/EhotLR6SPY/aSap6nV?=
 =?us-ascii?Q?+Kbg4TswAc6K1iQLZ+uuz/ruNzu/vGUztqhWAAxHeFnjS68OTyZu7AlSzav5?=
 =?us-ascii?Q?K5HMyyqO2YivOx2ucsL3ZX+UKZbaVUahMpBnvvC1EZcn884z8kmeG1/G6hcj?=
 =?us-ascii?Q?78HWRkfCnvetntlIqxXFDAwtrS+aZrgIhs9gX4635pCL5gCUErJ4z+zP/DTZ?=
 =?us-ascii?Q?+upe0TolTpItMdnnDkkiJCCiM0PTvZJ/e7zKgSwIiusJvYu6RiIepItUe9zg?=
 =?us-ascii?Q?Ow7PgUnv5v8DN/J8/QvGWyAZPb4MF2vGzAAGbB6u+2r74EFRczuAZGWihLTb?=
 =?us-ascii?Q?cucfhVzTq5Fq9uZ5RSChKftguJ4xMiMk/iGsCb/NbfSr1WIAS9IBmZfAf9m7?=
 =?us-ascii?Q?AJhMFhbiqLEWNBX1ZA7b+BTcc3YMXg8Mc6NSm6BGueLpAMyvk4BHG1itwjl4?=
 =?us-ascii?Q?dMuFXAo9+GTmTQMHavorybWz5ZSejJXbyknjhJNPsKMtCV4kKMdlFEnbMpAe?=
 =?us-ascii?Q?KgCAxk2GUpP4cYclipiH1zkPyPcLaIToq8PCo2mM9JMSU2BPW4AVXbMrFvg0?=
 =?us-ascii?Q?iy7WnE2H9ivbu+IxkmCyZ2uUBycq2c9pZ2k1DkWZVOpZ3uJgWoIPBKmBl/fo?=
 =?us-ascii?Q?hsGS57ULh4BCBLCbyqbtLr2N+qrJSPBw5RsRfPtEnPdMpQEGkI1szXJh1YRR?=
 =?us-ascii?Q?yE027YygDoTGqwt/fGdeJe1cN3L8S3aXuRGja1CGFdVQpcB3Ewh9r7BXVFXY?=
 =?us-ascii?Q?192lk/nayf64QvI6d0i/VPXlolHpNWxrKKwP4z4Q5goJIlKJf6nPgBtxYA4f?=
 =?us-ascii?Q?BqQVKK+ETubICbri9dI82RCtHSfWHZY41FS7sVe42ZeGkXzp8YbOjhRjlohA?=
 =?us-ascii?Q?tWATSL2QITwUfEuXlLgA8rQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9X3SHuSmeVfpu9Z0RDhtjVkLMkOfQxDPesXUvg/fhZNEiVeghctElrEdmW5?=
 =?us-ascii?Q?TPWmItsBInvJnCKkvYntixWMBZv22O5V4jCM2i5N16aaFwX730I7+lZs+hS4?=
 =?us-ascii?Q?4Hy2aeXkq+c7cPSidL3Ok/ft4CMaeW+4b6peAcXOQ61ikvMEorv4CnIbCAWW?=
 =?us-ascii?Q?apsiP8xwKOj7vLXVB1lT/Ec4FwX+adW6OIHuK6b0fopY2WT3oHdFGsthPFCj?=
 =?us-ascii?Q?Wpmyr1bUe9btkAb0yWqqyCfwLqwZubcqHw9yGDhKJ2rZVzON8XwBMuIKWE7O?=
 =?us-ascii?Q?C5asAOKAwDQDKWs2m9+XmZyRJReIErR04RHNgMXaE/0Zyk01bokUjz+XmcOK?=
 =?us-ascii?Q?Whq7duuVuXPN22Fem6Gc/LgfjkeIX/KR2gVJ+n6Iws+XXG6DrRRkOefkH1EE?=
 =?us-ascii?Q?LjYfnNxZIdMSJW9Ia6tSBoGzn2SSOE40NLEDX4JRkRElRGn0zcA8kzqT4ufV?=
 =?us-ascii?Q?Soq3iRGROiBNwlGvZhS7h6/04cffjXewp+pdRD1drlNi+p87X/JlVU50kspX?=
 =?us-ascii?Q?LPDPxsj2WHDCQoEcQcCxO1gt9Md/gPnd/ctqVlWJXwvMiUL5R5WFP/tBcvbn?=
 =?us-ascii?Q?4zJHn9ilBHuux32zb+++1qgDnFWkyup8yRNSxBqZCN/dDLjQNMGMoJEWamw9?=
 =?us-ascii?Q?XOhJ9mrsLSuDeQ3epTqfa5pOmJeJukujEa80lJ7ZxJ8pODlBeYty4NH26+Ey?=
 =?us-ascii?Q?IveuGhLlYv6C21JgasupoRHZbIUDGybs3oNF+KEYN/XBfL+dX0GQ3l1lGKHg?=
 =?us-ascii?Q?i+J9MiGxnV2TTqbST9iIhu0pk4jQ6+EBd8Ow9GlzSIxDsm0sIr1iB69/FEMN?=
 =?us-ascii?Q?jB4RZ3KjIWMGqoE+QA6Zd+HZHtlJ5nSnfNbSfZ5Fl4Y2YBfk8WCBtIqfZ4ti?=
 =?us-ascii?Q?J3cwMw0EqkmWA47Kk2gIqe/GGzLkT0HZRND0hb6W/LUupn1csNoLqO3KSgcd?=
 =?us-ascii?Q?1ovDBqxX9ac1Eqn/bDJPQswooOwdiac+hjs6XElzHHnJXO78fMI348asRA1e?=
 =?us-ascii?Q?n25E+LYQ53MARSbcjXyy45seqTQmS9XbX9Q1C5bP81ZXvAAcxmnQO25pMssm?=
 =?us-ascii?Q?NrSkZGyTil41ujBmUqN9fM0plYISmWRbtIYDoB3MYw0ktRd+4vOQYTX+WcIV?=
 =?us-ascii?Q?9oZDH9TQJBL4IvTWKS8axTalw752oJlfxOQm56MHCFXgIjyIUz8bJ28qHRgp?=
 =?us-ascii?Q?FfpB9CxvsjBjwdA5uIphpa4ak9CjbpY3HjPsrut1zfpURueoM7LeOT7zV/0b?=
 =?us-ascii?Q?3v1lNV5wKi+SVbb5UM32iNqlEznvLKAVwJaj7WxsI9qfYvgv4mmhzSCJelVF?=
 =?us-ascii?Q?i3edHnYc/aDkgDFmSBmy99lvPLHcrjqyOYg8+fU5z7cNi3SihQh+sR024seB?=
 =?us-ascii?Q?6DgrWamU9bdOfayqx3gIVruXhMV6JNjiCwHU1LcG0M7tl/ss+Hna6btO6/u9?=
 =?us-ascii?Q?sMFqBesxlYQWZO6hZLyievhhBuwP5vcZPOlB/PjPDt8nDi3MJU9G1ehsD/nV?=
 =?us-ascii?Q?3XwHLEJI5lrvGK+CpHbxnNtZBwvyaW1gLuN/CMKAicmfF0myhsaISnzeVAxn?=
 =?us-ascii?Q?e2RHCqT/BSpjzdvfbIpn9xt1kcIS45iqYeiY5ipgTwObNASF571aTcm9t53V?=
 =?us-ascii?Q?0LWLwzm2Y10AphvsR3WIHjoGLrkEH84hVXaXGJuFu0TTdHNsXgaaMd8lsyMm?=
 =?us-ascii?Q?0efQDIf0kiYxZbHVWwQrfbC0S6LueFKvM+g5rWDhzzcwYmODDE9aZkiGQx4y?=
 =?us-ascii?Q?2FYl99RETg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13d26d9-ccbb-4ee4-37e2-08de57551355
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:20:04.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJnU8AxfzbwmcL9KhRKF3iafnpGM1E8tpYnvKrDMGBE6tU8CXLsePvxb6WKtViQp0ODbz/XFbxRWFezsAFJusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

The sja1105 is reducing its direct interaction with the XPCS.

The changes presented here are an older simplification idea, broken out
of a previous patch set to allow for more thorough review.

v2 submitted at:
https://lore.kernel.org/netdev/20251118190530.580267-2-vladimir.oltean@nxp.com/
v1 submitted at:
https://lore.kernel.org/netdev/20241212172026.ivjkhm7s2qt6ejyz@skbuf/

The change log is consolidated here rather than in individual patches.

Change log:
v2->v3:
- single patch broken up into separate changes for preliminary phylink
  refactoring, phylink core functionality, and first use in sja1105
- new patch to re-merge sja1105_set_port_speed() and
  sja1105_set_port_config()
v1->v2:
- check in phylink_replay_link_end() whether phylink_replay_link_begin()
  was previously called.
- fix the handling of the new pl->force_major_config in phylink_resolve(),
  to not depend on "bool mac_config". Reimplement it closer to a
  forceful behaviour.

Vladimir Oltean (4):
  net: phylink: simplify phylink_resolve() -> phylink_major_config()
    path
  net: phylink: introduce helpers for replaying link callbacks
  net: dsa: sja1105: let phylink help with the replay of link callbacks
  net: dsa: sja1105: re-merge sja1105_set_port_speed() and
    sja1105_set_port_config()

 drivers/net/dsa/sja1105/sja1105_main.c | 84 ++++----------------------
 drivers/net/phy/phylink.c              | 75 +++++++++++++++++++----
 include/linux/phylink.h                |  5 ++
 3 files changed, 80 insertions(+), 84 deletions(-)

-- 
2.34.1


