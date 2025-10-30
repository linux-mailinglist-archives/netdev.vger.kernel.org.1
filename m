Return-Path: <netdev+bounces-234317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26074C1F54A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4FBA4E066A
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1572340D81;
	Thu, 30 Oct 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBpM6BAQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08FB315D37;
	Thu, 30 Oct 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817068; cv=fail; b=QdyWdfWJC0/6gq3Cn6yyFA9nRKUV6NgbYyQAXPkUAORDgURkiKSfOrb+J7gTSJ8b6OMf5w023vCFqqlQclJZVde/9nZqqxE6dgra3MsHWiCo9V+UnowTFvARiOn0wX4BZdvoZyMc19Ff7wIIGtEHoZj1Uw69nAT0NnP5w1P4Hmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817068; c=relaxed/simple;
	bh=2luP2E/xg8Am1Z8Ym7JT49OfNNZ/FyRodTR+mEbs1rU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DnefKErZFRRQJTO/AyWmY9jxV8ly01FjQu6dkPsjolD+9EB4R89kHbCzJ7GuQwgH1fNTdzwwAN2Dmo7Z3N3B+L1CQmxs5MSrIQSG5JXuyJIDpiOQmIvwXcPutWiZesEhejwUJYD8GLramjTA+tB9nPQ9mGSkYiVVKMsBz4BcMCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBpM6BAQ; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olg9kcYfnYz2Eum6+FkZVHb0PzJZYtz7blmAWYAnwOt4GBjOLQ6cO1JAvXzLQk3vqBpqXPkI+XYAPSPZ+3kbqlp/qrdAAAsp238SmHBzfU5zUoXEbm056w/mAiKUhEaTrHtPKeRgRPv9n+O9ZBQCXGdnKW8Ux5WRriPuQItVkEGQ83jMi8JMijdZXlztUR5sk3VA0ehkIocOETiDcEiA/dWns+ZIsF3MDEJRpKx13ioJ+86H0+zTxiw/3Mx6P2TpBF5bB+v3t3Z3SM7PTbzAB6L8g1wfTi+0YkuG9YJDua8/yG7jH1eorlO1Gzs3aJtrBgy1XTdDiYQUHLdb8bRh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nsk2x6EncdSoi8SJljQxIpQsunDlFlo/nq46DQK6QQ=;
 b=CFK+3ee+ebFOMzERQZCTP/v1c0zfFTxmxgBn6ckA8pdU9QIF0V5xgTIxFJ4LkslQfjZF+hh1utD9AzJiwzqj3SsE94kJ9mOcFCFdvh9OFduqDAuAmiLdXYAJam6hAfuOgLT+JY09MaTY+ZlIiK3DHk6r17vEOq2hXXZmYIlOclaJ/hBIhYwtHJj9RDtGLDTS1dKp2K35k70lfOhD9ltEd3qZ2x0KUS7wcKe2NndzcrCwshYVAOac6yPEb8UbIs0ssLqh7qBQu39poVx2+4P3Z3Xh1INr9T0lksfdsHN3t3rL/GBGylojmpMXB5K7O72KMiYguMzubJC4u2/2G2egAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nsk2x6EncdSoi8SJljQxIpQsunDlFlo/nq46DQK6QQ=;
 b=lBpM6BAQMuCYz6W10K6GMkCefycuAFcqXVUGPWKiAhmILVXE1W/laOy+6Tf4C0RObo5lJZhlIwxaQsQhgtS8f/li+uz8GOWEhKFkSj7Ug9s8/irzf9l3183zmqNByjTHq0Ja7nmunBkhRP3/wiWxw3CQ+pzP72LWuWOERCE0ds7H/IsmtdWM0T4JuBmIERifB6jlF2YdSk0IfS4eeT534YemphCkbeVuQJtHA6/dKcBZ36pJRJIsWNoPrc7x8TGOOvUwieBA4zp8CQFeJo+5NtiKwP32Kf/4UwwjVw3Ey+K4E86EJgIMGyu08MoFsfiSYY2SX64LjPIC6HEzHuPMbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:37:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:37:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: enetc: add port MDIO support for both i.MX94 and i.MX95
