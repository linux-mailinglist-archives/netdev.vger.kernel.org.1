Return-Path: <netdev+bounces-217188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02600B37B1F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DB3B1EAF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BED3218DB;
	Wed, 27 Aug 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fH5pP31c"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0B32142C;
	Wed, 27 Aug 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277792; cv=fail; b=qSIImXA4+h+gmhHzcRoChd9XrncfHnOS5ONzCVKJMUmj0LwCB6tUVdHQL82BlRTYXIMu8a7InfbTZrxBCZsGyZS8B85faIZHy+/8LM70g9zT6O6s7BAq6st9NMu/NCJGjiQQoYrhGa/bAkf7lvj+WrSp1kIWHB1fiPjUjupNpvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277792; c=relaxed/simple;
	bh=Augdmc+SRAzpIoGRExMMbM/my9xW3ak2ENWpzl947tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0snaJqmmzVpxeLeTNiYXxVp3f8kGE8E4jKcE4IPRhdIHL0rPBFdBEA56m2fi3SJpubnE2zKb9dFgaZ7xoWfguO+S3e8nQLTIVQC1icOW6aQalikx+h+R0sioZTTSa/sVtCSMiE2XVkw9jJ7Dd9wr8QHoeUAIQhthpK1VP/e4tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fH5pP31c; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLU1k9bnQ6LWzYdeQNz2ZdzmBahfVRdMbRD9fdyaDsX2vXY7X7v4EM6MigtAb8ga4XO9R7TSmQQfxD+AO2wgsPe3W47XdjPH724h4mzg2wUds31VRhPQZfnO+jFCMrTwO0TZySeoZLk+k9pgIChYh0/SzXgjOVl1dmLX9lklP8/gx1iIthrpKvMGhb0DAGu08YWI1zc0zncxDDwAqdzDo7F2F0DnB+5F9PH1TsH3G6Zk8QOGsRFwfxXsNbxsMT5eLnnNJSLWS5yS60zeBvZuTdcrpVXHF/gQ2Iv+lw7qDDHyOp8sJQNRup8dl6XCGPFjQD/KdzHZgAhwzevCUT9rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6kPd/5bgdVjrUTuCmnZ/QSJkObkEruV7d1+8ZuK1CA=;
 b=B2CJxzqQLJL5xCYmujjKYyTqQK6peeiVyQEdwPI+uIK0xvUTQoq6lXvNS9Bbk9ajisYOzPORuQjqWxU4PuARDaYzx18vli1m9nMkqAqG3P+jKRi1obJD/Bgy0DzTvFy9Hz+X7mNzpZUgw3LAuySicyJE4MhLfnxNm7k/OGQtJGzgx2n+cTY5EDOFVrOwnJ14POeR5ba70oSHxdmkKt2o0jSx//L9cGlZaK/a3+LAqdRSl3mUJC2MInNMZ6sTLoKD5btCI2EGh4/4lr7wGFopHFWOpUcxCX3XLt4Xqr2QUHNVKHhD6mSNr+iIo7pxWr+v/7akHg7tl/RBK9IJs7ELqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6kPd/5bgdVjrUTuCmnZ/QSJkObkEruV7d1+8ZuK1CA=;
 b=fH5pP31c0ULpwp/7EJsTEZAJyeBLC/bIejAA8Hg6eZArtHT2pijC4PZoPUEVMPyS7rSzPz9qRNMIgtrLHo1goTnPXQjbvYiP2bfdgEgVYr2aECEQYcQE6SP9UAQ76bsxnuTCX1Rj460Yo4szoDUwNDctYYQG6hkjQ/XmYzJuOFnztvJi1Lbkdx2NcokkvL+JdFFsJ+p9WxZz3Ntq+NJs/+2IiDFDpzwsNfc10ksYrqY+CQYQaJ9MvHVSLc5QgdLB3u8YOCBjxk4wmrBX/Ez++9SlSOWMAdwJaj7Pnw5I7R40qvJuLIM3Yc8i7gncW12Qmy9/r8dpfmy8Ufg74QtUwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:56:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:26 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 15/17] net: enetc: add PTP synchronization support for ENETC v4
