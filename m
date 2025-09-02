Return-Path: <netdev+bounces-219186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96111B4051E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0731D3A9D3B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E632A834;
	Tue,  2 Sep 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gURyyuQl"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDD3074B2;
	Tue,  2 Sep 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820521; cv=fail; b=e/ANDpEf9YxVyMVC9cCAJR6MnlbGO31Q3nIE8YR27BX7exR4icwe5DRqCkDvXzkwuj8GJNow+WjEOmchtsPMsEt1v9G5xQ7yxq/1GXL27GttEFuVEgPUvRsT1WRT9rXcFgVEOHy6eaZ+PBPtvGoI9JjuLQs6hLRKA9+UzjsnlFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820521; c=relaxed/simple;
	bh=KFcrB+wbGKCVIG0SFDGCqWFB3Om5X/u7N9YN5Bj7cTc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QV/XPJ1ZkAZqFsK/wHWplGKMXjIyqUuUSVtveuayQmoqXormqVl7h6Nt3+/An6fMwstxcS9GAjNX9utfQS3H912C/+bSJCAc3DgQCHrtwIPD6nuLfB7FpgFv0fdtTskHfArIpVSEx6uSF/r+YUv+UnOABPN+2DiqcWRa+RTHUo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gURyyuQl; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5dmWBE3K27xjaRjLx3B9PuDoajh3s867NJZlMbUHIipPNvVzHyoFEzGziFiTFcOVSVso4ic2tjlyTi0JNDk7LhaLANoeugYYED+PrgI/TePdefWrtKASF1Q1IEYo2IMuaApP5wpxogu7QqaeBtLODpI2aPjJNgJBrxArSpkPcZUcZ7rIDAyEFp6KPV8kKQfp1lWTMEcJQj2k/zdrrVKzrBWtQGSuZU2MR51i4VyDVvZwtNPnHjLGRsOLTVByRAcs8ltiuJs0ioAPJ7yt5ZjsooEOb2nZizzz6hLCP5WD95EhowQ03IDhnKGcKoI3tdAGo5zvFkW9hk+rl7mlpJlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TggqOp0sjyOILkW0zMpPoVRD6oPL8Jih4rOWcfUb71I=;
 b=J0/zSb0wCeLAq0KYMDBPsnbg5K3A8obJIxPhG2QNXKYSWbgzEv0/2MchcEnoZHG0iB5yNAgqYg4uUoEh01z/+9ji5Pm75NMgY6IVX3HkJwRDpZptQNCM8uq1pkN5fr+ylrDEWKhUcOJk1t4YNnhurlgcxk+oLNwSYXch6NjGuKElKgHd5AZsvd1QBzCZGy4amKyPfVMp1Mlz9acbwEI8a9SHlScTizrb0xRQs3BzVcIFoapMD86muF1Z35wqxFRkTYe/vwN7F2KXFUZV6GQI4fA5jYsWJChlPHVrlAOddRy1N7YXs+sjuFoTkSrhrA5BotYiWNiFRNP55hHm4Pg0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TggqOp0sjyOILkW0zMpPoVRD6oPL8Jih4rOWcfUb71I=;
 b=gURyyuQl5vXrXG/H0G7bt/onl9EJzOB9ZVfMqlS1E569wFCL7WFApCsGFmj6w9efx6arlm1eSLXUYi1siktfIbY9D54ZQtgCusNP8j6rNCBZoqPa8zpjydOvxu1J60CBoY8QZYmv1uorr7wqGtno3kmjprWKKbyUJXt6bcGoWcLWIhTPxRv/hspKE9NjfmOXLwXrwtJ3MCiFZaFMOLsTZjReAotqZy6JVzkZvjOdE+UDzqgRFAtOjfdW7r7Ah63/0pddG3EmWZR02EIjCdaXRO/PBezbgem3672G16PqxJzkFwCtzmKPHDCjEy5tGiVQz3++wWhRP9Ezd97jFs50Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM0PR04MB7170.eurprd04.prod.outlook.com (2603:10a6:208:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 13:41:54 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 13:41:54 +0000
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
Subject: [RFC PATCH net] net: phy: transfer phy_config_inband() locking responsibility to phylink
Date: Tue,  2 Sep 2025 16:41:41 +0300
Message-Id: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::38) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM0PR04MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a76ba1-93ed-463a-fd0b-08ddea267a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLwOalejslkr1GoB0nSwkekTtZJloxB0xsXLzdPO1T6So570Xwwbno09gboT?=
 =?us-ascii?Q?8rgqrVhprldXsrdxySH3LQ6iVeAuGUwSOLGI8NzRUxahhoPxMSgA9WIiwNHh?=
 =?us-ascii?Q?feOkG8t2MgDtly5nDsjTT9m2tLqS7XTIPskE8SOHrYZmIMrQe1tCkjdY0Yxw?=
 =?us-ascii?Q?eaVCc4otGSdRqsQIlb5YX4TR0OyvUNq0fdxYi2lsppCkAKfh2wDcA0iHlXVk?=
 =?us-ascii?Q?gcYd2QkZMvgQglhoEAbjbl4rQeNWNby6HA4JdH4PuMaYAKaNRkCShqvjwLCc?=
 =?us-ascii?Q?RqLY4E5givaQYrGRD3ljfe5OqRAwj5NHMY1i+TBZFTiFu0zHjeh0HIVonYiM?=
 =?us-ascii?Q?0srWhMxXZpGwQKp4kpF5V1+OMIKhrtw0z17KxI+Cyqnp9BdWDox/smRotJ4r?=
 =?us-ascii?Q?+EjE+kRsW9tT4GK6H+M4NhkbLEJeMWzzhn2Gc5AnxaIsA1F9wkzbeduXpqkR?=
 =?us-ascii?Q?0WKHA13pYljUZfNBEQCSmmTkiv8AJlUolMwjGD8xeq1nmx93DrGPmD7MiTkt?=
 =?us-ascii?Q?Ukhki0cntzDutyhkPVI3ELW5DTnkdwYs3PKZxaNIcYM7uPYpisFPEwAvwa6x?=
 =?us-ascii?Q?jbIsJlT0snRrAc3EeTqUQTZG+tKNrq9cTiNmpRFxGIoizjJmFugOQEtv9Pbz?=
 =?us-ascii?Q?yEMKYth+whcPWWaGsQAOIuyZowqRYjzBKeriJ1pOkPqOp/x5d4jWPrRJ39J3?=
 =?us-ascii?Q?XlWGZ0QKa73RlPY4riYUDJWDv374nDfTMlj/ypkwEH0w80CaqLBL6ZFEJnUB?=
 =?us-ascii?Q?su3zVyXP7830uJmaH72cZVS/RLN4dUiMu0yYPpZgLygjSLGOWcFjdZjtllkh?=
 =?us-ascii?Q?mY+9CBD6slSyR+q9Pv93LKiWtbQegHi/7hrs2Vx7VMyrnv4kEy7LD1cUMP5n?=
 =?us-ascii?Q?l8oFglnmJ7TezEJ293eLA8J10HlxooKnTAktTO/aEzbEq41bFzxMSbxLli+x?=
 =?us-ascii?Q?PvfOofCzshwVOJuNY2L26kqbZrgwOE5AJSG5YEu1w8keUZnkQEfTncByTAQR?=
 =?us-ascii?Q?BHFg9MfnZwUZkI4OcSiOWKNGiQNHp0x441WTjeSuW927czpCsQgQhZ7/ekPZ?=
 =?us-ascii?Q?MI+LU9RJGpJu+k9HbxeI4mqGCYxFCaRQJLpLMt/6hMWqeOmPcBxXQ2Wmgzjn?=
 =?us-ascii?Q?ZMXZKv90r84A2wheP8Tr74yxxBQnVHVKfIJLSfc+GiQDsKadmW+P/QBV9iMJ?=
 =?us-ascii?Q?Aa+Z8ckUcgPmBxUlCwCd3eDEwhObT/okJH2OfwGvSRvyPh/11ABMA08VTh0s?=
 =?us-ascii?Q?V8ntvJJdLB1CmI+bSdFuvH9nAkvrw69C+1YgPczAXvV+5RzRZUeLCZjyHmGL?=
 =?us-ascii?Q?YVc7xR9eF5yrbI+254s3H9aFygxVE9hkBexaGA2lp34LoKM4o3vylgYaQE16?=
 =?us-ascii?Q?nc1zHrFH174QpqDGcMLjFABx4BQp4YReUlKM/wskI/tHlQlni8MV8nC0O6mI?=
 =?us-ascii?Q?jyv+lHyOfy5KpUbkDkIIuztr6o0uo/5R0zNILP6rG6Qu8Zrusczz1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImEusQimPDrb9uLHzcmldxTpbZlwKq79CS1aWNrDGMwVwY85Ydg6lJvs2nzA?=
 =?us-ascii?Q?bDkZIrHSOcitnzAH5uxZEKY4jVzKj0bbgwvJaRYxWoNcN5CXTBmMVdWKzif9?=
 =?us-ascii?Q?p5LvcPFc6RWw1wl0GDp/D7o8ZqzoFby3t90QFIcQsVU3ixrnU6To29YIgO1l?=
 =?us-ascii?Q?ZAx68cy/v5Hnvk5Gp7udULNN/f7kcQLRSJzTpcD7n1ScSVXuztQ8fmPZpGH1?=
 =?us-ascii?Q?tiDJqAn+SsMxBjhlISyUgHSSX5SUjV+B6sanYiLDv+MmRJwCQ+kJ4F6dzjN4?=
 =?us-ascii?Q?n96WAQcrOxqS/udb0etMgRIFWhYCn8SBJ8wDNlMG6uHQ6UVMUGFE8JRnZHn7?=
 =?us-ascii?Q?LO6r4hmTYFoKAkm3mK2IKBYrLvMweTUg2j7sTnamWYslT9MDCm5mfWRp5fAM?=
 =?us-ascii?Q?zDHMhoOZ3JYQUptiJmDNYAyt/37EppAYsPG93o8qACJTnBOOq8tzYyD8pMbh?=
 =?us-ascii?Q?m55fxSVZDOLht/azXs9OrceQEI39Cse5n6W2LdM9yh5yKLF0GV9/tpbtZNG/?=
 =?us-ascii?Q?NfZEXkzif4ubECso906CAUWK6lnhuAEzSkOAM/xHkMT4WGbocdfliPL0iIPY?=
 =?us-ascii?Q?VIMJpSSr/sl4sapDfQr+0TzSeb8go8lhij17YTGsS58qYP6vWZb9Ttbgt8zi?=
 =?us-ascii?Q?54WCZlxE7BlCg4GcXgkwulXOr2M3GS9FQhwEZX9CH2k1dOdD2/tTgcoa4PG4?=
 =?us-ascii?Q?O5Iycx/lW5Rhh9LblolLmxDUB35KSuaoRCx31YGKrzM61k10E7RZNPDCoq5d?=
 =?us-ascii?Q?ko/CN44Vz7qeEISDXv07KaiX+2eMuHkpd3fEs747TX+USCsMXm/ZcXEAu4RN?=
 =?us-ascii?Q?7DWzylHgVrPgXyVPYCa28WLVrmhGJ0ImxVfoA7Ig8l3YCMbD5JB0zT1xtT7H?=
 =?us-ascii?Q?5ZXBBU4MsSMPnoVAPieX9VB8WVfvz8VzLdNTZ6nJDSWBqSEzBAkGsUskj+bi?=
 =?us-ascii?Q?AF7byAHnKVaB2I1cfeGefEnNHeeLmu8TaN/fdzuRm2X7TFS8518G/Q2DXIOk?=
 =?us-ascii?Q?d9VxU8XCfyPpAHHV1v5OTdFYSjdxp67BevDcxQ3oZw/xLVvQKw3zXkMzan1x?=
 =?us-ascii?Q?lLSkK51wHeRqYRy3Dxh6wOKK2RmD6eFRsMU1gy7vwmUhQPP3w4JmyTE/LU2m?=
 =?us-ascii?Q?nZucVbcwD9TSHz/yATUL7l4CFSCPu7o9oLHa3K7QrEA3px2PtvCeTzxJvAn0?=
 =?us-ascii?Q?+iU+82YUDqDNTQ9PwdkWh0T468sWZA7m+2dWD9utFqnDgQ1G4dHFiDQAkUnW?=
 =?us-ascii?Q?Y0WH8DdTGl3FWs8dG0PLQkHb3rV3+q+b/RV1F7MOPnYtB2EY4UR6vn49ZJWw?=
 =?us-ascii?Q?B/MTQd/wlQZXzZ1fkeMs0S9srXiGEXJm0Q5ZsJzYxOCaHthT3zQPkIz9vI2G?=
 =?us-ascii?Q?ncv4SE1VwvhmEAJAYjlgeeIZ+7wFEcKgL4sbwUreWDMCUzNZ7VPWUIRvpyLG?=
 =?us-ascii?Q?UgK9ilQ5iyvIzBAl7VH62N6H7/sMhhtk6D+gd9zLC8ObgAipKVPoQ3XrlGYy?=
 =?us-ascii?Q?u2y0b5Wy9CBwpy9G3WZPzxbcfwsc2ICu2Pzfrrzx3wXSMaVMEX/niyJJ9Tvv?=
 =?us-ascii?Q?VK71JwMFta5qwPi1dnDQlvoQrHkJ8U07tFBSjNIb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a76ba1-93ed-463a-fd0b-08ddea267a8a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:41:54.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVUT51Y9qHR5hI50BQSMkcL+/u4lLnBBKho/KVW3UFwcnMuYMrRh4K2u5sjnwLWDyDoVsV1vOBqxzoA3Ytrxqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7170

