Return-Path: <netdev+bounces-133016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D899448E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858101F25EAA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F89B183CB8;
	Tue,  8 Oct 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLxs3Zds"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED018C922;
	Tue,  8 Oct 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380618; cv=fail; b=PGU10AsgvhVoNjyQbLdxZCQxEiNcO7wugazbgikfOXCF8TP/RcZfDzyJsg0JvpNbcV83Av/P+FuDLq1k6b5zARR18dJgSVbNeYNXkmSSerxETZKd1C4kpNg1EsntW331W34EFXI55elcWLVAWtC4R7xAnPIUPsi3exzUZ5kPbJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380618; c=relaxed/simple;
	bh=JfP6S5YHvBOvGhvNVxujDS6KXHgJA5RzUc+BVukmiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=etL6NJ1e3ZRFElGvac472zSYvAGjvhtQUQQaKr8JddHQrTFYgn0kU6As2uzDKw7mvixDBSBzXEaKimLnCdTSc64xeehT70y/okPRcqqQSJ4b8r/ASe2bCQZxEp93c5tSkjXDUpgUrvZ0YH92UYfb0E4on8O7Y0UMR+L462CvZ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLxs3Zds; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/CRgoXZWfHrMaHdOMELSfKa540khbv7Qv3JtoOFmutQ30aAm++8R45iYemdjJyICIulAFFXcYLHUGQMd9OoWka4sYymBjG6AIj0LZ7qt2KI4v63srrhEn9K5ZSdoiP8evaaHunRJKT11E8zj0GJYIT3MAUU0q8Ofn0/hZywA6Q9TIvMoEhMvZ2epfhdMiiPiSuP72tPXMnp1ODsn0KIxWo/D+3juOrUwGZZ+z9pkA3iGwf1HUKdwAgEevvyShSPElj9Dx3WwXUxNeYg6vfSeREmHYSrMZjPFh5CORU520RhKdWTSEjtnBjyR+kqV9bqEoAybSLP9SbWltYb70zTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCzKNz9YtReFs8wozwS9cdGoK+mDJCXKIcVPLCbQRDs=;
 b=IUyR7lLTKgFzVwONIW3jdxbELwjXQw4ma6iSVaV080uJ2nedeuMYEMtJhOM4NBP30TU1Y26mAhc1n/Gw6gxjQwxCZOq68EkCQF/n/d6t+mBnN8G9iBl7hpvkn3Y7tG2LDvddY90oZzrmsgDN5rl9alM+Wp6tXSQw4LCqPCclcwBcnukYvjctnVE/rA+pJomVltRJKLjzb43XgXv7yOtqGb3JoWnw9eNZFRxLprxS782D+QqhD0m9w+PMtUqOL9/LOq7ejuMj7QzRNoWKSUbpMgoNpEEoyRPcwyIFri1OmBu62556pj+Cl1+CJ4LvZghRwiqYHSWbpQoQaUh5WZ77XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCzKNz9YtReFs8wozwS9cdGoK+mDJCXKIcVPLCbQRDs=;
 b=WLxs3ZdsTH4riOT9qZSqYmrCvpZ/z1SZMYVVbiU/8pmybsE1LjAlwYjwl5h0BDaZuKnAsfVnSUyZcVZK/BdEYuLdKIMtNC4W80gbXbRs/GJ1fzw4kvZq3tGvNXj1zLOOeCeM7DIrqi3/i+22CS/ALt5xAyrBkNlMAoO8Bu9JWqOtUESFJEn1F1t2Xjl896+h0dg+QG3KXYMoNBRUEdhnJEFLkk3Rrpfil9Aw+mhxMQotMcmZkWk/ZbEYBZBTsDXVOPe1N7mp4TObPYsC5jzo7ZaCITWPuVo955wZIBialCsh4YCWvZhCupRAH7/KbM0FbJxI+T8Q9VtZwgGZeO92eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10350.eurprd04.prod.outlook.com (2603:10a6:150:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:43:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:43:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: refuse cross-chip mirroring operations
Date: Tue,  8 Oct 2024 12:43:20 +0300
Message-ID: <20241008094320.3340980-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10350:EE_
X-MS-Office365-Filtering-Correlation-Id: 55513306-f879-43ca-5f85-08dce77dacaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sEQW7pIS4swEBzYAps5pybYxdHo4uXDLyu7Wsqe9zpEfrsDtMLfV4SGhq3+Q?=
 =?us-ascii?Q?ZFxfyHFDYGwp0IPh1IoT16EvaE8U5S7dF2H1Si4gn4hp0cQHkgA8GeCD8owk?=
 =?us-ascii?Q?voY62vi2aaQoMlnafCZZM+K39XnKqH2IlW/UtjReksNxknwL/hr+3GJtHoZv?=
 =?us-ascii?Q?Jr5IMeMQ/UNxlKetOFf4W2dCpoao3F10CdsUOpbG2196+mIPBbLRv7/+MtHV?=
 =?us-ascii?Q?bBFTD95UQ+9rDCHT6edcDVCdMGmP0A60+9GM2BOxELGn17Hq5EE4N7+vEPxm?=
 =?us-ascii?Q?MFtJHBXrPJUnyrJBZ1+mz0mfrvqRK9iA/9X8utVPVzcFSYE/ATE8oR/PU6z8?=
 =?us-ascii?Q?veP2kENfAEy2Sek7UCtPU61KYAa5Z9TZW2rTBwqHJ9qf8iiLdmS2iBQ15CEZ?=
 =?us-ascii?Q?u0mi6M+PAu+ha21Nc9Yjcad6R39nxi+qSbN7+uoC/r178U2aBxxTQUm4ein2?=
 =?us-ascii?Q?UVBDeNepW/Zm7pe8qk8Yh/3wmZSy4/2PlAQ3VM8lt4QvFQXy0N7PXF8/Zkvf?=
 =?us-ascii?Q?cvNvoSr5SMk4k92vSSB+6C6wUgm/lhDSV41uBnbo0Fht5wwqaAtcwE8oVpK3?=
 =?us-ascii?Q?Lpp17ZrK/DSfHU8M8b+BxB7uL6XZuoffltvcTmk6vWgK5g0rfSxfMI8UlOoN?=
 =?us-ascii?Q?Ae36ySCWcvFGo3MgMu/9iTx6Bs9LoR2WanGxnp/nr7zgrp8U6nFYF8socggk?=
 =?us-ascii?Q?TnG+SuGwzmcVkPAhBT60ANWsemPyros8pCl5I7GZBTSq+BYadBt3N40jUZod?=
 =?us-ascii?Q?mD+vS0phvQGAv0cusGinE29lgQTyUCG8XV36iP7/4altBbAlZhTfw8fyUH6R?=
 =?us-ascii?Q?HuUxMtesgND0fzjKykcJx6EcO7fhcqQsI7oMfcU+9+OrRm/SdTlT/jeG+yWF?=
 =?us-ascii?Q?f83folWI5nH8to09iejpOXz9Ire1DAaEM79jrOObZ3muYlox+1E8y3+j/4tz?=
 =?us-ascii?Q?93xIPR8r63r9DL8vgDu/oL6jgWhIFd7mGZx9qgEj4sC/qpFFN2pUB1Fn8CXl?=
 =?us-ascii?Q?1B0C++k2oyMtmbNY/CrWjjYViML989D+LRFqoghL0Wq8225+sp8vNebL7xHh?=
 =?us-ascii?Q?uxaVnvSlpYhYs0t5olfr+RGpwfEBn8brh19HudU5qW61V5r9cj/3JWZM+VqV?=
 =?us-ascii?Q?dGsfKhzRhxpGEmjy0qcXG3joTeQT392iKQ6EKNCtHsLebHgdNxXSMIiCeSxV?=
 =?us-ascii?Q?MhIPuttl8kRaNzIpPPu1wKfHU6j+6jDMMiWZU1v2htLwBIYGYR2StpngnGr6?=
 =?us-ascii?Q?gUO2GB1KgSZ+R1pX1kIofmfsInYkTfuBdH2eaP/YfpW9D1E7zj0GZr7jbiMJ?=
 =?us-ascii?Q?vMJYYtSV+h6Pn0aJFf1yLzV8F+sug7XkAuGZXo2cim7Owg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2gS+ju5DhVg7D6gZEKEVIn+Ul9HyQPivXP/nGFAw1DTLkMUCKORSM1ViyYW?=
 =?us-ascii?Q?JVABGdUBJfHeX238pG0wZXm+gsJ06XYY4wKatjwBLJHcM/K/eqfVOqd3MJmG?=
 =?us-ascii?Q?bclnGp7hrMsrqLgVNCZRDfGPaJGMsXEbeq20Xu7Rv5WORPZ8wZ1DMGumISai?=
 =?us-ascii?Q?NJQ2mfvc+z131v4WaF2amx3dbvSbb2tiYLCMLDpjSAidpW5r2LNHEn/cnvBL?=
 =?us-ascii?Q?Dbogd4hteVS1qsYiyRa8RT8BsSLuOf4J7HalqVeKbWhZSslg0XhzOeRvPLWB?=
 =?us-ascii?Q?cd4rrYKHNUIJr4Q4DkZGmF0wkN+O/5NAm2uF/zWWkllFaJRVpiCWEUCzTrHS?=
 =?us-ascii?Q?NdU+VT+tohN6uIDHhvwJVOwRbD0/0+PLtNH9+af+zYXuY7UV0dFIF4uD4uKY?=
 =?us-ascii?Q?IG3Jf68W6UYNM9TDbYATjBJbDg5qs5qd/pOMrtLdjQo/HMRNdEfxybEGBfPi?=
 =?us-ascii?Q?YCZ4ZPeqeTyuXeC83mbebqrse+pTytIZvWerRcO4LU+GaoIFhLM+WRTGJNpS?=
 =?us-ascii?Q?1vuaOh3NCHa7I1xWUzhRJCgBlra9xfeHyssV5aSPGZQv6eblI4qoKCQvok63?=
 =?us-ascii?Q?FFdgUt9fO7orHtJateXlHaFlfp0ffWGzEEobT5MG4TRAWAEQ2n/qxthNxNxe?=
 =?us-ascii?Q?hxZFhHtTbpkFex77ZqIdmXklX60IcymNshzt0i/ztHeTn2uLfXeuk0bKJt/e?=
 =?us-ascii?Q?CUVVm1DSrEv5OVlnhtkfAveV4HfZTq8vuO8t7/gTB9x691g22U2HNuvSDWPn?=
 =?us-ascii?Q?nVVNsSV0Jf6uhIpldju7gNnzXW9pH+a6Gal+qnpJFk9xku/moP1EYnlLY9Zt?=
 =?us-ascii?Q?9E6Ri8U129fQuYwbjKEN14u3l7RK/7ITI/JBG0FZagkOnnRTJLRgYEG2gr6p?=
 =?us-ascii?Q?bgMo2w9PNe3RgH12hKgzY3RkLYsGvABWQiN/4bZcx1d1vJrXaa7QXu8csevd?=
 =?us-ascii?Q?emNtJ9OeGyHdAZQb25KUzMrF52nvBSb12Em3hL9/ESaxl4BpaaDYCl0i9jtq?=
 =?us-ascii?Q?GtogxVIseqUuLFJY0Wu5/iAO65r1r4jYGS48RGExIjfKBedOAuXt8f83Opu/?=
 =?us-ascii?Q?PFt5nZXu1SOSPb1fO+auxmYdK3vwIgSCudjTFCt6Wugi1KgqQ6qOu8YqRAk2?=
 =?us-ascii?Q?k3dKe6NzeVDrjGQtUOhGdwr7gLKVDZ/WGv1SgrpiU6M4v63Ga/mQoN4Hhof5?=
 =?us-ascii?Q?15szaQoPs4YBulnEyqPe3UuwyHB53FuSxxGlos1R+bi7nHDxP0S4BvS5kSSe?=
 =?us-ascii?Q?WZFwB+SsJ/PvGfltkXkLrO+XUSDMZSHzG83FtzZgDZngcQjuMTbBwh8r9tj3?=
 =?us-ascii?Q?lNWICRzMxxwqs2117rKxzvP4sG3svdmsRLYkIuGCJ0hv0gBbnkPZa/s2Upuq?=
 =?us-ascii?Q?bUD/J94CXBtdEvSmV9xgptXyC/1W3V33yyFBI0Ta0UvQ64x5hD8AK+rsH4WZ?=
 =?us-ascii?Q?uda2n9ZTJmMz69xQf642n32tdMgaFDQKOayxvBzQXoA3uQDjEmBZxBlta4Op?=
 =?us-ascii?Q?i2/S1yFwcPkDN12KyIbkifU1zs1Gd64lez6feDhGTUX4PS3dawqNUcx3YsS+?=
 =?us-ascii?Q?DoAaVeyIXQBOKFXcxHl5pmWzN+Fv6IbdzW6Kr7XZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55513306-f879-43ca-5f85-08dce77dacaa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 09:43:33.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks+s6E2HEVme5UYt8bE5iRmeoEEjYeg7M6cUgRsoYeFMPFlBl3G5wW7newwo5ZPNNQcQpTUn3G/DRP2tVEjqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10350

In case of a tc mirred action from one switch to another, the behavior
is not correct. We simply tell the source switch driver to program a
mirroring entry towards mirror->to_local_port = to_dp->index, but it is
not even guaranteed that the to_dp belongs to the same switch as dp.

For proper cross-chip support, we would need to go through the
cross-chip notifier layer in switch.c, program the entry on cascade
ports, and introduce new, explicit API for cross-chip mirroring, given
that intermediary switches should have introspection into the DSA tags
passed through the cascade port (and not just program a port mirror on
the entire cascade port). None of that exists today.

Reject what is not implemented so that user space is not misled into
thinking it works.

Fixes: f50f212749e8 ("net: dsa: Add plumbing for port mirroring")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
This is a resubmission of:
https://lore.kernel.org/netdev/20240913152915.2981126-5-vladimir.oltean@nxp.com/
with rewritten commit message and targetting the 'net' tree, as
preparation for submitting the rest as 'net-next' material.

 net/dsa/user.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 74eda9b30608..64f660d2334b 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1392,6 +1392,14 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!dsa_user_dev_check(act->dev))
 		return -EOPNOTSUPP;
 
+	to_dp = dsa_user_to_port(act->dev);
+
+	if (dp->ds != to_dp->ds) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross-chip mirroring not implemented");
+		return -EOPNOTSUPP;
+	}
+
 	mall_tc_entry = kzalloc(sizeof(*mall_tc_entry), GFP_KERNEL);
 	if (!mall_tc_entry)
 		return -ENOMEM;
@@ -1399,9 +1407,6 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_MIRROR;
 	mirror = &mall_tc_entry->mirror;
-
-	to_dp = dsa_user_to_port(act->dev);
-
 	mirror->to_local_port = to_dp->index;
 	mirror->ingress = ingress;
 
-- 
2.43.0


