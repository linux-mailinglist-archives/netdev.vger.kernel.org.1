Return-Path: <netdev+bounces-197584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E5AD93F0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6271E2A96
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01823212D9D;
	Fri, 13 Jun 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1p1ymM5"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7495229B2A
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836897; cv=fail; b=OnX1CC6ldnk0bDai8G7Aj+SWVxEiKGBcRsFq3K6GZTLSi62O/M8UPJxxrKlpJakgm2ni8s/dHq6cAtFbaXpAoE3dCOX/wohPXj1ItQqkQcN4RUe5TjkO0KbceB5bpuwIIAnK3nWSGwJxtZJo61ii7DH68pWBvGKbC/ytkrv3zIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836897; c=relaxed/simple;
	bh=vnlQrNzNbkMt4aOhzglkbo/+bV5uQBHAbNQ+gtOK0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2V/QgLD1qmpkKQ+XNBRu55hpOkgP1oAji0dzy7G0zWCkw4T6XrMA8Cs5IhmrvAm6zGe5PcNJX1kzWgZ+1kYPO8vXavnlL6o/skM/W5HHlbzmBnyYVo6ewJOY/EadpbQAsaVOzTaRXs7l0brz/T3zVOLdKYWSax5YzhHaRO4lM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1p1ymM5; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv7Ok2uBmPmdtjqjrcKmpR7mnBEAFc20XJrTldrcEVALz1dbk93H6vf082oWTe1PpX/LtgdTVCKulw6CUSerkLgKhgWJXg/26hUVSaI2kfnfgwYP3Pc5bm4ANItp8P9CkUpkaORdZ8156d4vClBLHajcWeVJTOWf7ue+q6ayZ1WVKBdtxP+4nLpHUvbZxDB3JYU1u4uTBsiAjZp7j1YnB9RaIw73niXcbM6882NxuThFCVlP1hl0lyns1vUjb0WJ9l38UYqX8TEO4GZ/I46+T64Zu60QS3nbKztgDZ8/Ra5+U+uebfHtxQAHXCJithNIcRxT3poHX1M7H4quwGzzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onrjx0picsAIRE85afNJbLVDjZJgEMWLgEZYgDQD2Lg=;
 b=T2eUp1MOKbslNE6eLJcSnxWmHxo4Ne0kxcf+JuFN0nvHdNeBOY4bI4+1VX597Klbg0ZEDnMC9MwoWNLYQsrQlnU5Wf3sP1SSB6JjFeBQgc+JPcysk5PJpbeuSzxNyyrncekSW+1IxCiUVX0w9kyvthRuNcmkoYonccs5oAZ45nVoNcboeoWfhmLNwgtOicSFw+VBIAot93BwVuluQO4KjSco63IMqHCQ2rsBC5oCbE+JdypyqnXx1VOe1DWk/tfd5p7VAxt6KNn7GJn3aSBQREA9f6xV6d3K3fvIW5KVtE5LkyRWiRZox0apThp1QoUNg/wDhHzw4KrO54CfOctrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onrjx0picsAIRE85afNJbLVDjZJgEMWLgEZYgDQD2Lg=;
 b=g1p1ymM57a+0hYXFzKgarPqKZe2LCREKi8jXKfhbZk2tntwYVxrxFoaYYMnw0j0SiVaHHyUqKiBeYsVYiKjA8Rm6iH7rP/8dTeZcPU2QOOJuSKYR6/LXNPiCt6p0mC3VcOgsX6NZZAWqfTW3m1SaSrkkyY+VOewmXm91LcqBnvj7y2dzXDJEDzkWNrg3YYPOIivkXh1LS3HxWXUBL9ixt7Vi15WNlWckesBPmVif06DjSCv9Ibsx1CKuU4pPJPyyWFmFXJA6O2wkeqdiNJrtOXabaLn/3iC6iV3t7idtZsg0b+lrJx+bfViRa6QfNSoGR2yuoCvTfFEobo5m4VCdgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 17:48:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:48:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeongjun Park <aha310510@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net 1/2] ptp: fix breakage after ptp_vclock_in_use() rework