Problem description
===================

Lockdep reports a possible circular locking dependency (AB/BA) between
&pl->state_mutex and &phy->lock, as follows.

phylink_resolve() // acquires &pl->state_mutex
-> phylink_major_config()
   -> phy_config_inband() // acquires &pl->phydev->lock

whereas all the other call sites where &pl->state_mutex and
&pl->phydev->lock have the locking scheme reversed. Everywhere else,
&pl->phydev->lock is acquired at the top level, and &pl->state_mutex at
the lower level. A clear example is phylink_bringup_phy().

The outlier is the newly introduced phy_config_inband() and the existing
lock order is the correct one. To understand why it cannot be the other
way around, it is sufficient to consider phylink_phy_change(), phylink's
callback from the PHY device's phy->phy_link_change() virtual method,
invoked by the PHY state machine.

phy_link_up() and phy_link_down(), the (indirect) callers of
phylink_phy_change(), are called with &phydev->lock acquired.
Then phylink_phy_change() acquires its own &pl->state_mutex, to
serialize changes made to its pl->phy_state and pl->link_config.
So all other instances of &pl->state_mutex and &phydev->lock must be
consistent with this order.

Problem impact
==============

I think the kernel runs a serious deadlock risk if an existing
phylink_resolve() thread, which results in a phy_config_inband() call,
is concurrent with a phy_link_up() or phy_link_down() call, which will
deadlock on &pl->state_mutex in phylink_phy_change(). Practically
speaking, the impact may be limited by the slow speed of the medium
auto-negotiation protocol, which makes it unlikely for the current state
to still be unresolved when a new one is detected, but I think the
problem is there. Nonetheless, the problem was discovered using lockdep.