Date: Wed, 27 Aug 2025 14:33:30 +0800
Message-Id: <20250827063332.1217664-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 13511d51-abf8-4cb0-bd9b-08dde536d701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0czib6xUGgzFr4ewMxfjwgJE+ZvTof3+9kuoXidkjUdrdmrUiFE72Gpuz4tT?=
 =?us-ascii?Q?2OPBiguQPOzDYpgcYcNpH3pF74UvhFNSgy+CsLAw5Htkz0qX8DBwRqsJ/n1c?=
 =?us-ascii?Q?KckI9IPXLXG5RyfFRCX92Cks0g2wcv/tX10V9HUH2HfsPqGfix8RkrF99dVR?=
 =?us-ascii?Q?eNmfyvcNeu1iPGAiS5n1+floUbp1UYWbAS/Rf9N6d80x4Mlejnky69QDdmiB?=
 =?us-ascii?Q?/DZuB0R4d3dBsnGN18AQdI88I/m/w6U9TSgERvq7ZUHev8kL7ADREpZcwEfi?=
 =?us-ascii?Q?qDLfYZY0lNWsJe9ydqAfjd1aaggJCHNJpwAZ7qXfssvmuQZfSSUuzL1iRAJr?=
 =?us-ascii?Q?orR/0BZHX4v5flsuuLeQaZhd30nerMSszlgTEWbOEqlJIIR96tdeaYPe6jly?=
 =?us-ascii?Q?O/pVj7QDZ0/63quArpNz/ifIL2oIrLFAZ5+AKwmuZpzK/UlKtrij/O07xA38?=
 =?us-ascii?Q?AdviQ594R90zk1LqR/4gf+pbX6weYjCFCowuehuLx/XiaoXeudDCDuUntJ54?=
 =?us-ascii?Q?hkneImNa491YIkDgzf0ohJ6J+1lUExSUkDpM+n7FYUjdYLazdL/cyUVtzWef?=
 =?us-ascii?Q?bblTyeKkMHd8qDb3TYvoVo/L9aeQB0d7FA48PiAmEZSkTjQIkv1kkFUKwo5S?=
 =?us-ascii?Q?WWMp1UYANlL7fL/YCIznJWUn6JN1dPT+3JTl5TH9XedIuinwRF6sBxJjxffs?=
 =?us-ascii?Q?EJDHaMXnndEReJHUKo+prjqqahGp2Qpr81xdvO/Ia29ml10bNmMU9AdjDXJj?=
 =?us-ascii?Q?AFSrzKRZG6PoPBywyBJtiHO1suMihDKHyAsTcoFoc4wUFLP0dIbzU+BVIH2r?=
 =?us-ascii?Q?FcduNdEGcNwHaP+zSAwDdUW4H4Ys0LfHPk/N+4ENHGWeXD4nc8RM6XWpgzEr?=
 =?us-ascii?Q?FtmRMy/fHDBMCxJ/694ae1k+WQ+Ln0zQwBsIF7/iF68VtT8xZXm7rExdPPan?=
 =?us-ascii?Q?qmKfx330C0mSTHnfl1MqRIqbRH5e+TsXvmd+GHJ6hJgcjx4OM/vWYlg2Lt5P?=
 =?us-ascii?Q?6p8D+DsTHLVeiIlk2wwifZ2c7K2P8oKK5WUb9AMAzZ+0HRqro42INq2P+tOC?=
 =?us-ascii?Q?DC2Qoy85G4kuZ4mKfLFDEryEh/WDMlFeUr7VSOkX5kL4OLnpUt3mwmnFlTq9?=
 =?us-ascii?Q?jSAX4c/EQOjwMef2EL5RyRhfs3wFKhMON1OzRInNgWy7udZYFeZBnSe+ACiI?=
 =?us-ascii?Q?2t8axXDrDq7IUhx5776raTOmjj746p7ACuitx/VzYEgBLt07IlBqJj5z9pMo?=
 =?us-ascii?Q?+uhXJB3+tGpt3T4OAvB5ne8xhygvsQfDSOKAZFW8GEPSJ7r5TmkT28jQ6TKj?=
 =?us-ascii?Q?G8D8uYV00nhyhRJRq+fCbqlfpCvdMK7CsTSBd3jzCPGsTvK5cBLjImjnb0aB?=
 =?us-ascii?Q?ljtgkwR6pj9sDLn4znZCu8rjrzkvUWiNMX7HLw+7WtSvNuGas4N2hfTW0eDD?=
 =?us-ascii?Q?/G47W9j3tXaclPr/T7FZo5OOr4PLsigyedMYD5sRRHSyYo6diLOLlfNwiwV0?=
 =?us-ascii?Q?AyitRdxZAYA72Rk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1nLlFQ4J5EyFrKK/YaMcSvFExA1hRgimS35011nBA5J4R7vIwrOUjhL8qtL?=
 =?us-ascii?Q?cF5aJFGWmtNNJl1z9daEh6gWX6wHHY/ed+++tpo1fRDHUd2oq9shLxtmsD43?=
 =?us-ascii?Q?4xk74B+WZWPgcEY2gI4ysJ1tFNYpcVPFErN6fX6SVYDoerMpaFHa+6Q9aTDf?=
 =?us-ascii?Q?ekWsQrJzISugTNPAyJQIxjnbFXcKWbP27sN6Gv4l6ehJsPqCDiNsOBTcQB/b?=
 =?us-ascii?Q?UZnTDEZ9Ya2HJoWPpioVyIXlM0Eyr7L37XkKRx5dWQvbX9Aw0u+K6ZuQJccL?=
 =?us-ascii?Q?SITlFTWoOsDx0yT+V2x5tFkRXztAnGuHr2l1ELVeWrCiPz7L5YjGPouASfIH?=
 =?us-ascii?Q?AveUA9xRDOsGK3XFW+/n+t9spejhwx19EEOe1W+W2/c9iS2Gjv39TfLu/pdR?=
 =?us-ascii?Q?VOoSajFKmMKlmuys+JZ/QzTcm4wD9a6YeAlqYSgg8dcuj3QY8nEosWibCfQ5?=
 =?us-ascii?Q?UCgGonmjS1b99EhEIF5YJYxLV20WrkdM9RbqoMdGAdwaEh/8SRKrE4qpL+6K?=
 =?us-ascii?Q?nFx4wamzw8Sn705Ep8+yBVetlb1ucXE18VSHP0fjIEC0js6GstNXhHnROYxF?=
 =?us-ascii?Q?7W3CrnNG+anZdutKBNQJaEJQlYXWei/147+moechAT+1ymSW6sphHeYQlkFk?=
 =?us-ascii?Q?RlqEW5HDrz4Gdelu+ZIsO/rFHj3ghTf7+tGAxPB2Ubch2gxzY03HHmWHyp/y?=
 =?us-ascii?Q?UMSzEPzOH09MD8G1ox1DQlBLMvXnIueFeVqH6utr2YjZSNMZYC4esDgvdsJh?=
 =?us-ascii?Q?lJA2nTkJsEIJYekf/gEB3vrK7gyS630VI73s3FLCVL9tSuzfZ9VQqPxDvEBG?=
 =?us-ascii?Q?VNCACWWCvvWBYKsj0yLG15nFwC/ZCwV5O3+RcEZBCdDWLf9hLJnPDstLb1bJ?=
 =?us-ascii?Q?g15NNeETns+AF402MWZ2r/Yr9llFbx3MCdhrA/Cqa3U0/YAj3j5L+5D9FLER?=
 =?us-ascii?Q?wvOLxX9YOF6vGQqmSkSV34FkZNIr8FuXFsOBcpXf9P05A5NfMt+2yBqzfccS?=
 =?us-ascii?Q?TVv4C0FcbMKIWbuA5U1WcB128xNSJcrooPt9QLMNImrvXOO7m2OaHIcUGLzG?=
 =?us-ascii?Q?ATTqyCvMQeEEZA38rIpgP/vAiNH49R+6rwlgr2pFlsbSe1yr5PqVCNPitjkR?=
 =?us-ascii?Q?6gCw/wIE3upwSvWTAPl0RB5fjskjsJktYuwSwqHEBeApYmOkaIQq3CGLpRhL?=
 =?us-ascii?Q?/xx2P7OBWF2RnzKYrrGZQl95BEG2SyBpkZkqv50+f5vsQliO+UpXqMl4/xbj?=
 =?us-ascii?Q?g4w0ttIb+pXGlKthqWOrBE6HVxxO001I8UptRZ4iiQvF8IgrMltioYT77h5i?=
 =?us-ascii?Q?sQbrT64fWxMdNY1DYqXQcV4d9Q4oVLKR5ZC7JX6Rksg+/oIFN3kW8QVbcGRx?=
 =?us-ascii?Q?7R1Zi6diyTtcc4vXcm/fAXT8hQgN8q7j3cB/9PQIdk1m1bZz9fnWyoDuf593?=
 =?us-ascii?Q?OjUMgl2y5D7Zb6QmMCWe3c+vFZQPE3AkfM4epnqy5Of2RhMJC1FDqKEwD0uZ?=
 =?us-ascii?Q?uOaTyE1+RnkYW70jtvxd+VuDFUgGYiwkO6hlYlVkvxTSlOkmT0FLDW5lWHL1?=
 =?us-ascii?Q?Fap6q8/+aTjLJtYcc9TRVdR+ndn2PthEu3edpcYc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13511d51-abf8-4cb0-bd9b-08dde536d701
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:26.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lEpkI9HHLjAyPx41HYE84cOTPZ4s/CzZwmZ5h5n6oX3K702JoTrvAWN3pbpGlbIGYHM1feOmdOur6pXz26SYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