Date: Fri, 13 Jun 2025 20:47:48 +0300
Message-ID: <20250613174749.406826-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613174749.406826-1-vladimir.oltean@nxp.com>
References: <20250613174749.406826-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e421323-7575-41b9-6bda-08ddaaa27496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4rfmMmAY5mADaMLg+HfGFEIL6RDAPMGNNCBzC4OC3whV5rJ6KsSRw2lbPwpy?=
 =?us-ascii?Q?5d+WxtV3UJLCaV7rYCp0sK8tUml5mowap1SLNvk7gzZQiTOrVPxgY76jzoSo?=
 =?us-ascii?Q?ind2ClRByjJRgn59Jl62x6J7lP6fBkGEAN19j3WmlAVx6AyJf1ZreU6sVZXA?=
 =?us-ascii?Q?6M8eD3Azm9TqNrrZS7NBHUVyvv/lDba8TjwMAx+EwB2Tk/mwpvWg8WqCwIxi?=
 =?us-ascii?Q?dciXU4BVIwfr4wOcvjl4sLnQK7EzG+4nTfuHNW24g4hKcKf6/GYYxa+xWIvy?=
 =?us-ascii?Q?PnQVfYkxP06Ns6liErSFKhrUkHOfaY8L4zSEfP8KX5W+FARJX6fkY9awOIts?=
 =?us-ascii?Q?pfS/k9aYV2YFNeshnXWTZaW+iaqmoOgey3fWNbizL/W4KBQBJih3EvZdsAUI?=
 =?us-ascii?Q?uAB3pmEyCOgafAAsTlN0LBkUzTwe4N2aikdu+ltLhGGhYbX0LwdnTSPosJ7X?=
 =?us-ascii?Q?J2Dpp3GxZJXOzxKSxBI0S3tkcgfwdUuxadcMl+ZR+Kl23h1pfJK6Fj9jsV3i?=
 =?us-ascii?Q?JRmeEsHp3YNI3oJG51CH5bx8zGKH7IJ7JsVWlK+nr+z041urf6QfM7OXcH3B?=
 =?us-ascii?Q?qW8/o0UpTFO+2UYKa9SeOyoMYTSQh2zKFnISDh7bwfezLp5ivbXiTZ5SCY8n?=
 =?us-ascii?Q?gW1LNvIJyZ+mKYNCqoM8Uh8drfPs9/9gbCKwnkaEprxkd6ib9wzGMZGhLdbm?=
 =?us-ascii?Q?6S3+Po/XVhEJMl5qUqiT9E2acZBsZnySWhOwKRCyCYvYfcKW0KI6v9PkrVaY?=
 =?us-ascii?Q?0RU5pRglr2OS0O6mMQ6BQh6JVKoC8eJ4xMu+Xi30gDtUJsHsVX6KwbACzF0u?=
 =?us-ascii?Q?vlpeI3Yisb3ZyEUK0AV4WAQkwNZVI7pzUPqN3+N6rPpz8N8PYS88bDEaksOP?=
 =?us-ascii?Q?TOQlEBZDW5q3yJwq2jQLW4XQ8igMkRjMLXwMiWvNDPjuV9mNpwpzvcAfyjvG?=
 =?us-ascii?Q?pZQvUmH3wz5s/pWr78qgBnMKd8Gyz56moP4QYWOvlaEtwuprytpQyuHzl4aZ?=
 =?us-ascii?Q?jIK1muE9YoM12weuKmldovLKFdY0mKF2A6DBGPjIL/SLhz8WpTRBKj60CfRd?=
 =?us-ascii?Q?1X/q9z737+2TD3SjLlix7w+vy7Qd9WtPY+Ov/wx59aM1s2wktktlaJYsk7oA?=
 =?us-ascii?Q?LLjkbhyN11Spy0TrbBZAxwVJKRMouypwDckbiQ0SnFwcemgJglv4Rzq3ZvUR?=
 =?us-ascii?Q?uFhjZ6qLJS7L5MHQa4xW/AnS5enarXfjLA1GVNLZFcK00Sniq8viJK8oSvew?=
 =?us-ascii?Q?ykPgv1yInDn/rse1kJGbsOOMMp8IB8C+po/xtkQLHVXZSskWKlycidDR6a3x?=
 =?us-ascii?Q?gvY7iX/j6G/jJ79zRT6YfWPTFtosTlIa2tpOaLBboYlzZi7Y8+dI2q7Px1Yt?=
 =?us-ascii?Q?4iWTQMxgDSuOxCzUvlY2pL8yLjHIsVJ+rFqncYE/TnM+ryROb42bhFVxKOm9?=
 =?us-ascii?Q?L59rQEMQMPF6IwR/TMfeu5qU7H4mPnMDjd+jniWeGKGz1zl6WLqHDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMEBWUpEAF5K5fUp9HZpanZWfxDT5akQfIyykNwt5DhwvFDXlGdHyJSvoVrW?=
 =?us-ascii?Q?/MxZTsZ0yHnDcLJspgBGLl8T2RP63anBX7l39DjrnHSh0LiGopV9ZNfA3bLa?=
 =?us-ascii?Q?o75iKdN/YN8C+7DPc1zaGX2pg12sDl761DRQnTK0OEdz70uMOYEF9kAP4aMI?=
 =?us-ascii?Q?+roBkE20aFk2TbxSVewvM+qcZnrfPjXlwkMcTvKl/ZrZB6Oe7Nvzmqii5sIt?=
 =?us-ascii?Q?7+R7kXmBlFlWHHt7PeoScZJcpUnd4bwMAR09q+BqAUiiayJVieudkszL7bma?=
 =?us-ascii?Q?k8rTGw7mQRpQxjpW+Nm06TMk9YC+52WmmLIsAc3mSkP7jDhzC2V1GjmE7MsX?=
 =?us-ascii?Q?l3CJ9O4t9mmAWEOjEJbFbUJUrtZ/E+yRqUbwEtK3lyItce9unY1EBphOYQmM?=
 =?us-ascii?Q?zCdw7wc56omHUdQE7IesR2XtkK4I90+eLk4F12M1gLBc89sva9tWwQpIovhQ?=
 =?us-ascii?Q?/ZLntFNdV00b/64Q4522UOyGPMvejqSySqspILyGtfykhgNCYVXDO2IkcP9b?=
 =?us-ascii?Q?WgDau2DhsIY0aqsdOsTbiu2oyK7uKhEkzY1XYAffHfN5c1DjauYYM1j39y1J?=
 =?us-ascii?Q?Hg3Qe3vyAjcYuMqA3IAAOe5rG3WcCUCjBPSaT5pN2zBEcZn7uHThlf0iydve?=
 =?us-ascii?Q?IXuNRlZEy8XHh+ODcpioq2eplqE7J/4bBdW+sbGgG5/z8VYNWKyd3Ggn8bzD?=
 =?us-ascii?Q?zza6Q0U/UVkqGeGDk3/u1WdH9PCVxukNGA9T1kymrAgAvegIZ+n+N6csmRpc?=
 =?us-ascii?Q?3yYrTtJLdEJGZntLnG25dXwyer9tgBuxKR5kyjNUBEipIdbAbi9Yj1FNXQrI?=
 =?us-ascii?Q?iWjWrUgAZPbfGT1MtfHfYlTaJlvtLN1Hx1eeqX40cVKf3Y7b8nNAwmauI09I?=
 =?us-ascii?Q?ROA0xZUwRHVrIaDFYBtcugK7bdZqQ1NLoXvIYV2TMxu9FfjoVBbFfiJR5/wT?=
 =?us-ascii?Q?WH4P4axCAQniItuEQGV5Xdb+0oKomJmvUifTpzEbMdTvmYgfv8mk3Gic+776?=
 =?us-ascii?Q?D/20i4qpWTSQtSyw+2RTaAQk61+HcvlX0NktF6TlZ23l2V69w+nFWir40rZP?=
 =?us-ascii?Q?HzTVArZEm7eN2/ffciL2pXBXQ8LqWJmnqB8/866SpVOSdlhQAa5khbO56P5R?=
 =?us-ascii?Q?vtlYS5vOanir6jfsOUkjE+15m5eFw4SJ+1XbVyxIHaNYZxJEexrqF2cwepiA?=
 =?us-ascii?Q?NkwX5F9hcWIaf1jJWLVZggYZGhwKs+cBQspjeIYNoT9kFOuT4KULzpzBlmP/?=
 =?us-ascii?Q?dhsUWRiWfUvVF6XkZYRfhbNyMj/59kHQG0G4rlcLmB8BUUuUpj3sS5KrryCp?=
 =?us-ascii?Q?oEPPYdvFpME6xxcPojcKg0T4MGjTqH6JLgk/GnRDW8ESxtD6HHInJ/EPw3bf?=
 =?us-ascii?Q?U4DwX99ZejQSTnW06lrPSysuBuZINWiOA1b070VebB5INnyfjhGv+Nw8uL4h?=
 =?us-ascii?Q?wRj9+klvYW9xvUlR2y2EB8J8ns6b30lyJlX0iFC5bM2u68tYmH2Q+fzsUf37?=
 =?us-ascii?Q?cMIMRL09RHr0oCgDxUSruzyy7DG7v/OZLbEcYZg58jFanJBSa9KbXKSVczqf?=
 =?us-ascii?Q?OEvgNl0AuIMTMZflSJoWMHKbCD3FS+6EY90Dm1WF71L8hIqO9VK1Q+i25JQN?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e421323-7575-41b9-6bda-08ddaaa27496
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:48:07.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lKVkujfhpF7EQwL3q8Yx+yiVjerXxmOoTjnnLxsI8Ayfb7M1kGUjyHVm/yWCsyJLiyuQbr8Pym4aWURcRkH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694

