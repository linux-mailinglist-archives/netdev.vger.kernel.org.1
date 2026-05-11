Return-Path: <netdev+bounces-286703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O6AAfvxAWqymgEAu9opvQ
	(envelope-from <netdev+bounces-286703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:12:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E0510ED6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00A530889F2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0602F12AB;
	Mon, 11 May 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zj5/MVuQ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A82DFA25;
	Mon, 11 May 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511651; cv=fail; b=r8t+5JnOBiqu2Cf6AIBEDBBPiUKLaihbl4+P6yvvQDgAAAAPtn1RHyxUhtATPpt5tmeMnE5z3TTgP1K5pGDN7dOgrN7IHXcBnaJuXQdfTTFLtZ52EJiS8TeMqh0tFdVQ9mxNpDH5ZibNXWAkgSCApFKkTEkO+RN8ryy4R4Amfs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511651; c=relaxed/simple;
	bh=GSlNHgEKkos+cisfRnD7bRYrMV5mJQ5Rw4Cd1kJPTC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mdt5k5veIJRUrdHllpLMiCnOzVN8zRSsupIHLBXbodcs3Xnhpl78ILwrcInaWPgTpm5mcySCvBINKGhd/xHIX+qQjQnh0W7SczulCm9BFCgQSuaM2BUzig6U8W9zXZC3BflPRCm5JWbvbboD52dgkIbEdQfRC8lBW6wbqXpfkSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zj5/MVuQ; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh8eg4MK3l13+cVNACTeuV6XYzrsE0bg97pm4IgWtI0nwlOa9hKexbIbMEBOzIK/h1CvaAf1FVwZvLx3INHLNN+MMlTsMg8p+gf3bFbw+cgZiUEhhIOb6UIZ+Th8CZjptfDAJJlsFYL6mAhB0U8Bo631sJZA+NiQ2p9UPUI6Om6k3HYfxpI6QuxsGt1ZEOtbwVd93EKTKJTDoIfK4WYfWTyIx10e6DRWCIcb0D5+t9qtJeJVvoaJJifD1G9fEDbQmVLRcHfnG5rVm2pyv7cUBADQrroLdhvS0Fub0Tk7ZkkIk1jQLypC219x8OsPL7pYg1SLkVYxzWg6mXE3Ri1EHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIzsNa2/XI9U1t21cFFHbt7qVEwxZwK4HrgAmgJIBew=;
 b=QOMekZP7JZTyTCvUZHBBKjfpjiyrslAfHNMYEya3XXtRblowNDueUt2F+HcmyWOeNh94mQz64gTIvJs0SxqlNsJ4OW+WDvjwIGYl+bJyG3A2sekqKSoTMHZ5Tjq2LWfTEGhkbELdVoFUhXAqFe++3gJWc7yfEEk2td5U0b+bO0xZeBtf6JYb0rM6wkRCMpMOGMUVxkAUnGnDubmdA/bVPJZm0kmMNEiGT83lFv42kp5k7udamhBG682cUJAwNy9nSNxB4tKNpN5cJ6WYf+RlY37gljdCCyLaPY6iZ8wSQK+XgnbzCfVLuolDfiq7NIs+bMus+2G0wSknkZOrRtkluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIzsNa2/XI9U1t21cFFHbt7qVEwxZwK4HrgAmgJIBew=;
 b=Zj5/MVuQzOWavLfYjNTzCrvw4B4it1REXtqdd1GEkW59NXy46rEj5IwXgJTOd7BhWKDgNn+rDtyyQCuNirDklxl1oJ1rwW59fT/BwUbygQGFMMBk1VgaOFks4fcYocyXPRPr0xkb1cJW06JwzbkQMIfBLwz5AtW87/ppc5q8jcZvQWZhNifDcbcaCNKyY9goBZ1pIwGd0KD9l2VD50RoEgpUPzH1a287+16+MIL3kXvyF0sGHePhZVpQj8+0Sxc0XAKOKSRe9/blK3ck3YUele/E/GBkje80oNL2yyLtQ7NmDu7r1caLS9SajpjayNDCDalt4FW2aaCpeuuX9nxADg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:00:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 15:00:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy-next 4/5] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Mon, 11 May 2026 18:00:22 +0300