Date: Thu, 30 Oct 2025 17:15:35 +0800
Message-Id: <20251030091538.581541-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a435a3-08c1-409a-d663-08de1797f99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?arU8rjqhSigNNiOJHj5qZ2i5KfE31Xuu0HIKjJ0Wj6zEZOOEx1sia/d8ufIf?=
 =?us-ascii?Q?/wfI61xndAk1tWeYU+bDsXeOqg8xcxNd+clZEfxylLmZXqefNuH72Sfwe6Rg?=
 =?us-ascii?Q?vGM0NqOTV2yeRGlh4c62DwuhVgxomF1IYDELUQgSaZvyy/ajGxnKfb86gGy7?=
 =?us-ascii?Q?jCdJuwH6ijQPuhAPLnxY96BEVYMEVfMQGfWa6Xhy1m8C95Hk36PhgJOvWrYS?=
 =?us-ascii?Q?kjkBPoAvi1m4jgNqutUZP8gKr1J/VsGQ6+lJPvXqNMvCS8w4D7rnjZ2frTGQ?=
 =?us-ascii?Q?97exkt7ng6JsgbMFeEWJm8/HjI1TLRy93bmsYUM1SIog+Re3v8+QouZAmtrV?=
 =?us-ascii?Q?LsP62zQZyS3nG4xin6GJEbxqYjbgHFVRt8I28X7T0KiLv4mfCkTTcfC5xSj7?=
 =?us-ascii?Q?uQnf3Bgupv7QLswZNjunsiXxip7+ZPLnZH0v08kDmD4LHy6Q9yAofJY2RRUR?=
 =?us-ascii?Q?Ze+xqSfTLON0So1NXevdZ6Y6ZC9t95ZAB5Sx4yC+0D2NMCWqP/7QadA6B884?=
 =?us-ascii?Q?KW52u53WJcRnSm15gHwlIqkgfH6EBtnylvggxmi5iz8z9bubhhEZwLiNTMY+?=
 =?us-ascii?Q?99hsIuQxO3X1DBLgB+mWQ07EbCzJLJLyQTFytptrExuzQDlT6/EjRVPlqxkO?=
 =?us-ascii?Q?m5mXVxNVymVjXSyGzHUcnCoIZQGu/NHitekF/SzhfCcSCNx+ez2H/BXX7I/M?=
 =?us-ascii?Q?aclk0NTWj8xFc4Dflo9NyBWJK45twPpoBg7Qa+fomY8lLowegM9rVLCA6+D6?=
 =?us-ascii?Q?ssLMvt51ZXrxu2NmeOdHdAcPDlLTv2VK1rqXj0u5e+pf8nnVP+PScxx1XlIB?=
 =?us-ascii?Q?CcEPXQ5PEPrYiCxUfcAT+97HuJ87jjDindpzzDgGPkIRP1ZRT6Jza7dwCeZN?=
 =?us-ascii?Q?MCpoFB50BM1yshD6osPms2oAJ9BTIkVUpPtQErhaHOZb0xzEFcx39v/o6V8M?=
 =?us-ascii?Q?s38l+NfMO75h0Sfpk3NdoMkoZWYUu8l2Bw06WZNGzX76BFx6O7D57TzeZkGR?=
 =?us-ascii?Q?S74XXZuxTO1BF+myhKOL9JihOAnzZSiWRItE94vS8NAZRoPb4p+ElYTDgnQB?=
 =?us-ascii?Q?2yw73I1I0qJYE/U6AR5C0Xrm/fWTdmJf3LDwi6rRRkWAtcPL9YNfeuA9CKHT?=
 =?us-ascii?Q?3okGCfOIcdQfKK2r+lehGkeXVWcaoL8rCUy+EGBnvN+i6s78mGGLM/LDFWuE?=
 =?us-ascii?Q?lOXFRkmH3OQnKn+Hp7qe/iJJBR7XZUMsgrnE2WdL/nYT6FScBwqnTgl7JlXj?=
 =?us-ascii?Q?BZCqyXfLGMSnk9fJRYzJbVcfZ27naMFJOcohZT3ZKYGe739vKY3bdyfpC4Js?=
 =?us-ascii?Q?M26R6auvTZLdBvTUIdTkU7HAD5ui2148I2XlrwbnPapJ78vk2IrqEBORGVcQ?=
 =?us-ascii?Q?JxBuPHNcoSzz736Ez3NyB5+MbHRXKapiHsjFkTs2089aOREh5CQlXRI1Gh+t?=
 =?us-ascii?Q?flbvcQvej5o6/JszkrXl7JtKlt3eH4/JmbdGo8DYeylY3oqKqK89LWTomFV+?=
 =?us-ascii?Q?I0n9GITEp+7pIX7W1ikInzMPqtD2eYe52Qxd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ijMS05MeWPgzUTjC5v/0SAxN/IRkUNdS3Ka8kLyEn5lfz8OCjr2qqDfcfUtF?=
 =?us-ascii?Q?MuULDmjZWG0+AL62TNx+pXFdP6IeJpJpZpC8bMSl6mOlz57wsJNnX3LbUHYL?=
 =?us-ascii?Q?WRz+6AIE95Z+hhRTxdA1MnUytcWRDRGm929uSnRaRni2NXFC95ifU6U5d+Uj?=
 =?us-ascii?Q?b01iYZjN5BgXHv7cF4vtC2cgYuzEaWr52S7CUUZEpRnKnQgpUENcb46YTuXG?=
 =?us-ascii?Q?T7VhTCnpGBLe+W01vcAYM6gTHXw6/bCet8e36a9dZCmiHjjOIm0LPp6RjZ32?=
 =?us-ascii?Q?fJqy4JsnkMRBQe/OTlkTcyGUVVawyG+djWLAejlpvPvzL8kZ5FnBaf/7H05L?=
 =?us-ascii?Q?gFyG96ifAYh25QVI5DN7v/pd40OYQwL9LM7fL6SozWEP/PtF4qnEfy92F9Nf?=
 =?us-ascii?Q?7saW7euYfim/Br/6mgQtNjOHRJI4iEyFfxvGqTjfYRSkmL7TA3IgoRgAxDOJ?=
 =?us-ascii?Q?A4qNJgdwO2UMygC8ugtB9Jn/qNeVUqwgm6MLpjz5d7Jur4PgYOVUADtv7MJZ?=
 =?us-ascii?Q?mRSHB3Jqs1loCeotivQ/5UXcDNU3E55+vJbjxNZqBEhX3N1ECDoyvXswg405?=
 =?us-ascii?Q?rnaOL5N7KeDB6Eem5bL+ffaRERo1+m1gi02C26F2P1tu2lk9SXc6sgaq4/l9?=
 =?us-ascii?Q?R19lqKngdJmHCz7SfvFN5NN36uEk/9kq3/xVGK7VHAy94K6iB80DX5OBYIBs?=
 =?us-ascii?Q?8xG7NIer7AyJxv+uOJ0FnBNPAv7OO62+PHl6Q99exVaRHIgfVTlAK13xUdLZ?=
 =?us-ascii?Q?ZmBq+FQ/8howZWVY3Ex4+sDmrG3nMGo4QqHz0itn7MzXOFCsefbHN0e3Twpd?=
 =?us-ascii?Q?+MQfVu+XhUhwlK7XYXc+PHf29Buzoqy6HKArrMrHKQkWln4aCtskIM6DSG8v?=
 =?us-ascii?Q?RB/duK5x56e64teruVvw5GY1MJwZ9FIoloSQXCTLeAygx0pttzZua93QBnai?=
 =?us-ascii?Q?+SzMUXZHMb0S+EzK973SrT/H2nTp3X3gyvYoIJDfpHrfFnVGKudkv9AOlJ6K?=
 =?us-ascii?Q?9M6tYwKGve3OvjIDANrPtV9PzF6KFnFwbE8VNiekgg2CNsHvrwjznqClZney?=
 =?us-ascii?Q?Z6pxdG+1TJ4Bv9e+KZ4DuWz2fWt5OlMYTp/v1BNntZ4LGOP53QMwZ5zbNXS/?=
 =?us-ascii?Q?S4xJePgdqtI6udq0zspsERtyjRDh8fmp2TP8r8ogA43Iazaoxb2rjv9Ylafu?=
 =?us-ascii?Q?23BMKP/5Rr6xfFx0VW77FgOPp/f/XqlwRcID8SsW3WlmNkZy9ZW9NuCbMrcz?=
 =?us-ascii?Q?/hShfhk9etBMBPBrnk3RHfYecQZk+ykjpHc8M6hpppl6z+XTiPD07PAwytiu?=
 =?us-ascii?Q?e0w8bRCIPAXHo6WRtdWCa+UUx6VixWwTLuX6xAU0S/jX+YhQcnh64kQtJ70X?=
 =?us-ascii?Q?yLX5emEkRf/OqwWAYxboIqE73QR2Vl6CXrW9XmaUkNG8GqCBrRcxEmep4R6C?=
 =?us-ascii?Q?velYEnAQxAsaW0W0HLUgA28O318rmfgNhvEe+80GRfMnFjA6IJstbK0IK4ar?=
 =?us-ascii?Q?2YyCsPcXcBXYd2CIV6CpEjWI41Dz1WXkOoQl3fceMjjPuFopZ+gosUJzVr1V?=
 =?us-ascii?Q?Z7x61IdR3f1LXT8W66P5/bgaixFSrsTCGkOAenA8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a435a3-08c1-409a-d663-08de1797f99b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:37:43.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQfGGO0BLCz7o0OlScBdu2OYbWGS7dWGpnVFWloKf0vx0JEzMArL8CdOWFRuIgNu18SF9Bk/kxyL8X9SNGJb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950

For the external PHY devices, NETC provide external MDIO interface to
manage them. ENETC can use a set of MDIO registers provided by EMDIO to
access its PHY, which is a method currently supported by the driver. It
also can use its own set of MDIO registers to access its PHY, but the
premise is that its corresponding LaBCR[MDIO_PHYAD_PRTAD] needs to be
set correctly, which indicates its PHY address.

Similar to the external MDIO registers, each ENETC has a set of internal
MDIO registers to access its on-die PHY (PCS), so internal MDIO support
is also added.

Aziz Sellami (1):
  net: enetc: set external MDIO PHY address for i.MX95 ENETC

Wei Fang (2):
  net: enetc: set external MDIO PHY address for i.MX94 ENETC
  net: enetc: add port MDIO support for ENETC v4

 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +
 .../freescale/enetc/enetc_pf_common.c         |  14 ++-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 111 +++++++++++++++++-
 3 files changed, 128 insertions(+), 3 deletions(-)

-- 
2.34.1


