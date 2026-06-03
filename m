Return-Path: <netdev+bounces-294777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ubdVLAY+IGp7zAAAu9opvQ
	(envelope-from <netdev+bounces-294777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:45:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7121A638BD6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:45:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=nH+WTouc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294777-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 780E43046BF2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71A33BBA2;
	Wed,  3 Jun 2026 14:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077C33A6E9;
	Wed,  3 Jun 2026 14:36:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497402; cv=fail; b=jQ6N5Cvd96zbGtWr8N1faWjXUrK4o5FJ0H8absyRYL2txaWVeIaj3skVrS2aGMaKBIIiasHsavjVYy4kLAQOpL5njlm4SSKRT9krUmOFocJD/NYbzvIzlAbM1k9zjbhAaJqibOViWTGpncMuJlUyEg0YzA4FHPL3WV5zE0kt2IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497402; c=relaxed/simple;
	bh=C4SgsX1MDkHUnKwDq2z1OPPXIS0K99s5QONW95fgxmU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZMosOz6bj0K3/dL9H3srlV92dsFGwYKzPw8j5ve95wh8epqDn5h6ZyE9CrSN6drIlHrzH1lb4wi7aiDtjY3hpviSu6f8Vmd2yTcBMo0ZLcGvjWaK1TEB2s3F4/tkFQGmXaW7vz1aLXxTON6hI2my51VF/hr0k+LW2c3ztPXlb4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nH+WTouc; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBO9RRejIrv4kIak357xlLoVydn9N2u8f0EIp81GTPwr9wGb644hqj7JvZ/aM2cLxzfe+myqA49pRvGg6MNtJyQpnoD0JFtbj+LHXxT6/+2347Kf14MzHJW6YnjNDWHIeT/0HNNa9S+o/NdO4VvobIqTCxppoHve0mjHQCBCtrIn7vdzeaGtGU3SenVvZ3oFlKY7GDBBaSz8hdLlLG2gI9l7VZ++rgxmPTL42czSOq+gp1QvZfySZB+M4FKg4k1rCZdFbg+g9v1oG84kftrvu4ANigVYpZrpULwNInGsrPP7KkzRefDTZsWc5vKZWXKrQUSkJx0hkDwg4HHBVa9Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l+XhPh+tJyf0g4BWgsujEJYZrqMgYkupX/M7/miSyw=;
 b=DSqkbW0kPaulWmm8s2XOuDquxGixdB/PV0qCnNVZ9pKI8vAABSI7ypZTcTHfHF53J1uO/ZW/Y4N3oBGc9duehIAdaa5JkNlwuLg0rPdDAu/n9pVIAmvcZNQ/77OYHcOW64/kyj6+DYa/65Co7edY/PcZH8M9M9VtkV9iV3hW8AHzXHekPkbVQXlDivpwQ/bi1aSaCseEfeq4YPIhNSzw0pCB1zFmC6Y1SUGMLz0kZ8zkQYIyhv+bxAXUGCOXo9e4Gvi16Hw78FTvN6LOxTWPHEpa87w/OWG+ZiDOfqSqmAaH2UHagUKEfiI3z1zpdgmjUQEfj4tY2Ni6myNn9PSEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l+XhPh+tJyf0g4BWgsujEJYZrqMgYkupX/M7/miSyw=;
 b=nH+WToucS2yaFgfxi7VylYG0pueXHjsN77kwk4l4wYoGnGE8HXLO4kzs82V5fphPS55h3KlsDDy5jfDJzCoidDSlkGzHSN4D/rgoWMiD8eMLs8Bi8m+XhHxMo9gad5mQxptEfKXRAKtd+WQ2U7XbJoF4IWLrqvNawXnmZ6Nzn3Kqgdz4wT4mnn/ePxStwFo3BhLGXIi6vuHA9SaH1m/W9KRXE94kp5OytI54mVVbkaU77NQVYlVvkwnvdTzS1wXwp0ymLn3C9+TCcPqNZ14fQySXISLMi6YRmVyzn19pJLrbtCJWeQOuN23reS5nmHPHcC96BT5sN15XAtFOnXLH3w==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:36 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:36 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 00/12] dpaa2-switch: add support for LAG offload