Message-Id: <20260511150023.1903577-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d258410-4f18-4be1-9589-08deaf6e12b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x/EVe8lkToIS556a1BrJhL6BhZJW+kr3M+n98gYhhqotDY8Fw/a4lEoDpC6OkXXe5XOMoQKXCh0aGLr/hAp4/6HBG0Nl0hinpY6xreopa8gMbUP1a9/gBf0EDWssP+Gyj0WvV4QplVEAWFqoRTk9XMd7qy86HuCOaWm30A+wQ0d7qTJl+YGY/GuaGVSO8jaIa+97ky6ZMilughMsGw9ipZ6q08FnQ5lgLNDfpag8BqhurzXLtkTVOyWVzhP4zTXlYst0EKJLIHRZanxWl5CmZdAn7P5Wy8SKn6gT0eHkecEljf7ZX5Lo0sGolLCE65Wb2Df5gQNom9Z7kq30z8JAkFNOA491vL/zfcxgOsGhxbRIsT3RstfeLo2XO91yI8OX2XvpeylaV5aqEBZ7/C2lKZJwmqU030yokcmbC3g7uoU2cddMfJjCI+mMxW60GsVC7xjes2phUJByfh/uxAk9uEfngETsCGBecLNQNyjnoy7lNXQQcKuctXjLYet4ErgugMON+4Cje2dieSTRVXqb4uqwYw1bXt23l1zlh64ug2/t6GTIXpwttdFIyGIOqqag1Xm7W0VE1Q2q3qQCGJJdQPSNKBKXkusQewBEiIVJpxyrxBgyojK2OblTB7OTiLakDhzsx3VE4iGhAfeJqYsdws87fnpMy3tUsj3AtpuffTqhBMYy7HeVqv/Jdwq2OuKtle2bpxOLc/sdU9moRaioWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tm/Dr4Jqv9Xrg4NkCeyvTn6DUN/fSUychNTqBhpuS7m2d6Rw0PVAAc1OfOS?=
 =?us-ascii?Q?xlSwG8bD6NukdMEai8MTRGNZgTuUONCo9NTA3qRP+jjKaQ9LMOI5xypwODPp?=
 =?us-ascii?Q?/om41EB/wKdt2AMYJ3M4u4emWqDAupx/HDNWAtBl27/H7a/2WcdnhqveZj1s?=
 =?us-ascii?Q?l8BahFglu+3UU+lr202Km0SeloQhhTDKKUBH82dRxneQW15BaTo5LucleiBx?=
 =?us-ascii?Q?iPwdq2BoV4ZhrUSX7A5B6adCnnIYaFI/gS8yblE/Z/qwkORL5Gb+Yw9TrDZp?=
 =?us-ascii?Q?iNqVjHu3h3ow1NIA78KQkLVH03scRP9eXA4nOeK9GuhTtTKkihDAMrEwKXxD?=
 =?us-ascii?Q?0TrVnD1/YO+J8z1sFW2Pydmcm5sOrZjTM3is2EspYL9TMBalsqHTHYR/t/3s?=
 =?us-ascii?Q?MdDIebnklS08oagwjcNrjN1nW7Oe5mUq5THob0oRH7xu1UwQo7ldvn+OtOC/?=
 =?us-ascii?Q?IMjJ9HgKV97IPfTSvPREAtxXqKnZzOpY1qZIXo5udn2Z1RPGsgpM6mOOoxgH?=
 =?us-ascii?Q?3iWPILChs/cTzO4CN3O1RSMFk+HWcdz2Z8kRbVKRqYSZhKNdA9dTtSHse7jl?=
 =?us-ascii?Q?VN+L482GAsEC/gqvdoe6oWUNS5SD8lb22HJw+veD2Lq8Eg2GjGCpJouKf2me?=
 =?us-ascii?Q?ck+WmNwFKsB7qTWcacZkDyZuneG4zLGOa8eYXJYo3HClexz7mAigtbtUvrl4?=
 =?us-ascii?Q?/mzR8sK1OTkD2zqQdvI+j/aTLMlqNElwmy7U0TW775m41yNdLmby/bYobt33?=
 =?us-ascii?Q?EikNIYsCzkT6LcG2F+igwRZyDtyHoo8yfHjsPXHSoNPZNqwHhZXBg/dIpk4J?=
 =?us-ascii?Q?smM99CngUJts6/KgUhzBRy2JRixm5X0PRue53mdB8WTYS1Pi4117s+Ub13Fi?=
 =?us-ascii?Q?uJ0mXEORGQEyQmmAcimDCcytvbPdOYNLGQecAQ1y+FVi3HWHpSQR+8y0hb/R?=
 =?us-ascii?Q?pr8u1wm0Fsuj0RuDwoTGloCDg4dxs5SQBxN33ROKwkxzwTyoGr0EMmTT0lFH?=
 =?us-ascii?Q?aY0mjX+DyJpDWXs1onSeKQrjCMPXjFURP4iNYkJlScrlfqj8p3Bu5p9MJ/1/?=
 =?us-ascii?Q?+hvOkwC0xKt8gfVE27h9Hmva5I8FfeMGgYLLB+CKG1MQhYYPzb2RFe1pwdMT?=
 =?us-ascii?Q?59Q2mCsaN2Y4QrNUxkRWlaAqMp/ACXsvB5xtyDfXDCXsvLM90IJ/DcWWXkl0?=
 =?us-ascii?Q?seM8g6+jS28ulOzSN/bK8koNeH8GE6EXShwPROmFBBWwpmSem4LolKVbHlEj?=
 =?us-ascii?Q?u/r6qiEKWyPmpcItw8p/iDTvhs/TyY5CBGXbODcU9NMbx/0/g2a0kb3xeNHU?=
 =?us-ascii?Q?cOsbBvU1n0HXsOuEdOwhQQ4wBWm4kIl/KcjlCGGe2A4Vj7EtnTQ1swn1Evpw?=
 =?us-ascii?Q?Tp1V0gH8fhwu+IDdNY0UfFLwUQZpJe9lCJVcFmM5BZinw958ubyZV+ky8/z2?=
 =?us-ascii?Q?gYav9A46nsafBMYmyv3zU4kZ/GGkPo+MRmyBn78Gi9fl1dUAXSghMZ7Y2lO4?=
 =?us-ascii?Q?UPFUGL/AQ+QGffzGkE6yyJ+Qwo/cQUz5wbqGfXjCJ88LiXxS0gsD/D5QeG64?=
 =?us-ascii?Q?Z7KggsRjIL/1iPJNxP3n+S46Loc/ukX+ik/Gclmvt7g0hCUpbbLv/364qfnc?=
 =?us-ascii?Q?eJbpdZD+SxgFLFxtyDh/JovfXz4u9SL93nNtdjqvXkS/P1u9RvLXkm37WcsM?=
 =?us-ascii?Q?qXf/BUEgr/RhR4Js1uBWltxM5Y4ocQJkaRi6xv+vhs7cz45Q0TaD4Jy2cRSC?=
 =?us-ascii?Q?qk8onX/SFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d258410-4f18-4be1-9589-08deaf6e12b2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:00:42.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kJRHvB8QQ3DcOllxBFyiRsT+7CPQTKUuEyuJLMIcUst+0lVyn9u3VP3QjGi4+KabI/lPZkEFUg5HxtDlaMhfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976
