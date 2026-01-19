Return-Path: <netdev+bounces-251062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405ED3A8A1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA32B304CAE5
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD394324B06;
	Mon, 19 Jan 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="df4FX6DO"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A002E1EFC;
	Mon, 19 Jan 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825213; cv=fail; b=HnXuXDF466+7H8LzmejDbYSVpp0W4CM73QxjDWduv97H5kRt9nuUIIbC7HyqWXn9Y+Q/ImKPg0jyNoD7WWLDrideThYFlXfBMnA0No7aFPiO7EgfoltOSXSsYfvJwu2FqSF423vqEEgyQmWg4gLlfDKWJdr25UroTBpI4hP+rW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825213; c=relaxed/simple;
	bh=FLGCcXTz717b+yTkgq7QOsjUZVglfZw/QP6RQB3OIaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U72hVbe3ru+A2a+OtRqAb9qvRaBdOSS7ujP5l0vf+CpEJR3uwRFHXW6pJaflP/QjMrgrNA4p8Prlrs7ytBQPGg0VXNIwnDYizS7Yp2/+XXFqA0wO/v96K2wOerdPVmfN4dWPeEYg0k3D4JyDGHf69AVGx6ABNOuR5n9vxRnBJhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=df4FX6DO; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlsVZjdb3lkZioU31mIn3bqPWTI18J0wdRTQaV0PRsz7OrbaLRga3F7orrZdw/yG88HeM5X2MTaEwIDokuyokRpCJ189nI6TBJBvMaLnxgloMZeeapqzSOw+z6Fvqc4wKjz8QgKpQD+xIMJE0c+a1boXCkT5koKQjmt/yHF3rHF0X01Yo3hn/MYFqhAvAuUjVNxDCoo1HrmV35MlWU17fzWcQvxEqGhb1m0gnGC49wJgT6mHCGVOFUY5sJDey2ocaEbO48HSi3y++7d1bh7jyW/lvavdaLrFEedBmzlOsUWMEBNiK81iSWUSwkR1s9VJFINUjmo7Eh5CB1kyNFkksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwQeHqcAL6SIhIRWhnHdQForyqfQJ2hF4yXEB00CyZM=;
 b=kRHWMNqiQKfvpUI1E2o4oIDBeuPGBxppKfNXYUUFIflXrqiderceiVuBn0d6YElcvj4NMjxo4JADAiF1LxWsZBgzpxouXgu41SuOi8xB7JtmSsGD9ipE2nPBq5R5YpSfDqEZHhkNk0XLjOey/GGTj39HIdk9PfFHG98FYdM5Y7zj4eBFsdvHdYbKDwoo19Dn4aeoBomFhVlTHEqcJzdtcX3VRJHgbblIhJCUMZZqslXmJTdI3QyWDHRthDlfVAhBvRvWeJjqXeKlik/OmjPUuZTuQ5orjp2FzLs5LMt0RgC9xA/JcJSJs2YuGeN71W5sqPdGRu+Kcq1GvUcl1rdK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwQeHqcAL6SIhIRWhnHdQForyqfQJ2hF4yXEB00CyZM=;
 b=df4FX6DOq3Yn052W3P1HIGsCRRpzsfPNkGYAVnS9k7oi71EgP7biPL/qmCQW1MYcTY4HEeA47d1nTri/2KOiLMHXlS7Pu6dcKxoH/i2OP+XQak+caeUFnNn2p/w7uErhxinS6KlwZE8VReHo0onyfQvmJIW8gglmvtrzywTy5Gc4HnWhM1cih8tIu15qvFu+WqE6+G74tLUn2DkQ0WKaS5vEtDMck3ptE3E/840Y2YCwK6BSr4VhQFceOtmvNO4LaqS3EX4qIU04h1OAzHPINrJUWFHMvy+eHLtv61He5e+4W+XVMkAkBveKyuM9rjjhmsI+FwVUuUGfoZi45cDCXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:20:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:20:06 +0000
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
Subject: [PATCH v3 net-next 2/4] net: phylink: introduce helpers for replaying link callbacks
Date: Mon, 19 Jan 2026 14:19:52 +0200
Message-Id: <20260119121954.1624535-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0815694-5411-42e8-f548-08de57551496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8GxsuEdCXewoMfaln0FuNEG0sxAWxWotcb7bjg6VIyyTHs8Ej10oDZEnjH2?=
 =?us-ascii?Q?GqOd95yYSJSxXSdUt0RazBnxz5W1CV+7cx92adpP1JhY61iAhTOnzBcfvmXg?=
 =?us-ascii?Q?u4rD9zY3Uz9PvJg5UlffDBPxwYf301E+rsAUbGURbV4Og0prM/SmNmHjCGju?=
 =?us-ascii?Q?v7cEYb2RDM6J6n5Ile7Df1dIxNaTcN5yUPgG5wP+Feww1B882JfjtSwRPQNp?=
 =?us-ascii?Q?UD01qtm1tajevaih7jBOr59C3Iup0YOrpAnBPZxzJOd85k912L7/IurwhbxI?=
 =?us-ascii?Q?Xub2RfMhOcypWZJ98yIspwkcQ3LA3BLciO0ZUuKXo837XuQ3OVIgcwoepj/V?=
 =?us-ascii?Q?yxslWVRsa7YghaHVyRjUNLEzhYtTwkRqOdd3dnUppRV8g+N7PSXsgg5Mpgyy?=
 =?us-ascii?Q?IxhX5wUd53/5kPcZ45RPTGMM+NfJ0r/ENTyBVCmyWwIfGayGHFCCExHMOk57?=
 =?us-ascii?Q?eFZk3NqpwcmkHh4lTbMwuqy3oGbYHU8jxgWmamtfxRad2iMHkDMHiDGZbDPA?=
 =?us-ascii?Q?+U3v20dgedflz9ozhAz1ksy04TiWCgFVSfxRmeP//9p2Q+sXlT6MpXBkeZE+?=
 =?us-ascii?Q?QK6JMjGr1Q9zpcTQ2abt0rvxJA+37TLK8UFxgp0yFmOgYbdu+ZjcRjbU7JKr?=
 =?us-ascii?Q?i7bNjyKzjoJSAIB1UvFMD3kbC4Ge9pnPx6+MH6IzXDygxOQqWv9VRxMeKbTd?=
 =?us-ascii?Q?tkardvhATaLIv745h6rNxwZ0cCwVzekZ98XN40VnC4DQg3UWs9ofS8NaZV2F?=
 =?us-ascii?Q?gYS/+lb2C7SWCDEwj0PPb8mQ43jDEBEdNupSYTKps3o/jFT0xpO3srOiQ5ZB?=
 =?us-ascii?Q?NpIT7jtx/Sls9P8haVMYkx1ba8aqUp8+MYpotSzhN7jR1e52XHR310DgJPcY?=
 =?us-ascii?Q?He0+CN70nb0RqcGP4+XcbnSv8G5Bi5oRz9LPOupSvefofLmIlGFz5Y7yxR0z?=
 =?us-ascii?Q?ayIaliNS1cEa/yNGW4tRVxI0iG3qhwYLXj3O6KFXQbZsn/TkLrhzzGqJfaGG?=
 =?us-ascii?Q?ixCSIb0p7Vc71xjrDm3yoINeRiJ+sNXOP4EchxVR2gKrFXKSWkWT6UF1fxFT?=
 =?us-ascii?Q?XOjLEpGUDrvT6JYoej/Yhv5jykzG3gr0O47v5i9mr+Sq11KJ0HAkXll+ukzu?=
 =?us-ascii?Q?BhbnVuUhALTslmedJC+kWWSUKXueET/em+27ItnVHUrEykidm4A5P21YVHCY?=
 =?us-ascii?Q?ptYFzl0hJWsvdmAShR4PtU5/t99TM0eTJ6RZwz1JpFNfXeAA1c9mV+h2ShnO?=
 =?us-ascii?Q?X1sr1s2jfy7CL3fepNDPhC1IgCFbHuCIJO5dUturDPlWYMPxsVcgK9/YyFBB?=
 =?us-ascii?Q?yCw9Ju95Fw6bre75UV5USKDryyy4FcofNCiVDNoBV+SKpX+1xub7znTRdL/o?=
 =?us-ascii?Q?ml+2039bPngbnls03liPCSDDT0K7G9aYqT4r2/acBicayCbgjS9aP0HiHIEf?=
 =?us-ascii?Q?EQDLlZKSumsT2OTNg1+f8l5LJdA70rK9bMrVeMAA+fEzIWqFiBYmwZLTTJLq?=
 =?us-ascii?Q?QsProLH2VMTCc9LzdSY4dHW2Z9bgcSC61Vt5buN053CCOZNfpSQuZFZRQawH?=
 =?us-ascii?Q?I9vVoK1UuyYp7IfVo80CzKrVBN179USwgju/k88bJVYOXOmkzgTxnjvUAJA1?=
 =?us-ascii?Q?yKr0agSkwIw2rG/ptPWTSMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUYL/evcQkf5bqn2tbBWQCv5ZDggiME/oCqoJkLmjQcnm0fnc+JwzO5jAmPI?=
 =?us-ascii?Q?Q1Y3xwY9hsn/1KbGx5U2kISIuEyGYORfFFW+MbQh/Co2VUOo65wK4NloJxkR?=
 =?us-ascii?Q?Q+kIFb74mIIyhDaaN0LtaLpvIiCfYbaKAfqm5l15X8r3XGtO25sWFd32p06Z?=
 =?us-ascii?Q?EtlVaV2+OwwNyiC33M6v3mztaKtHEfSvbZRZ2kb9RloMtcl+nweuEBSnzhWk?=
 =?us-ascii?Q?XQbuYSz2rbfjy4WBuYCJiy44P8f6CXVv2oookxYsG9vRRMLIqFhF6w7aR5Gx?=
 =?us-ascii?Q?+bHTCT+jJHBHP1xjgPytM3umPNnVK7g6tKxIZxyQh/dAXDtkg4quvpMZIRrV?=
 =?us-ascii?Q?18HG/1+9vAtzwHda9G5mKAbgaJjW20inApOQnovZ5VG2wjBv2U7TRcKqbXnD?=
 =?us-ascii?Q?pXw4kmj4B8N7RIdQwWEHGxCSXZdwGfg0z8ZjJ5ODwenDfXI+EHhlrjSOJcX7?=
 =?us-ascii?Q?thFrx+BuXTpWj/cZIxaere7TdFWK1FR8rl+bwthY6+dpPBbLiW8LUahroDy/?=
 =?us-ascii?Q?oaDpBOlcg/WHCbCZMdNUHOKClxLKLdyJp6G7Z6YnF63LRIYF6zBzpCVNqw9n?=
 =?us-ascii?Q?OLAtm/mfKH/yrctk0LN7DoTXI5nO23I1VVi6WjArM2MuNuYC+hgcKRextvdR?=
 =?us-ascii?Q?dCKXQ33hAvHjvSIROc3NPjdCnbWYnCZFz8UG4y0uN8o5gda/hBGKNGeDhxx4?=
 =?us-ascii?Q?bJ9t4LRHLqROTac3SV3n7w6//nnIFU1pMzFirf1UuiHPwM1ZoXbtwibrkPva?=
 =?us-ascii?Q?K8LK3hIxx8/HrIqI4wB4F4VnAW1S3Zs5nFNc2r6A8BoMnlgLiXh9iLhO+qNg?=
 =?us-ascii?Q?lmrfWDKNoOkQ7FdQbPIOpVT1zVXltFzVMIf1kud9mH/97P7HT7ATSGu1XbCt?=
 =?us-ascii?Q?M+KCTfKPswdKxL2c6TlJMzKodeyZtpfB1PGKkownHOCQyqOnawCo8wiki7v4?=
 =?us-ascii?Q?+w94RgKqaej0n/aocLtxG+ysBzgIRLqw1fli1fDjQM2cMbj8Qk7oHt6A/L8T?=
 =?us-ascii?Q?bCCO56WTl5C9ezGx4DBzqGGKNSF0OrJqA4W79+7tJvRSFvx4Ozx/OGiaGIN9?=
 =?us-ascii?Q?Sm01xd+YQ3DcOrYjD9mzsSKOr8Ny64Fx8s3u9SXuda/3Zg2XhvxepGWBvPnt?=
 =?us-ascii?Q?6y9VpR0DLG5djPqthIOtgOmL82Ee9pkVRbTVOWIhLzTHnvq1O4fymsApzvMu?=
 =?us-ascii?Q?V+HvkYaT7v/kZzdmWcQK6i0G214WzcOEwbTYPiwYXRlobdmRLJIEXDr2J7Ng?=
 =?us-ascii?Q?6uO14m5vzr2DXRGPK2bu5RhVYUEMM7rnFCIYle/QKiILJoqZ9yckkqCFWmZ1?=
 =?us-ascii?Q?BSps+NDCdywFu8X4RWtbvUH6svEaj135CRfUOZFsFHeRqkRb0sc+DH21/M59?=
 =?us-ascii?Q?xvzeUYciCD8Cv8nyUtkZxJ7hoKuGvuOHByCV83YMk7vXxK3ns9fdWMwm5rzg?=
 =?us-ascii?Q?gzDYMlwOW1REWJHorXVbqCUlqf6KnAipN71ojb1ITtCKZJKhcNICfqdnasdR?=
 =?us-ascii?Q?UTMLXHYMywmB5GMDinu9sHIzQmA/5AhIsjcvmXJFOKvRMMsbTUKOfp/xgQX/?=
 =?us-ascii?Q?Vu0P3Nrqu0kuNUvKAzlLr6OKoevPvOAeexSIoyie+c+OEihnyPLwDpQh6Yn1?=
 =?us-ascii?Q?y+8bThqbB8sxn6n8//VKKQAACZkDDv1p38yGOKuU8IgAMqNpaqI6GoD5Wf62?=
 =?us-ascii?Q?ahj0MSiTOTnIy3nDmy4QuTGeQQX/36xkl3YAvo/HwsCYB6kMXqKecTCA5PMH?=
 =?us-ascii?Q?yKgMO4ZSbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0815694-5411-42e8-f548-08de57551496
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:20:06.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33VfRGNKAPJRyaBL+mLrcLc8WQENjtoRsCXR5IaEtDmRgTmtBuaTodj8EvTr4lq/8465CaFHaQXvbjbPQw6pDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Some drivers of MAC + tightly integrated PCS (example: SJA1105 + XPCS
covered by same reset domain) need to perform resets at runtime.

