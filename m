Return-Path: <netdev+bounces-147186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034019D8222
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899C21629DA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690CD18FDDF;
	Mon, 25 Nov 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="icfpMaBF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B701531E8;
	Mon, 25 Nov 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526606; cv=fail; b=Bz1AQM8utsD9CHQUB7qvJ31jFi7A0ByrWvi3SEzquYvsuvQ/27b/GhG6ws7C0ondcUUu3BRK5P/Je9yt8Fh2u08G5pYdYMsxClv93w7EYnfYjhKrPUdLnVXYRNlXb51Mfcu+VoVE8o0xgUOya2cV0YbQbI+t+JjArf+h52vuqxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526606; c=relaxed/simple;
	bh=/Qny5A9R2CmLvbleijfcq5XA4IfpcXsukSqzTJfxnuU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HDXA4lsoXuDDwgctV+QK8AxpxNioX8Fd5aYcmIEEIbS3FrlxAEaON1CL+CrdbLqBQ8H73RzufbAkJbz1hrU/cgLB62cr7IF4zJ8xR43n88ejvoyI+xIASo+6TeERYZklhOVVTPtlj5PoFyarRNUXc+ZChccmVH+Z1M7cI0u0tYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=icfpMaBF; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3IipYllezQuGv5xydkDuXVBEkmhYT0cFIPODaWrj3kbwqsCQfoEUODTJEIxIYcekHNV/Zy5sfgYr8xN3UgHyU6fslhxBWUYzw/jmdwUIF97iehEfdzotLZQpxyaG3+tI4hgUkZMymrUM5SXhbidZJNR8PdSLN9fIQMbYUTora0RzZnU7uAgzOaHJYpORNnanK398Gcse4hZP2R5HxF3Kyxal6gYjsYefDJsHr8C4lg6tLS/pjY4GfGVUizmGwbus9pvDy5m6ZZ6LSlmVUcOQuF32t/+4hwsJ96mpfQ/SX1aMWYf1DlU9Qf5IfHHWpEVqsNKS49Ot+dcewMDjxoS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAUBVZcPbR8GlwOUt/D+s80x3JRgnncUcWkatDXV51E=;
 b=H3OfmsX6w8WjlOyQeZPLr1I4Ah0E9IWNMP4yRCtBrklL/aNXycG1Zwy/qBtKkJiyPRcR69q2GDbAB5niV4GOZYL3iu6xVYeYEP+2hhGIFZwXo3xzIJ9icHxnDaYeM5fR9186tRnC8I+XZkgx/0p0BYTrHLEGL3hFd1FuO424NkxJYZuLViRbd52jffMs0mS8vCfxsWPMiBKDbCpnVoZV/dvuOfYhYXT3MLnszXX5UzQsYsvJLoDyMS+aTnC9JXFP6ZlYBZqD0no/FQhz9ZWBO4h+ajGfKT8+52Owu1BwYdd7hJizaC9xmVwNEcsfZ+YilYNVC5UTLAOQJUauR/z+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAUBVZcPbR8GlwOUt/D+s80x3JRgnncUcWkatDXV51E=;
 b=icfpMaBFEu/1YO2lXUOp4htWZ7m9jBAlCCqltw1HC62fqTMfAO3J608ulAkyn6e6yeGY/lMaWcdg+Mv+PrTkYobNhfHqUh3EoiJbP2TXNBvtIspDURymsshyvhZWw1H6grmwzurgbRuIM7LRcPMwEZ0h4x8zRLu2k3acmCGJiCDcGOSf/TexiqnYXCiEVe46znnYSnIN+gWDUZ+1wXvcO+ce55tZb28iSE5qZFbpDHUCXIi/ssrpebBpSuGuCxoAhySDRnkQOys5w1k3JkhFVzaA5NWUAgVRKFZKVbgd2xne1WRgtXcqlHAglGziAAQEZ6XnwI9gg7RAa/lBCjXVcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 09:23:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:23:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net 0/2] fix crash issue when setting MQPRIO for VFs