What is broken
--------------

ptp4l, and any other application which calls clock_adjtime() on a
physical clock, is greeted with error -EBUSY after commit 87f7ce260a3c
("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()").

Explanation for the breakage
----------------------------

The blamed commit was based on the false assumption that
ptp_vclock_in_use() callers already test for n_vclocks prior to calling
this function.

This is notably incorrect for the code path below, in which there is, in
fact, no n_vclocks test:

ptp_clock_adjtime()
-> ptp_clock_freerun()
   -> ptp_vclock_in_use()

The result is that any clock adjustment on any physical clock is now
impossible. This is _despite_ there not being any vclock over this
physical clock.

$ ptp4l -i eno0 -2 -P -m
ptp4l[58.425]: selected /dev/ptp0 as PTP clock
[   58.429749] ptp: physical clock is free running
ptp4l[58.431]: Failed to open /dev/ptp0: Device or resource busy
failed to create a clock
$ cat /sys/class/ptp/ptp0/n_vclocks
0

The patch makes the ptp_vclock_in_use() function say "if it's not a
virtual clock, then this physical clock does have virtual clocks on
top".

Then ptp_clock_freerun() uses this information to say "this physical
clock has virtual clocks on top, so it must stay free-running".

Then ptp_clock_adjtime() uses this information to say "well, if this
physical clock has to be free-running, I can't do it, return -EBUSY".