The reset is triggered by the MAC driver, and it needs to restore its
and the PCS' registers, all invisible to phylink.

However, there is a desire to simplify the API through which the MAC and
the PCS interact, so this becomes challenging.

Phylink holds all the necessary state to help with this operation, and
can offer two helpers which walk the MAC and PCS drivers again through
the callbacks required during a destructive reset operation. The
procedure is as follows:

Before reset, MAC driver calls phylink_replay_link_begin():
- Triggers phylink mac_link_down() and pcs_link_down() methods

After reset, MAC driver calls phylink_replay_link_end():
- Triggers phylink mac_config() -> pcs_config() -> mac_link_up() ->
  pcs_link_up() methods.

MAC and PCS registers are restored with no other custom driver code.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 61 +++++++++++++++++++++++++++++++++++++--
 include/linux/phylink.h   |  5 ++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b96ef3d1517a..bf4b72fa683a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -28,6 +28,7 @@ enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,
 	PHYLINK_DISABLE_MAC_WOL,
+	PHYLINK_DISABLE_REPLAY,
 
 	PCS_STATE_DOWN = 0,
 	PCS_STATE_STARTING,
@@ -77,6 +78,7 @@ struct phylink {
 
 	bool link_failed;
 	bool suspend_link_up;
+	bool force_major_config;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
@@ -1683,9 +1685,10 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->act_link_an_mode != MLO_AN_FIXED)
 		phylink_apply_manual_flow(pl, &link_state);
 