Date: Mon, 25 Nov 2024 17:07:17 +0800
Message-Id: <20241125090719.2159124-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c4b6e8-fdac-422a-67a9-08dd0d32cd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/97qIh9IISdUg5yd3R7yVF21st8oq6ooo36gNohF6NGSWRo+gsBgfKowJPN8?=
 =?us-ascii?Q?0x7AsnAtB6+YJBMApgpzLMSnYIZ5E4oKFGyk5wVBveM9xoQD/q5DHawDL8F6?=
 =?us-ascii?Q?cNtI6zfvDqr1sofLwiNtEJ/VxY67kRyrdtObdjhziBZo2IWgeqKTgh0wEt49?=
 =?us-ascii?Q?7rb4gAXFeDHBD02jLdMaALmgDaZDXNUzQbycQqjv/UvNNTph52+LIBDJyiQW?=
 =?us-ascii?Q?uEjan0C3RBnJswe7B4WwguiqaqrDn2PXzcykFBm8pwb9jGK1jB/WWn9aLJE4?=
 =?us-ascii?Q?imwWFz3SliZ/Mu8PIxTNm6hlVjfkOUX+8Fgad2dXZwHt1aq7/njSaXivnYsd?=
 =?us-ascii?Q?VNpV7WmuzJXWfA0YZH0nepVrWJhNi/jZUICanQ7JCkRDwgMovRr1b9+GHmrj?=
 =?us-ascii?Q?uOWBbcX3Du2+OzgyJKvr5s5GoMD+sDd7yLMPTKJA3l5U6dw4jptX/d8dpNyE?=
 =?us-ascii?Q?K53eLMN0Y+TjnwCXai85PUNqqqEr67aiOeIbblmg0bsMiJ6Mqi3uHj/kppoO?=
 =?us-ascii?Q?qo/TNnQDYFwEQdWw9EMQNEAJkk1MCWxPT+efkesJX+/wOQKzWMKsOJXmdzMQ?=
 =?us-ascii?Q?1GFf7KTwxtuwTEv2bx9rs6lIDZQpE83e0/iq2m3iDwbaeP/+TO2Xx76J2Ucd?=
 =?us-ascii?Q?Z3BPjriJE3Eui+A5Yc19zcbEjm2YpSH13tQhMElnI3AJd20mL2l4YMv+v0nZ?=
 =?us-ascii?Q?Nsivllyq+wA4fRWVixHBjvuyKYACE2KdccD3ROHgFIdG5C6cjgEGq0jr6hJy?=
 =?us-ascii?Q?ZVQ5QlI1HnZMM4aGjcHqeFvtVb63VO2BBQJ5TR3sTJtZYa0f2eQVt3GAJLwa?=
 =?us-ascii?Q?tFvM01/Zb7yHoPCxgSUTJv3Y14QdjnL6gJS+erE4pgqZTf6/CChMCprvhMG0?=
 =?us-ascii?Q?0b7FoZh3iAFBCOuNw4yPqYHPmUL+9bSIWXqxf6YBYrG8rMMtVo0HGWasAhFi?=
 =?us-ascii?Q?7ctls8q0NqtaCJAFKwiZrMXWOshNJEBC0xR1vmGmQraKi3ii1vHojLIi4Rer?=
 =?us-ascii?Q?N7yqIZm+XcFbOTsqz1yLDzTSXJOHaTnmnYhthNYl7yAeHlAN+rXfO5j7TEv9?=
 =?us-ascii?Q?yYhvpPPa3k3oBcqrZCcAdjkT1X/9UAzqCOUGdT8J6HoeX40ut88wdmuaXtwv?=
 =?us-ascii?Q?FqKD5ZjG4gMQ0W2kqvWzF85OgEKe0jEZ0mjfN+uY3YW5pv4FQDtPRxgbY8RV?=
 =?us-ascii?Q?pXoZgUaqNcp47hGVkQhl5YMswrZmZF/L5fcvAJnloM4HO5tAT1gbYJcZSqUr?=
 =?us-ascii?Q?wc3/Q3Zvo1zEMhzkcrxMyU5Tdb+WWb0T7WhJH8zYrmMUuV72ujhfN+rohoGY?=
 =?us-ascii?Q?5eWOaHletIFmpuqmeR2WAbeBeoQX51R7N1PhYIq6mSBNvkL4RNYhbvBrHIG1?=
 =?us-ascii?Q?p32PdSE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2R2PyHxk6l0pvtezWaUeQK6Lm330MwyAx9AwsMc3yPjG3myUbw0j5ybpU75a?=
 =?us-ascii?Q?CzaNbOAam7wdt0lAdUu/ef3IM430cOtcsvW3eOo0C0jK2TNT5pOvElCFol91?=
 =?us-ascii?Q?q8KA9Sm5yIABzsJIrb/ierHfzvvl5rSghvui7Z9vFyCVHS4Kz0RT5JXipcMA?=
 =?us-ascii?Q?k44xZ861/8lr7oMXVUm+sE4LnGmiDenWhxli6Y197iKN92b6/YRO33dvmKxy?=
 =?us-ascii?Q?jtJwesoP+ZVUn7oDM2SieUvCh9kMx6WuHBtWqGDbW9QTChH8dWUO1pdsxL5C?=
 =?us-ascii?Q?NiNfqNXI+gpV1XJ1B+fWWtUJELgaL4JVrUp4R8cSfqarhX28azqQX8XskrgF?=
 =?us-ascii?Q?o4ESMYNpfXJaOuTVHbweFRPoRNKkFETtpt7zVphU6GMGuvZb0rU0d6WqjAtb?=
 =?us-ascii?Q?rQwrhcnSkCNM1pciQhC3BbxlvxeoeGLiqO8iWp/xidF+WvKSHOpVdHTKNR0S?=
 =?us-ascii?Q?D4Vk8ZrKo+JmtzFNGEd+qrd6PRgbOCvWPLIBRABdU6HbD1NZuLhWeGYehHJN?=
 =?us-ascii?Q?VW6zsqBFHiYQN4AP+FNovbcykMiiX+MV4rqQ2xgXs0tf7icmYeX55p9NHsDM?=
 =?us-ascii?Q?1gjzx2hlYDH5JH9twqMVWSSI2ci97thuj3bOH6UYSXJoZu72SMQNLgOLVS3y?=
 =?us-ascii?Q?rfi+x+LCkfsdLZ0YatYGsspH0viuJZn9YkUspakI5iMVoRo3IyR/aYhafUW8?=
 =?us-ascii?Q?9xLUJlHD9DmlhPOcG733wtjjFXVRyGbm6jgIGXSQ5uP38ezKyBvQP7722HJv?=
 =?us-ascii?Q?PDdbNLOwxe+vcGwrigB/cdyuLBPn1/VHtHOqjJXESaROsrbXb0hY0SAyCogG?=
 =?us-ascii?Q?boAI60iX/ND+XJ3Kd86pyIeCwyMV20qIZFCfAuKS76U/wVhW3O9lVfEh6ksN?=
 =?us-ascii?Q?MhGuDvYT0U/VTF6kf/bG6kwHqFmqgUnSD613ppGFN61LgLisy4zIMLHhd9va?=
 =?us-ascii?Q?ZGpwgjb9mBzqxtpokU4AXlZ51BWDJTGeeCJDaYpUmbw7RwCHiJllFEUqb2Vu?=
 =?us-ascii?Q?wEfh4sKp8akVYeVxwXzwhJ0KOAZa0Cuwi9Ko5wdiN+p1tm3K5jO9mpjArStN?=
 =?us-ascii?Q?zTWpl28TvdMmNzSpQAUoIxZGdZkp5ol6/AtlfDNqinI/IVHaIcaLmi9uL3IT?=
 =?us-ascii?Q?guHti9+SYVGN8ZMdDxCHFQYPI7xUYtxG31VHNGSDzqpvZDHnBvw3oR5OlDp4?=
 =?us-ascii?Q?fpx8Fvy7v81bc0jcCWRibq57INkkF9L7nW1qkF12D3ob8ExFf+0W8tVQf2wh?=
 =?us-ascii?Q?MtBmGofeq0UxPK2jRbFRzVGtlspTMuK72U+hWAbtVe1UvHCdEAlRXb3vhuSP?=
 =?us-ascii?Q?1Y48prY3MHeTTab/9c9sHGEHpWHmijfbIJLVlEaZVVm1QexxNnpXSANDcqG1?=
 =?us-ascii?Q?qtBRCJecWsVcLdceIzN9KjM5K9EGBO8r8q3X78A4FoF77ngn3q0TVNKBJyc/?=
 =?us-ascii?Q?d8TNtf77xp1vgmfwWzwy4iZoyDHDBojH60k/wR+hJ86/K2EiMzXKucwE1rzh?=
 =?us-ascii?Q?WQrpbRoc33ncx/ZU99bpdti8at+9BNTfId0Thwp/Okn+/tqB6hfd9keHTvJP?=
 =?us-ascii?Q?UdhN/K+k2yJhmZW57g10vDhjoGlvKsN6EniO+H6w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4b6e8-fdac-422a-67a9-08dd0d32cd67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:23:20.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmsSK9xHzp9UPK2GpObjSkvd/7vfp5xr4KdAeD3twpYT0GDo1MY3z1zNGJft2I1KiLfJHHAM8rynI6C2m0ZOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

There is a crash issue when setting MQPRIO for ENETC VFs, the root casue
is that ENETC VFs don't like ENETC PFs, they don't have port registers,
so hw->port of VFs is NULL. However, this NULL pointer will be accessed
without any checks in enetc_mm_commit_preemptible_tcs() when configuring
MQPRIO for VFs. Therefore, two patches are added to fix this issue. The
first patch sets ENETC_SI_F_QBU flag only for SIs that support 802.1Qbu.
The second patch adds a check in enetc_change_preemptible_tcs() to ensure
that SIs that do not support 802.1Qbu do not configure preemptible TCs.

---
v1 Link: https://lore.kernel.org/imx/20241030082117.1172634-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241104054309.1388433-1-wei.fang@nxp.com/
---

Vladimir Oltean (1):
  net: enetc: read TSN capabilities from port register, not SI

Wei Fang (1):
  net: enetc: Do not configure preemptible TCs if SIs do not support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 12 +++---------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  6 +++---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.34.1


