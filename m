Return-Path: <netdev+bounces-137156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093E39A49DA
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D61F22EC1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5A190676;
	Fri, 18 Oct 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZqHRZBLH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FC1898FB
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293299; cv=fail; b=VRu4ATka9U/v/wBObziAfcAKpPzSgnE9GLAIxkqH/0vtR9vMA7eETej2w15y18Ks4AxxI9jLUrXyCC08tQ2S3aBu7HKyFWr/1F1zgKyVSZjF9luuNhGLv210hR2FXbnmqgOruHlx1v1CrgVLuivVT3p8pz9OOXCT85npKZvTPQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293299; c=relaxed/simple;
	bh=irLI22um5dGVaMqjsUYY9zydIEgPWI1m46Emtk0IoT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YuAta6Ks5pJNEuaFwBjsvQDEkYein6BjRjFlF8BS0Rbe1B8lkt8m2MGoGXF7VuwNXwJVsw7ROW++zS70Rnxo/OnYpilpQpI1wJJv10aVV+zTqXR8T1GkGt98h99/2Pp1xVAo6+pY9PX0D+tJppwtGSFW3BJo6BCG9CbVbsYN7PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZqHRZBLH; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBoCahbJPZQ/w0KrjJqNNLfE0ulGLXFzlmIW/REOK7SsipMNKeN30yrZIywmtGSPEVMG2PxpPknKqRCig+ePK7XPfhgzglGQWMz66j+aIO01cSOrhKFfwWup7FIxkjHov6XUQtQZ6ZrodmAj0xPNVoknQoFqEIM2Czo+QJkrZyK1BszlO7GH68U5vD3HmAOaRBQKy7ddyi/JiUppRDaw0J3xQdquG8WRJBDCjEXH5JbVVsPxkneldbhmrY/fgUWm/jtZNbB+fBJo+oRnZFstidzft400kNfhNj1qSGn0387HHQw81USnf1119rX6yxt2ipJVjYEDvH0hKQ4phrj6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcYWhIL1Cmk7k2troa7kYDrSNPt+tT21KLTOu9yPheA=;
 b=gKegq/s/d5fp5B8UhRHKzQehxEftGW6L/j8QFtiBdh82jrDGPZei4Kujrddu2Z1mVniFZLiOuM6Ae1aaISQBpXBKzK11g49USToRhthqoKKCT+6+o4E7bsuMxaWWHoAYnziS7Aa6cUkmh1xJq8VldT6uDOO7+S/8qCDeeQUPfVBHLaH5qS4r/g3v/f7lVbbM+2gq+20TPz38iJAYAS5iGXlCbTLCkXJaTRHqAnrErYFTL1sshXrqh0exGj5bqjXjG+7MuDJkrnCZdd/95thIiAGnNGENnY45IPNMYj4sSLDOzhyq7HNFB2f6ihVUbi9Z8dW0+RRelveM4Ewao7ScRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcYWhIL1Cmk7k2troa7kYDrSNPt+tT21KLTOu9yPheA=;
 b=ZqHRZBLHhBuS7VAxqUioJKSbvF6LhBzoui+TZRW2ht4TgBdxAFQTF/5a1UPvR9YY3NLIGJaybFRYQQ9BOKcPKgMel3FIpt+7bE4Ou7cyR4Yh4hgL81qG99dJTErqboJUvAVoldjyFFRbvUMDrMbjqDwlUN+du02tw3fdHWt5D6DAP97fWZZ3mn9kHQldnCas/6phslmWIhoj/0wkHwjHpyw3hcDdOVUbmDgfG4rSaVdiRRuaRNjDpxxdoq8swwDHkFwOS7vmEveTtv0QOGjtXJb6UxPOoywBNckySMzT5uPoHAfE3VG+ObIy6oXfNfr6qN8i9DZcm4ZAW2AAox3M2g==
Received: from DU2PR04CA0356.eurprd04.prod.outlook.com (2603:10a6:10:2b4::14)
 by DU0PR07MB9040.eurprd07.prod.outlook.com (2603:10a6:10:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 23:14:51 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::86) by DU2PR04CA0356.outlook.office365.com
 (2603:10a6:10:2b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26 via Frontend
 Transport; Fri, 18 Oct 2024 23:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:14:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INEgfl013303;
	Fri, 18 Oct 2024 23:14:42 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 0/1] DualPI2 patch
