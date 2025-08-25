Return-Path: <netdev+bounces-216363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5CB3352A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49F93B397E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E42272E56;
	Mon, 25 Aug 2025 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IRk/t1NJ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C07824EAB2;
	Mon, 25 Aug 2025 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096601; cv=fail; b=QPn7JUFjlSdwWhMc/cOhCw/5aVpGozLZg0uhacRm/0+2iQoVfV75fRULwDzsHMzLaqjxWQ9FdaLaH31/EwOF4ZF3y/FYFxKNxicbAdU3ECaiH4AazQkZZxLOkrzLlwXPY16h45NZw/Yh2d7T2Orfzmztur83rf3IQxJxZzIFaeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096601; c=relaxed/simple;
	bh=LpDN8ORCmhQaMDDMjogT4xuaWHUhGLywzYgSUvwciYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrqR95fVVoFYALqq0nsOTe8ZSwN8T/xasjXZF4VIokCE62oz3G4JbR2YeEbUITCkIVNZzqQSAw5yOKWpHSkoiNP7xGjx5Mu3lWNaCW+Df8igu51OtpWJpRlOocmNY6myssqqlmC0L1qnkAkfaKSHoNuvLldExtCPOFQtRHNegro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IRk/t1NJ; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD4uDlfpVg6/tk0nk9J5wftlRD6WAYrHxbQQM02SK4So+NU1OXFalUNIWoDBUw3br47725EEzipWEw+OW9mjilcPEFfDIAY9NRkm9k0WrEBy6d9EgVCBUEIkiupZ5navkaY3naq27oEcaBCPSCd+hjZdmbKGIik1w+LUggpQrdqj6yyc/7cdnm2E34XiwsynMp647hrjQS/s6ORBs6zQilxT39DtTEN7Sf80oJ9LdCSPwZogmkU8SWSiTx5VhZRctHELy5H/4nhU3WIoGSjEMffs+qBx6zFZYswecFyD42N3bt82lHg4Wa8t6UzBu1XSpw3D4iCpnGQpMCiUeY/Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=BIv3T87p9fOQOnQQzJt5KGJH8htqSNkKyrY+3Dw2bsJxcouuh7f3GdPn7nu+BSmuW3nIzLGEhxFC+IGFCmPfHKiDDVaFo+lBIPqqZf6EoYOPD0pjqh3xvhB0mdZBf5ZWWgnXmT52HA1KtBKM2x/Ne0lAabLxWwlVS2OIbIpLYcE67/p7FKCeOL2jvZIwJCrokJjxYALX+4hdUWROYfk5laiUpKFxqQgxg671ED4x3NVOS4NkzY7MTPNhFm60i2b45Qlm05/5pthnSRL/eUJRQqn5DBCc5+yd5RHGSwwG0xOopR36BQ76tP9/z1h7rHkeT5AbnoD50sSU2/ahrcTc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=IRk/t1NJWsLdMu0zifNFCbjUCgqaahS5wGvauCf0Z2CEYHHTcUiSMsz2zURfRPhWABaLVX25HD4otSOXrwB++5kflHwD+kXLoBch+kyeZYrGGQ6T5PM5fr7vYQFG2mKXYRO3jz+np0Df88/ffMIRqHPU7oJZulXcoSDNxFj54eQ2JwbHvTdJait15+/u6NucPDREA1aNGE/cYHrGHKqtwe2aNz71GKiAonD1Y6YSoLwRuP9IhbQ4OT85RtAoSvbXLz/6xDWGo4hA9Z5NDOjuHcgbj3jEhA1XY5gWrPcc+1eOFMrwVE/Ow9LshLEKN5XVbmK2mbFFRP/5qrYR4u6iYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:35 +0000
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
Subject: [PATCH v5 net-next 02/15] dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
Date: Mon, 25 Aug 2025 12:15:19 +0800
Message-Id: <20250825041532.1067315-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a8ed51-bdd3-4f2a-35e3-08dde390f969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciNo3zb+ng5uu4Pvemh1Db5sZgJUzNwqI76i4AIiwNdQHicA/EBzxQ6nEV69?=
 =?us-ascii?Q?Ycaixaw674/dHFXvjHjfWah9MC7X0TsIhNmaFCyO8SsJXU033au9ZVKefS52?=
 =?us-ascii?Q?Kb9ruc9/o7/dQPL3wf0Rot52PhIsZnp+roOMbvUrghsJiLpHuWsknrZlzZB6?=
 =?us-ascii?Q?5Kl4lxAs9GEVbG6M3IUGFFj7fp07ThzFTtZ/PSYYOl2/amr0aWDv5vtP9xh5?=
 =?us-ascii?Q?ptSAFXawbOdSmEOOM30t0tSH1q1g8b65zX6G7CsnySku0cqKf/hg+nSZIe80?=
 =?us-ascii?Q?eCDZd5jo0KHenhDA8uEAJZJDobytwcs1PxsCgkkQa4RYKJG1fjPJm3PL6XOL?=
 =?us-ascii?Q?gfvKeTkMZUC/MHwTWZk8lurabONAfCO0f9Vhn7hiGOWh+GIjIz5gNbz0/0ML?=
 =?us-ascii?Q?Dtg7ftkj+bwy+me2LmYMyC46HKNzPNOR9YsTWdtS++eiiox3MDVBaYOZpO3h?=
 =?us-ascii?Q?RMAqSgy1rmUAmmdAfD3AWrOnIPmlwG52B4Yl9odYSVaGaKZVD0l7Q1g0s5ra?=
 =?us-ascii?Q?DKtxQD1MzcE4fqJ81qS94HlKTOZFpzx4aElGgCrrFzO5ck2W6zskHuwuH4uQ?=
 =?us-ascii?Q?z5t+9zH9I98nnDOCP1CkgbAJWNHVuDmgeeutGanIPKmGd7iQmOF8+3D9PR2c?=
 =?us-ascii?Q?utf18uHpJ0GsuiaRpc+NvbnK2lw9I6oSKhIBnF6KYHhD+EXdTRXhHBqfVnJp?=
 =?us-ascii?Q?fUgh8h93G5yFx3wmFUiKErzaKBNDIvNA3v1XHeNAmNb6bYytqgLtwKPkV690?=
 =?us-ascii?Q?T8gYmTUoWd75aL4CGTh8ZSpLBPJArdT2mDnVSbMUWU3RCBmqJd9kJ3W07PqT?=
 =?us-ascii?Q?NFGOrUaJjiECC4Vfc1pRn3aI0hgA1bvhl7ubMvXWjbJhFfZRDyQCKFZg6Kop?=
 =?us-ascii?Q?YbruoChjx6jXQuZthDe7c1JOuxpwDvDNoM6wYOIOysrXz4jO+/ACpejt7pgj?=
 =?us-ascii?Q?b8umJVE/5AsT4j6KKOqYpAmXoz+/aHaSl9eRVwNLqjR3qzQZvwZei4WZoBt+?=
 =?us-ascii?Q?asqCcV9B4RO+HNL80F5sKDEyXhPjjGdmaVn2LI4gZfcLh3y3EOMWfIVmodL0?=
 =?us-ascii?Q?lL2sLGi2ZqDwNjC3mbQ0684NUMtCukkkuoKDNB/atmjHenw6A73M4aJPxWzo?=
 =?us-ascii?Q?k33jMT3cnxBHe1nv8Zqh60QLdVJwSj9gQgvnFYPe8cSSTDkc765nFYsyxFxm?=
 =?us-ascii?Q?WwoBz7B23vPdFk4ZIrY4uM/I1l9fNIWvwg7OGN7qZY2bzG9iZWOX/RS8XIhf?=
 =?us-ascii?Q?69AEGKaOD5GNMm391CiQ5sNT00/YXGnRuZpw7yMT0mwcDSzB9/1whPrnAshW?=
 =?us-ascii?Q?oeHpOiqsgkpLdA6seSyUtL0LJYQOq2VIVdM4KPupsriEao6zvFdfleGgqGq1?=
 =?us-ascii?Q?4wZGajg0v+NXGrJZlHZpir73fxZ2qR4+OaAmELjtoWhN1LTqXPd0V2Oa9Rlq?=
 =?us-ascii?Q?yLBoMwx5O/8rIvVO6hDtyr4YIz0GLcfPPlIF7jmbFtwpWsB2uAFrR4/fCTxm?=
 =?us-ascii?Q?wKaXo1ZaqYkKQ3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQkukgAebM2XKwWgq9vmcyfP44G0bdPaPW31ISOuDRer6IMgmk3CyRY1128F?=
 =?us-ascii?Q?BLlJMyIjST9Z6qaPKsaEaPPylflOJ7IFUeoWXTHpsQDfnFHttCSSoNkhH7o0?=
 =?us-ascii?Q?WlpCHgtM+B/kkWW2yd0/35nksOoJXR2TuFa2EhZjg33yJdWJ4aPzAcEhYvM3?=
 =?us-ascii?Q?0uWucj1rbk5EIVikLCKid6VjREi6B46gvL6vbEcvJWFZnpzkWqVzV0KvZsIG?=
 =?us-ascii?Q?0pbaik+XClg7T1IHsUeRAuZlUmLyx8KtawAUcUxhqZHRhcvxFEXN2MV53kXi?=
 =?us-ascii?Q?P3pKUDcaBLcf8NZ2pHpiYgfZQ267FkwUgxwq69lXLSN2W4u/PwRdFyyZ+p7v?=
 =?us-ascii?Q?uFiTEYokjPVofdRn8XYVvXArnqbSJvhlEydiiqRIICQdf/D6uEJq6QHxt/8K?=
 =?us-ascii?Q?q6lOfnYRkovc3LW4wEqH1FXQ0A4D1cWTOL0L9/jf6ItiJ4QsLVOK71vo4iW6?=
 =?us-ascii?Q?tBFbD1FwfEk0uxM+fBCSd/Zkyr8r1WVr/bxuqHZdfOA4SKF/odhpR28D76Zw?=
 =?us-ascii?Q?l9qsEIWWvRvSf+crrteJl2d0JemlPiuiF+d5APp+7vlGMhpw1uSbqdGKZs7h?=
 =?us-ascii?Q?K5hD7+ChL/OQ9uZD3FMgKSH9xJtDnvqtdAfhUkIdFcR4e1SrhROGEmvbR51i?=
 =?us-ascii?Q?C7xvehtXwZUw5BFO33OTPg3zZoeoG3QOt7tjz0MCJ2UX3Vrob6TYNqLzffKV?=
 =?us-ascii?Q?rPIJFMwsUp0PVmgKWJsLewMsgmEbwsDtVj+nNWtFnGEG5/Td30cOXOIzXZAN?=
 =?us-ascii?Q?ZNcxhkBCj0kK4wnUegs1wh+wZYyyHhbRtXoVixcBJcakX5UPHFD3DD9RnEkZ?=
 =?us-ascii?Q?v/gjGZTYVEN/GODJ6lv/RIqhEhpKLPP2+WXbhOkPmH2Nt5VSwEB40vCegike?=
 =?us-ascii?Q?54WJ1/XFKIlDhtcIzkKFyZBHqb2HYXy/C40zuYKi0Yof1bCGyYSK/LgR+qwx?=
 =?us-ascii?Q?QjWnA99CJB3gFg/sJ3j2ZXVa57RVR+QBi3JiJcrAbU7iHAg2XQED0merGzAk?=
 =?us-ascii?Q?2Z/ZTCikVgaNrxun4PceXB8WGM2S2SpkFKERqLx9fcwsncHC1wMwHLchYp1k?=
 =?us-ascii?Q?XN4MNNCAhoDIoQbsn9K5GoRz0FS402t7sDX/pqgT3dWxzL5SCg/H6A4UbOWc?=
 =?us-ascii?Q?BND91ZjL0zGG3UjiupDZFnO+YlMuC4MLokqwV9BjRyQekbxVZhvhop85J8us?=
 =?us-ascii?Q?RtZdfrDmTIn6ngrxQpl4f/nRiQid2IrPU8ehPWV7zeg8rymbuJFz4OEOb5xJ?=
 =?us-ascii?Q?hBb+5VIDq8Hgt+m8K5FZ4qiO8rXJ1cAzBZx9L1i/492O+QR/Ww25So6rp+mw?=
 =?us-ascii?Q?/ESSHnGOWLUj4rERJfIfhIfmYwwgTSmG1ErkEVa01d2xQURxU6/aNwvVsoC0?=
 =?us-ascii?Q?af7aIzVuOYH6uIOW6n5NVgdYrfBdIrNvYjUFLiBm/E27piigc3MsMP12PBUN?=
 =?us-ascii?Q?ngJnC+p9esq3zv+u8jkpXxc0SGksEoq+7n6FlKptjHhkiNUssN8jka0IvPzQ?=
 =?us-ascii?Q?ylY0OrQ5eOBWciGSlCsgqoVXKM66o7HKiZCh/8C3hCaoXn6ncVH2fNGEhLr9?=
 =?us-ascii?Q?M5moPp+2EIlN9e9YshKwRSUQz0PoONBvJ3JLxs+N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a8ed51-bdd3-4f2a-35e3-08dde390f969
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:35.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmCjW7L8fKthobQoL1yU0xm3p+CmrwdBNIzvyWNJv2lpvzlv42atA5B9zV9iVHBG25HulVc7GcL9I+WZ8ttASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