Simply put, ptp_vclock_in_use() cannot be simplified so as to remove the
test whether vclocks are in use.

What did the blamed commit intend to fix
----------------------------------------

The blamed commit presents a lockdep warning stating "possible recursive
locking detected", with the n_vclocks_store() and ptp_clock_unregister()
functions involved.

The recursive locking seems this:
n_vclocks_store()
-> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 1
-> device_for_each_child_reverse(..., unregister_vclock)
   -> unregister_vclock()
      -> ptp_vclock_unregister()
         -> ptp_clock_unregister()
            -> ptp_vclock_in_use()
               -> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 2

The issue can be triggered by creating and then deleting vclocks:
$ echo 2 > /sys/class/ptp/ptp0/n_vclocks
$ echo 0 > /sys/class/ptp/ptp0/n_vclocks

But note that in the original stack trace, the address of the first lock
is different from the address of the second lock. This is because at
step 1 marked above, &ptp->n_vclocks_mux is the lock of the parent
(physical) PTP clock, and at step 2, the lock is of the child (virtual)
PTP clock. They are different locks of different devices.

In this situation there is no real deadlock, the lockdep warning is
caused by the fact that the mutexes have the same lock class on both the
parent and the child. Functionally it is fine.

Proposed alternative solution
-----------------------------

We must reintroduce the body of ptp_vclock_in_use() mostly as it was
structured prior to the blamed commit, but avoid the lockdep warning.

Based on the fact that vclocks cannot be nested on top of one another
(ptp_is_attribute_visible() hides n_vclocks for virtual clocks), we
already know that ptp->n_vclocks is zero for a virtual clock. And
ptp->is_virtual_clock is a runtime invariant, established at
ptp_clock_register() time and never changed. There is no need to
serialize on any mutex in order to read ptp->is_virtual_clock, and we
take advantage of that by moving it outside the lock.

Thus, virtual clocks do not need to acquire &ptp->n_vclocks_mux at
all, and step 2 in the code walkthrough above can simply go away.
We can simply return false to the question "ptp_vclock_in_use(a virtual
clock)".

Other notes
-----------

Releasing &ptp->n_vclocks_mux before ptp_vclock_in_use() returns
execution seems racy, because the returned value can become stale as
soon as the function returns and before the return value is used (i.e.
n_vclocks_store() can run any time). The locking requirement should
somehow be transferred to the caller, to ensure a longer life time for
the returned value, but this seems out of scope for this severe bug fix.

Because we are also fixing up the logic from the original commit, there
is another Fixes: tag for that.

Fixes: 87f7ce260a3c ("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()")
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/ptp/ptp_private.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 528d86a33f37..a6aad743c282 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,7 +98,27 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	return !ptp->is_virtual_clock;
+	bool in_use = false;
+
+	/* Virtual clocks can't be stacked on top of virtual clocks.
+	 * Avoid acquiring the n_vclocks_mux on virtual clocks, to allow this
+	 * function to be called from code paths where the n_vclocks_mux of the
+	 * parent physical clock is already held. Functionally that's not an
+	 * issue, but lockdep would complain, because they have the same lock
+	 * class.
+	 */
+	if (ptp->is_virtual_clock)
+		return false;
+
+	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
+		return true;
+
+	if (ptp->n_vclocks)
+		in_use = true;
+
+	mutex_unlock(&ptp->n_vclocks_mux);
+
+	return in_use;
 }
 
 /* Check if ptp clock shall be free running */
-- 
2.43.0