Date: Sat, 19 Oct 2024 01:14:18 +0200
Message-Id: <20241018231419.46523-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|DU0PR07MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0b6e41-7d83-4cc0-3b2f-08dcefcaab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1EvMGcyWVlDaXNrREhOZmFnck0yMVUraW1xb2ZvZUtsUUxkZmt6dmpsRllY?=
 =?utf-8?B?eTZrTXNaVGx2VkJ6UGMvKzJWd0NLQmtjWHhKbjFxb3RsU0xMS2x6UFZPYkZL?=
 =?utf-8?B?d0JqL2tkd0lvcXo5Wk9VS1BhNUdmbmcxaGhwSFdWbmtLS3RVb2NxQXhESyt4?=
 =?utf-8?B?clJlQ3NGemRYU1dwejNMNFBJL1dsVUNQZGQyUmZNdWF4SGYwWXVSM0ljbmZI?=
 =?utf-8?B?K3UxVmFXSEQ4K0VXVEM5TFFuTkgvYS9RNFZFQnIxVWZVcWQrblVRTXphM3kv?=
 =?utf-8?B?TnB1TGZUa0E2d0l3UVJmbzkzWU9QTi9tRE5kMjJpalVPU0hUbks0b2hkNDlC?=
 =?utf-8?B?WURxOE55R0xuNENWQStwUFh3SzEwL0dBRTVDSjhGY3J5MXoxMnc1dnZJd3VH?=
 =?utf-8?B?eUJiTXd2SG5nYVh2RU9zRWh4eWZIdFhHd3RrWXMvOWpPOVR3RUZlRTdaMUdQ?=
 =?utf-8?B?TVNtNzRZTGowM1BZbWhsVWx0NTVIWVlEQWtBbzZtUFFqMk5yQ21vNTc0cFFF?=
 =?utf-8?B?MTNGckoyQUFXTWJHbzB4Ti9WMEtHeDdQeTdvdHpHVWR5TXlTOXNQUXQycW9l?=
 =?utf-8?B?bmxRSHBpem5nSno2UTBQTTJDUi96eEVGTmllWmpvdEJOdVhpQW55TVVtV2Yx?=
 =?utf-8?B?SGthdVAwWnRwUHRGUzJmSmNRTEIySHJNVjVUazI2SEN1a0ozV3BMQ21kbUtZ?=
 =?utf-8?B?U3VnMDVNaFV2cFFVOXNRdGpadWRiSXFZaEpYR245bTZERkUyQ1ZkZEU5a2FL?=
 =?utf-8?B?eG9ZMlpMOGQyQldudTFWbFQ1cEJnSG8vcSt4YzRlcVB5VExZMks0aDdzSmZY?=
 =?utf-8?B?ZFdEM1YxWnlQZTAwM2Ntc3FMOG5rUG90ODhheDdPY0h5RVFIL2w2TUJSYVdp?=
 =?utf-8?B?bjByNEg0cFVVbW82b0VXemF3QXVTYkdHaUtvQ1NUOFBod3dPd1hqZ0U4YW1o?=
 =?utf-8?B?dG54TUx3VVlaTlhkNDN4ZXBQVEtQdUlWNkpDRDZMTnJva1BlUWRQMHRSOEM3?=
 =?utf-8?B?bEpRTU56YjVyU0o0cVZiamovZjllbDNtTlFKWmM1bGlqcDF6SWp4TnZRNnZR?=
 =?utf-8?B?R0ZOZmE2OUhBaXNVbjhJZXNtTUZHSEVDNlJyRndvN2tHTEU2YnZiL1IwSDRD?=
 =?utf-8?B?NlNhaXdEZE9tQmZCMDBEY1Y4anM2SGcvNTlVSXBzajNNZ0xjUE9VaXdIWmU0?=
 =?utf-8?B?K1Q1c3FwM1ZwUEl6bDl4QkNhNjhEOXkxQXh2OS9CVmgyZ1M5RndZRWU2eWN3?=
 =?utf-8?B?dUp5aVJDT2tiQitMeklmM2hxMitib3R4OGsweHByS3VxWkNqZWkxbml1QUxz?=
 =?utf-8?B?d1VhelczTUZjME9UWlpNb1UyYWF4dWJBcmZQd1Naamc2U3Z2bTFKZEd4dHVN?=
 =?utf-8?B?U1JhRG5UVzZTYTFQaWNCa0Y2b3FmeDQ3TnVKOU9kcUx6U2h2d0w5K3AyaTc4?=
 =?utf-8?B?em1Xdnd1Uk5vOEJHUUd6NjdTL3R6c1lmRHFONG9CVTU0MUpLQVFFUDZUeml5?=
 =?utf-8?B?dUJwNkQ3bWp2bk5FZmNGM1E2R2dOSU9SR1poR1piSi9OQnRjK2pDblFXdy9t?=
 =?utf-8?B?YVhJbXdITWYvOUp6ZTgwU1Z5VURqZ3JNbDhGSk90dXEzaU9aWWc3ZjZSb3g5?=
 =?utf-8?B?MTgzdWRrSzFpaytKa0FiWEQrRXJyQ2NFWXgrL3diOFdmR01FZFZyb2laSnZT?=
 =?utf-8?B?MU5vV1RuZ1Z5bkhwdkl3cG8vNERrcnp1N3pySUMvYmJDTE9YYm44N051N2R4?=
 =?utf-8?B?dkhPNUp2em5XOVpVdjA1bjY4d0xJL21WdU5QdVBhOG5ZYnUrengyeHZsYXlK?=
 =?utf-8?B?b01OMWpYU3Jrd1UrZ2dYMXoyRzkxSlA0SE4zcWhJdk1sK1B3VkVhNFdVMWpw?=
 =?utf-8?B?bDJlUE5HYzY5RUU3eU04VVNuWW44TmFwRmZmYWZGaW9xMHNScVdLVGhrUU0x?=
 =?utf-8?Q?/9rfSIP8F70=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:14:51.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0b6e41-7d83-4cc0-3b2f-08dcefcaab08
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9040

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the updated patch for DualPI2
(IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).

--
Chia-Yu

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml |  124 ++++
 include/linux/netdevice.h           |    1 +
 include/uapi/linux/pkt_sched.h      |   34 +
 net/sched/Kconfig                   |   20 +
 net/sched/Makefile                  |    1 +
 net/sched/sch_dualpi2.c             | 1045 +++++++++++++++++++++++++++
 6 files changed, 1225 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

-- 
2.34.1