Proposed solution
=================

Practically speaking, the phy_config_inband() requirement of having
phydev->lock acquired must transfer to the caller (phylink is the only
caller). There, it must bubble up until immediately before
&pl->state_mutex is acquired, for the cases where that takes place.

Solution details, considerations, notes
=======================================

This is the phy_config_inband() call graph:

                          sfp_upstream_ops :: connect_phy()
                          |
                          v
                          phylink_sfp_connect_phy()
                          |
                          v
                          phylink_sfp_config_phy()
                          |
                          |   sfp_upstream_ops :: module_insert()
                          |   |
                          |   v
                          |   phylink_sfp_module_insert()
                          |   |
                          |   |   sfp_upstream_ops :: module_start()
                          |   |   |
                          |   |   v
                          |   |   phylink_sfp_module_start()
                          |   |   |
                          |   v   v
                          |   phylink_sfp_config_optical()
 phylink_start()          |   |
   |   phylink_resume()   v   v
   |   |  phylink_sfp_set_config()
   |   |  |
   v   v  v
 phylink_mac_initial_config()
   |   phylink_resolve()
   |   |  phylink_ethtool_ksettings_set()
   v   v  v
   phylink_major_config()
            |
            v
    phy_config_inband()

phylink_major_config() caller #1, phylink_mac_initial_config(), does not
acquire &pl->state_mutex nor do its callers. It must acquire
&pl->phydev->lock prior to calling phylink_major_config().