3. Since the generic helper functions from ptp_clock are used to get
the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
may be changed in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v6 changes:
Extract a separate patch "net: enetc: move sync packet modification
before dma_map_single()", so update the commit message.
v5 changes:
Fix the typo in commit message, 'sysbol' -> 'symbol'
v4 changes:
1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
of this modification to the commit message.
v3 changes:
1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
2. Change "nxp,netc-timer" to "ptp-timer"
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 40 ++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
 6 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 54b0f0a5a6bb..117038104b69 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -28,6 +28,7 @@ config NXP_NTMP
 
 config FSL_ENETC
 	tristate "ENETC PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
@@ -45,6 +46,7 @@ config FSL_ENETC
 
 config NXP_ENETC4
 	tristate "ENETC4 PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
@@ -62,6 +64,7 @@ config NXP_ENETC4
 
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 25379ac7d69d..6dbc9cc811a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* The "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -3315,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3365,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..815afdc2ec23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 38fb81db48c2..2e07b9b746e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..6215e9c68fc5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -4,6 +4,9 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/ptp_clock_kernel.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	struct pci_dev *timer_pdev;
+	unsigned int devfn;
+	int phc_index;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return -1;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	timer_pdev = pci_get_slot(bus, devfn);
+	if (!timer_pdev)
+		return -1;
 
-		return 0;
-	}
+	phc_index = ptp_clock_index_by_dev(&timer_pdev->dev);
+	pci_dev_put(timer_pdev);
+
+	return phc_index;
+}
+
+static int enetc4_get_phc_index(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct device_node *timer_np;
+	int phc_index;
+
+	if (!np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	phc_index = ptp_clock_index_by_of_node(timer_np);
+	of_node_put(timer_np);
+
+	return phc_index;
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		info->phc_index = enetc4_get_phc_index(si);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