X-Rspamd-Queue-Id: 7D8E0510ED6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Add driver support for probing on the new, per-instance and per-SoC
bindings, which provide the main benefit that they allow rejecting
unsupported protocols per lane (10GbE on SerDes 2 lanes 0-5), but they
also allow avoiding the creation of PHYs for lanes that don't exist
(LX2162A lanes 0-3).

For old device trees with just "fsl,lynx-28g", the only things that
change are:

- a probe time warning/encouragement to update the device tree. This is
  warranted by the fact that using "fsl,lynx-28g" may already provide
  incorrect behaviour (undetected absent 10GbE support on LX2160A
  SerDes 2 lanes 0-5). But we retain bug compatibility nonetheless.

- the feature set is frozen in time (e.g. no 25GbE). Since we cannot
  guarantee that this protocol will work on a lane, just err on the safe
  side and don't offer it (and require a device tree update to get it).

In terms of code, the lynx_28g_supports_lane_mode() function prototype
changes. It was a SerDes-global function and now becomes per lane, to
reflect the specific capabilities each instance may have. The
implementation goes through priv->info->lane_supports_mode().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

Change previously submitted at:
https://lore.kernel.org/linux-phy/20260114152111.625350-5-vladimir.oltean@nxp.com/

Changes:
- reword commit message
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 126 +++++++++++++++++++++--
 1 file changed, 116 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 6d0c395d20e5..5eddc2723e78 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -446,9 +446,15 @@ struct lynx_28g_lane {
 	enum lynx_lane_mode mode;
 };
 