Date: Wed,  3 Jun 2026 17:36:11 +0300
Message-Id: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0437.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::7) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc5cfb7-6ef1-4ff5-e7c2-08dec17d8412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	E9DQq0V0BAvI8reIMuk2aVJr4wvsZoDXGl2vciHLkQOJaj7SR+vQPVivHy7BeSpeJ0wMysxr8ZE3wSgw8iUGfX7ftRz65K8E/s5NMpPpzLjeMQgnw18X+U1p+HQQ743R9vWadll2ay6zfzcV2oM0tMokIu3QM829klVElsHTbJo8K57cEemGVx3bvvZGevuUKquGuQGnjDkJr/pA69AA/t1kvjFSMhGF3wmmwKoCM1/J1g64drC+EluB7opBpAB9QsExcGHUh9yEwLhyXJCMe51ymNRYd8+qkhgELfv1WN5SwbAfU/qTU3tDNoEO0X7U341ch7el0SpRvxYorpamMdXtSHNIWX8oIO/DzioUyKFnN7FjA8pHvYw8Q8DeUTwE+DzFTfAWKyfo6I1Z/Qa7CklB7vo0/aS36CYmb3i5D1MFyWygMwsm1W31FHCPBru9J6fVgYIWbrdFQTm9oUYOpxQ66AVirCKfoufvBEpQnxjqrxGGm0ig2sZltivj92yh5B7Jxbq00Qel2fyJ+ad0A8QPl+TUi06rmT/S1yiexy6a6MfdnSJULeWsNUHSLy1vmP3jUNUkPqRlt/RRZ+JbdWjE/MFf8TJTg55HhJMpOl8+lXgptUePTr3eF6dJfHRnswjaJk87qagCNVYTTJUzVd6UMUI+5q2trfadshaT6t9eYWB49Rop+1bA90gYno5xXrO64l5r0az4/hSm50cg9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tQusI7mrS6AEsadHbjS8XN2/paRA6n5WqTwHy8AgtWkyCUxT/85e28LPH/Y?=
 =?us-ascii?Q?cO5MATaYhAm8JiEaNhKgUry9us4IyV45rdo+HSUTh2iIZ1BLQ3bvaRgW6A5q?=
 =?us-ascii?Q?QQazYPt7m1808IYix+B75p81jOc5sWXKnsYkZyUpvhUCUUMIP5qoiRDUWjXN?=
 =?us-ascii?Q?RCthrj+o70pMh97oLQaAebmoYT0p0e8t3pCQp2EUsMf2gPXQ5xMbGUn1e+/t?=
 =?us-ascii?Q?77QRNnpX4K8YBuGVPCZxGdNRqtZhA+KCO6wKzhOwRr7kCvgLxUYPVsA/EZux?=
 =?us-ascii?Q?0HtukR8aalwM/3H6Dq4zX9cbHozv+dYAx9KfH/UhTNm7CDXrJILEymhxor2Q?=
 =?us-ascii?Q?mvr8PAeaZtHuEZrddO/q39WAvDEsR1jcz6CD+uetyzuqNuzbPJ0J/dfL42f6?=
 =?us-ascii?Q?Tb9tV/gC8XAvCwN+JLeFQJ7/INE+Nc1ZpFDJjSftZZKu0qqiFyhs9eJyIiBI?=
 =?us-ascii?Q?o1p4HhC3YvTH38btC/D+IGv20ajW7nLjTHi0P4MPT6ShXfnvDLHUZtme1dTT?=
 =?us-ascii?Q?qFFihD2ZWZ9y1qn7uF1myx/jtPkokzvwkLn6uDiBBCYwd3Or/kPjh6RnBdbI?=
 =?us-ascii?Q?1pg7aDzSeS4b5gaEmZxoYgZZu2ZtZWrZzarGUI3yO79pE7Lzjdd2dRKAyrsH?=
 =?us-ascii?Q?LB9lpohPI14nNopLFAuROGZ4o2qrBAXwkmLxGb3VLf11/ECgHaD4NPZrRogw?=
 =?us-ascii?Q?WaBQTweYVVD8CJb/gv9dfq6Iwp/1BTRHCN0Ftp/6kH0TNhiP7+L/vqkLvGl6?=
 =?us-ascii?Q?WbfwrU/bGmC0ugam7/Yz+WcEeF+gb1q5j2PfdqiTPsFu7UQzd7mumUIw4fdQ?=
 =?us-ascii?Q?4U9EHEnY1uCBaKF3kvkeOmGVLv+FTigYhDcwhZ20kD5HoWqjv3A6AB8FzCWj?=
 =?us-ascii?Q?92/k1eOlaaoEwPN8mWsd9foG3F9uNqsjG+MJkVxuNSqBhJVwkULwn2bbHaSj?=
 =?us-ascii?Q?oIAYNcQ5pcfa1YwUoA6FDvQ1b/Ctot0AfoXqq14W7P7Ob5a/ZxVm9rURitvX?=
 =?us-ascii?Q?AXTkTbzZ3EDGlx2V+kEVcv64TxZNpiW7PS3n9VE7Aa070uGKL6wEXYhQmJJT?=
 =?us-ascii?Q?UK709B2uTauI3jpt1qOWk+aEUxecSn2G1w6KOcv3SOGm52VUAwn/UU6YjtWC?=
 =?us-ascii?Q?GUj0yfRPMwhCVIf6t1mM/CXZUEveHUw+L07gq9mk24qWpdAKdV2TZH4viLiL?=
 =?us-ascii?Q?EqYfbqK18Ea1a4CzRopZo3wluSiTEzs1MdmWwy6gEupa9Hb69Scb+2oLJDB/?=
 =?us-ascii?Q?BeQwGZHaA6X1ceXP1YyxoW3SCSw8PDJQung5SiKVbWCk1qkTifgkFaQpEDmF?=
 =?us-ascii?Q?ErCpbCiDEBpgEKNXvc5QcA9dOmTU4vZWOwreOXiJeJoIwlIRwhx0tFYX9Q4W?=
 =?us-ascii?Q?JQRxiqOb1ZWyY6EqQyDNTZhjBxnVgDDE603prFQxVfEgW8yBSFjfWcnN6Cri?=
 =?us-ascii?Q?xbtYrycB1+lJWwn+ce2WRHZHYysksDTCLYvLpKtL7scgcMgG/GqhRVmapihN?=
 =?us-ascii?Q?WAKlehDCXwtlYSPisIIXx6a7rcwUjZJyPs0lCK96pDqj3AeCfYI41EKnOlML?=
 =?us-ascii?Q?y4K+QJDAoFsheK4jfwCiDfeQbNSKoO4LAyxQOQisS7HUZthAt2nFseDWj1Lh?=
 =?us-ascii?Q?vCyPSFFX8uOR43A27dJK17Q0agSsEjAnGg3pPcddR/tJrzPcixU658xCXYru?=
 =?us-ascii?Q?80XzVG09t4/uXPWnPGBLOOez0l2npXHS5iW18o0vu/spwefuoyfQ1G6nl0AF?=
 =?us-ascii?Q?JGU2Abjozg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc5cfb7-6ef1-4ff5-e7c2-08dec17d8412
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:36.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3vlxNpqdOeEeiOoTuEt95g2gjzMazkGd/syyPukR2NpR3a0eadLduyBg8AquUhFKrseLaujrC7gDUA9ty8rvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294777-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7121A638BD6