For some Ethernet controllers, the PTP timer function is not integrated.
Instead, the PTP timer is a separate device and provides PTP Hardware
Clock (PHC) to the Ethernet controller to use, such as NXP FMan MAC,
ENETC, etc. Therefore, a property is needed to indicate this hardware
relationship between the Ethernet controller and the PTP timer.

Since this use case is also very common, it is better to add a generic
property to ethernet-controller.yaml. According to the existing binding
docs, there are two good candidates, one is the "ptp-timer" defined in
fsl,fman-dtsec.yaml, and the other is the "ptimer-handle" defined in
fsl,fman.yaml. From the perspective of the name, the former is more
straightforward, so move the "ptp-timer" from fsl,fman-dtsec.yaml to
ethernet-controller.yaml.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
v4 changes:
1. Change the title
2. Remove "ptp-timer" from fsl,fman-dtsec.yaml
v3 changes:
New patch, add a generic property instead of adding a property to
fsl,enetc.yaml
---
 .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
 Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml    | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 66b1cfbbfe22..2c924d296a8f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -108,6 +108,11 @@ properties:
     $ref: "#/properties/phy-handle"
     deprecated: true
 
+  ptp-timer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specifies a reference to a node representing an IEEE 1588 PTP device.
+
   rx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index 60aaf30d68ed..ef1e30a48c91 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -81,10 +81,6 @@ properties:
       An array of two references: the first is the FMan RX port and the second
       is the TX port used by this MAC.
 
-  ptp-timer:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: A reference to the IEEE1588 timer
-
   phys:
     description: A reference to the SerDes lane(s)
     maxItems: 1
-- 
2.34.1