+struct lynx_info {
+	bool (*lane_supports_mode)(int lane, enum lynx_lane_mode mode);
+	int first_lane;
+};
+
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	const struct lynx_info *info;
 	/* Serialize concurrent access to registers shared between lanes,
 	 * like PCCn
 	 */
@@ -513,11 +519,18 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	}
 }
 
-static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+/* A lane mode is supported if we have a PLL that can provide its required
+ * clock net, and if there is a protocol converter for that mode on that lane.
+ */
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_lane *lane,
 					enum lynx_lane_mode mode)
 {
+	struct lynx_28g_priv *priv = lane->priv;
 	int i;
 
+	if (!priv->info->lane_supports_mode(lane->id, mode))
+		return false;
+
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
@@ -783,6 +796,87 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	}
 }
 
+static bool lx2160a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2160a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return true;
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return lane == 6 || lane == 7;
+	default:
+		return false;
+	}
+}
+
+static bool lx2160a_serdes3_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	/*
+	 * Non-networking SerDes, and this driver supports only
+	 * networking protocols
+	 */
+	return false;
+}
+
+static bool lx2162a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2162a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return lx2160a_serdes2_lane_supports_mode(lane, mode);
+}
+
+/* Feature set is not expected to grow for the deprecated compatible string */
+static bool lynx_28g_compat_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct lynx_info lynx_info_compat = {
+	.lane_supports_mode = lynx_28g_compat_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes1 = {
+	.lane_supports_mode = lx2160a_serdes1_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes2 = {
+	.lane_supports_mode = lx2160a_serdes2_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes3 = {
+	.lane_supports_mode = lx2160a_serdes3_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes1 = {
+	.lane_supports_mode = lx2162a_serdes1_lane_supports_mode,
+	.first_lane = 4,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes2 = {
+	.lane_supports_mode = lx2162a_serdes2_lane_supports_mode,
+};
+
 static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
 			  u32 *val)
 {
@@ -1035,7 +1129,6 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err = 0;
@@ -1047,7 +1140,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	if (lane_mode == lane->mode)
@@ -1083,14 +1176,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts __always_unused)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1183,7 +1275,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	u32 rrstctl;
 	int err, i;
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 		if (!lane->phy)
 			continue;
@@ -1253,7 +1345,8 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 
 	idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
@@ -1297,10 +1390,18 @@ static int lynx_28g_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->info = of_device_get_match_data(dev);
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
+	/*
+	 * If we get here it means we probed on a device tree where
+	 * "fsl,lynx-28g" wasn't the fallback, but the sole compatible string.
+	 */
+	if (priv->info == &lynx_info_compat)
+		dev_warn(dev, "Please update device tree to use per-device compatible strings\n");
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -1323,7 +1424,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			if (reg >= LYNX_28G_NUM_LANE) {
+			if (reg < priv->info->first_lane || reg >= LYNX_28G_NUM_LANE) {
 				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
 				of_node_put(child);
 				return -EINVAL;
@@ -1336,7 +1437,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		for (int i = 0; i < LYNX_28G_NUM_LANE; i++) {
+		for (int i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 			err = lynx_28g_probe_lane(priv, i, NULL);
 			if (err)
 				return err;
@@ -1362,7 +1463,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id lynx_28g_of_match_table[] = {
-	{ .compatible = "fsl,lynx-28g" },
+	{ .compatible = "fsl,lx2160a-serdes1", .data = &lynx_info_lx2160a_serdes1 },
+	{ .compatible = "fsl,lx2160a-serdes2", .data = &lynx_info_lx2160a_serdes2 },
+	{ .compatible = "fsl,lx2160a-serdes3", .data = &lynx_info_lx2160a_serdes3 },
+	{ .compatible = "fsl,lx2162a-serdes1", .data = &lynx_info_lx2162a_serdes1 },
+	{ .compatible = "fsl,lx2162a-serdes2", .data = &lynx_info_lx2162a_serdes2 },
+	{ .compatible = "fsl,lynx-28g", .data = &lynx_info_compat }, /* fallback, keep last */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
-- 
2.34.1