phylink_major_config() caller #2, phylink_resolve() acquires
&pl->state_mutex, thus also needs to acquire &pl->phydev->lock.

phylink_major_config() caller #3, phylink_ethtool_ksettings_set(), is
completely uninteresting, because it only calls phylink_major_config()
if pl->phydev is NULL (otherwise it calls phy_ethtool_ksettings_set()).
We need to change nothing there.

Fixes: 5fd0f1a02e75 ("net: phylink: add negotiation of in-band capabilities")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phy.c     | 12 ++++--------
 drivers/net/phy/phylink.c | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..c02da57a4da5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1065,23 +1065,19 @@ EXPORT_SYMBOL_GPL(phy_inband_caps);
  */
 int phy_config_inband(struct phy_device *phydev, unsigned int modes)
 {
-	int err;
+	lockdep_assert_held(&phydev->lock);
 
 	if (!!(modes & LINK_INBAND_DISABLE) +
 	    !!(modes & LINK_INBAND_ENABLE) +
 	    !!(modes & LINK_INBAND_BYPASS) != 1)
 		return -EINVAL;
 
-	mutex_lock(&phydev->lock);
 	if (!phydev->drv)
-		err = -EIO;
+		return -EIO;
 	else if (!phydev->drv->config_inband)
-		err = -EOPNOTSUPP;
-	else
-		err = phydev->drv->config_inband(phydev, modes);
-	mutex_unlock(&phydev->lock);
+		return -EOPNOTSUPP;
 
-	return err;
+	return phydev->drv->config_inband(phydev, modes);
 }
 EXPORT_SYMBOL(phy_config_inband);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..350905928d46 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1423,6 +1423,7 @@ static void phylink_get_fixed_state(struct phylink *pl,
 static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 {
 	struct phylink_link_state link_state;
+	struct phy_device *phy = pl->phydev;
 
 	switch (pl->req_link_an_mode) {
 	case MLO_AN_PHY:
@@ -1446,7 +1447,11 @@ static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 	link_state.link = false;
 
 	phylink_apply_manual_flow(pl, &link_state);
+	if (phy)
+		mutex_lock(&phy->lock);
 	phylink_major_config(pl, force_restart, &link_state);
+	if (phy)
+		mutex_unlock(&phy->lock);
 }
 
 static const char *phylink_pause_to_str(int pause)
@@ -1580,10 +1585,13 @@ static void phylink_resolve(struct work_struct *w)
 {
 	struct phylink *pl = container_of(w, struct phylink, resolve);
 	struct phylink_link_state link_state;
+	struct phy_device *phy = pl->phydev;
 	bool mac_config = false;
 	bool retrigger = false;
 	bool cur_link_state;
 
+	if (phy)
+		mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	cur_link_state = phylink_link_is_up(pl);
 
@@ -1617,11 +1625,11 @@ static void phylink_resolve(struct work_struct *w)
 		/* If we have a phy, the "up" state is the union of both the
 		 * PHY and the MAC
 		 */
-		if (pl->phydev)
+		if (phy)
 			link_state.link &= pl->phy_state.link;
 
 		/* Only update if the PHY link is up */
-		if (pl->phydev && pl->phy_state.link) {
+		if (phy && pl->phy_state.link) {
 			/* If the interface has changed, force a link down
 			 * event if the link isn't already down, and re-resolve.
 			 */
@@ -1685,6 +1693,8 @@ static void phylink_resolve(struct work_struct *w)
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
+	if (phy)
+		mutex_unlock(&phy->lock);
 }
 
 static void phylink_run_resolve(struct phylink *pl)
-- 
2.34.1