This patch set adds support in dpaa2-switch for offloading upper bond
devices.

The first patch adds the necessary new APIs for the LAG configuration
while the second patch uses them, both in the prechangeupper phase and
the changeupper one. Which ports can be part of the same LAG group is
configurable at boot time, thus we use the prechangeupper callback in
order to validate that a requested configuration can be offloaded or
not.

Patches 3 and 4 are updating the logic around choosing the FDB that
should be used on a switch port. This is necessary since with the
addition of the LAG offload, we need to take into account all ports
which are under the same bridge, even though not directly.

I have considered reordering the set so that patches 3, 4 and 5 are
before the support for LAG offload (patch #2) but decided against it. On
one hand, it would help the review AI bots to have a bit more context
around the FDB setup but the disadvantage is that, at that point, there
are no priv->lag structure populated which can be used.

This set also extends the handling of FDBs and port objects so that they
are handled by the driver even on an offloaded bond device.

Changes in v3:
- Add a check in dpsw_lag_set() for cfg->num_ifs against
DPSW_MAX_LAG_IFS
- Add kerneldoc for the dpsw_lag_cfg structure.
- Fix logic in prechangeupper callback in order to not call
dpaa2_switch_prechangeupper_sanity_checks() on !info->linking
- Fixed up the logic in the dpaa2_switch_port_bond_join()'s error path
so that the FDBs are cleaned-up properly and we do not end-up with FDB's
leaked, meaning that they could have been marked as in-use but actually
no port was using it.
- Mark the port_priv->lag field as __rcu and use the proper accesors for
it. This will eventually become useful in a later patch when the lag
field will be accessed concurrently from the NAPI context and the
join/leave paths
- Access lag field through rtnl_dereference() so that we adapt to the
__rcu change.
- Check that the brport is non-NULL before calling
switchdev_bridge_port_unoffload() on it.
- Get hold on port_priv->ethsw_data only after we know the device is a
dpaa2-switch one
- Update dpaa2_switch_foreign_dev_check() so that we check if there is
any port in the same switch as dev which offloads foreign_dev in case
this is a bridge port.
- Add mutex_destroy on the per LAG fdb_lock
- Make sure that all FDB events were processed on the workqueue on the
.remove() path.
- Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
possible, even if the HW deletion would fail
- Access the port_priv->lag field only through the proper rcu accessors.
- Change the mask so that we restrict the trap only to the link local
addresses (01:80:c2:00:00:00 to 01:80:c2:00:00:0F) instead of the entire
reserved bridge block of addresses
- Link to v2: https://lore.kernel.org/all/20260512131554.952971-1-ioana.ciornei@nxp.com/

Changes in v2:
- Extend dpaa2_switch_prechangeupper_sanity_checks() with
netdev_walk_all_lower_dev() so that checks are done on all lower devices
of a bridge, even for the lowers of a bridged bond.
- Manage better the default VLAN on bond join
- Clean-up the error path in dpaa2_switch_port_bond_join()
- Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
which is also a bridged port
- Update dpaa2_switch_port_bond_leave() so that in case of any failure
the driver tries to cleanup the LAG offload configuration.
- Call switchdev_bridge_port_unoffload() in a switch port is leaving a
bridge bond device.
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
- Link to v1: https://lore.kernel.org/all/20260506151540.1242997-1-ioana.ciornei@nxp.com/

Ioana Ciornei (12):
  dpaa2-switch: add LAG configuration API
  dpaa2-switch: add support for LAG offload
  dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
  dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond
    scenarios
  dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
  dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
  dpaa2-switch: check early if an FDB entry should be added
  dpaa2-switch: consolidate unicast and multicast management
  dpaa2-switch: offload FDBs added on an upper bond device
  dpaa2-switch: offload port objects on an upper bond device
  dpaa2-switch: trap all link local reserved addresses to the CPU
  dpaa2-switch: add support for imprecise source port

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 1013 +++++++++++++++--
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |   41 +-
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   |   18 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   |   60 +
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   |   30 +
 5 files changed, 1047 insertions(+), 115 deletions(-)

-- 
2.25.1