-	if (mac_config && link_state.interface != pl->link_config.interface) {
-		/* The interface has changed, so force the link down and then
-		 * reconfigure.
+	if ((mac_config && link_state.interface != pl->link_config.interface) ||
+	    pl->force_major_config) {
+		/* The interface has changed or a forced major configuration
+		 * was requested, so force the link down and then reconfigure.
 		 */
 		if (cur_link_state) {
 			phylink_link_down(pl);
@@ -1693,6 +1696,7 @@ static void phylink_resolve(struct work_struct *w)
 		}
 		phylink_major_config(pl, false, &link_state);
 		pl->link_config.interface = link_state.interface;
+		pl->force_major_config = false;
 	}
 
 	/* If configuration of the interface failed, force the link down
@@ -4356,6 +4360,57 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 }
 EXPORT_SYMBOL_GPL(phylink_mii_c45_pcs_get_state);
 
+/**
+ * phylink_replay_link_begin() - begin replay of link callbacks for driver
+ *				 which loses state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_link_down() method is called, as well as the
+ * pcs_link_down() method of the split PCS (if any).
+ *
+ * This is similar to phylink_stop(), except it does not alter the state of
+ * the phylib PHY (it is assumed that it is not affected by the MAC destructive
+ * reset).
+ */
+void phylink_replay_link_begin(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_REPLAY);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
+
+/**
+ * phylink_replay_link_end() - end replay of link callbacks for driver
+ *			       which lost state
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Helper for MAC drivers which may perform a destructive reset at runtime.
+ * Both the own driver's mac_config() and mac_link_up() methods, as well as the
+ * pcs_config() and pcs_link_up() method of the split PCS (if any), are called.
+ *
+ * This is similar to phylink_start(), except it does not alter the state of
+ * the phylib PHY.
+ *
+ * One must call this method only within the same rtnl_lock() critical section
+ * as a previous phylink_replay_link_start().
+ */
+void phylink_replay_link_end(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	if (WARN(!test_bit(PHYLINK_DISABLE_REPLAY,
+			   &pl->phylink_disable_state),
+		 "phylink_replay_link_end() called without a prior phylink_replay_link_begin()\n"))
+		return;
+
+	pl->force_major_config = true;
+	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_REPLAY);
+	flush_work(&pl->resolve);
+}
+EXPORT_SYMBOL_GPL(phylink_replay_link_end);
+
 static int __init phylink_init(void)
 {
 	for (int i = 0; i < ARRAY_SIZE(phylink_sfp_interface_preference); ++i)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 38363e566ac3..d6ea817abcda 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -836,4 +836,9 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
 
 void phylink_decode_usxgmii_word(struct phylink_link_state *state,
 				 uint16_t lpa);
+
+void phylink_replay_link_begin(struct phylink *pl);
+
+void phylink_replay_link_end(struct phylink *pl);
+
 #endif
-- 
2.34.1


