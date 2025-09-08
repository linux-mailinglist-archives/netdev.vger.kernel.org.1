Return-Path: <netdev+bounces-220832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6DB48FD5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597FE344E3B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC92E92D9;
	Mon,  8 Sep 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZzCh3Ysl"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC66301475
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338646; cv=fail; b=Jxd7U7sMsSooacmyG3vYuBWpO9UVGuxNaKeNk0bBywfCOCAY4HjqAvfYoeiIiXbATB+F91W9CpRH24S9bdFS+DOa3QvbkSCjsv2PM1rn7bDuMJmH4PVxjb4qxYLFzunos27CM6nRNQG4CydWqsSlujAbAGoUMKDU6O9+OEFTuzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338646; c=relaxed/simple;
	bh=yknuIistaPdGj8Hc4nlJrA1oEhm8p6/ZfA6TpZzTa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrHim6wrUQ03qwKGSy5DnSYXsDi2z8uHMQ79XfD+jWv3KqCeQETDDvL8Y8AIiEpAqdSkAsoUkK3UnIyKbUJ8wYwgXgaU40LwHLcPFg8XgdR0u1rlC3NOVMVszKB+ZAoxjzxpvvmXgGryIyW6youtPs6TB8gpxv/T4DJqXoav184=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZzCh3Ysl; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW1EyUwQ61+FfhWQYhGnTOfYLE9WW6h5Ixt077d+dxbqeiVro51TozaIQwLbwmo7bTWq7SaTr1DUTroEmC+JsCLkBNTMYT2VMHgqWQPiwZo0WswR01Cw0XHYCMEwQJhChlJq04Bpki3bMWpHEtLsKUmEO+6r/VOw4muYxT2/X7q0fXH6mMcLeWlYl5WwwMGhkWjcP28yagSnOqH/eaQJwL+1w7t3iIZaWj5MqbmmtqDVZaiPPtAxn4ZTOlc4bPEpFa3VzDUe2thTSYcO9hat3gs6IZsjRgLuMQssAm7A5glTknFBN31v8kNGJAJXANujhdLCFL7/+xjFh+dIl8d9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaVLZ4aGpP61nXA8XDfd0XcBRu2IdM3vb0GUOu88DOA=;
 b=m54OBcrgDz6O7Mc2GBWnNdX60RVAFwxj8AVGl2af8BzQT/j5ErM3jGW9RiHFIsa6F4BVNlGTfMXDQFCY8GJH5tXSXb++f1bD+mYB0f9rC17MiRJCZ2UXPBCMEdh7wmJpQ/7LKAaF+e32yzalR4egaGk6Xn6eewp2sdn6yF8pbGa8Fbd/6X1bozVxt5sHZBmDfyBFiu1wcu0w0xi9cJx5H0JZdX4O1tfHmljt/hp6b/FjkloAbQaIdBU6tvXcC/zLLZjTMpWjPVPZgJBEYI6gNZUyPFc+rhdxytO3Fr3Uc1+tOMkcKoePImuVzVH6UctqtBTOK4B8goU5P/L4ilyOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaVLZ4aGpP61nXA8XDfd0XcBRu2IdM3vb0GUOu88DOA=;
 b=ZzCh3YslHpMVw0ZYjE7iJjb4qjEv7dSHbfcbTh50+I3GzCphiOKtPlbs6DBweviR8hkQas6KWDqzeCcrIkcRuQNkjBt9wG55Q6wUwx/PVmEqtHBkvqrOtf1YxN4S1EXSp4RjGdngwIcKhJ28EGSG89Vp4xtr2A4lTUNXqgSUeTsXHSCwrfWzPM3c21Wn7fNu7JSGDpxz8SIeJZQF0CG5CrgYnXfYNTpdDuZLg4yquvF5nPDS84PuijIPEZ9Cfbt0M+Fq462riK3QRqQfOseWmS3xuDSDuZgbY2elvrvmT8pymdw6lGUUsjDVWqODgGrlCIlzbUEtPR9jZoXZYrKcaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI0PR04MB11700.eurprd04.prod.outlook.com (2603:10a6:800:2fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Mon, 8 Sep
 2025 13:37:21 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 13:37:21 +0000
Date: Mon, 8 Sep 2025 16:37:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250908133718.mjw476wpaysj6zev@skbuf>
References: <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
 <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
 <E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VI1P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::30) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI0PR04MB11700:EE_
X-MS-Office365-Filtering-Correlation-Id: d22971e9-f5ca-4cd0-ef11-08ddeedcd67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yByshLbKmONEuW13Nsyc8uchOLlyCl7bcr0xizCywpCUj2Qr00VDDN3GzaUK?=
 =?us-ascii?Q?2SXR8VOmFu2ud7sSIxPXk/PBlg7qIege0QShh3ZjM+MJynza6XMXkomn4Qam?=
 =?us-ascii?Q?yEVZOUSP0EdNZ3vEoeUq743BHoyGbOgEc5m2p9kJwSqljMz0IDq9429wPJHa?=
 =?us-ascii?Q?e+xklTKvZVuTxlBiNtTNVwF2X1C9ngXaM2/dbO6LF7PafYy2WJfmCrgYFbVX?=
 =?us-ascii?Q?tHwWZbmwPfeNdsqf2135hSN59wGZUGFIVzY7O1fEZ1RhE63C/kTfEvHSkOE6?=
 =?us-ascii?Q?2P5txlECoM5bfjiAuSfihDqmv7BKrKhjePYvAMpiTLda8lSYl4+pmMgqeeIQ?=
 =?us-ascii?Q?20AlQmOsU1jMM0LyfWlQ0+4YbTC7DO3ayaXa+Q7VougH+W8n4MgYCswupLQ9?=
 =?us-ascii?Q?ltjr/btVMlZ7YX35lvmAvg0+LGISxH0rSWJTrpCuWpeY0Xnxwj5KumUDWRj9?=
 =?us-ascii?Q?h/0BNHtPSNkJasUQHrwJMsmGLDbRQrSJrmsaRNaYe4VqIleFkrDpy5uBds/n?=
 =?us-ascii?Q?nb1xQBcwCi3hOX/LSjizEVjMN9WQo0j7ym4L6L6ChhI6ukuV9Z4fiZvqdIQB?=
 =?us-ascii?Q?RBm3dAVaNr/+W3aIqf7NXbIQe6EQresN77nXqOegbDYHj91nvKVHZr/43cHk?=
 =?us-ascii?Q?u/u0uvaLUMmFLcHldxKnY6HQ6miYpm2a7GCttovGb0gffMwlLGWXCRrElJtm?=
 =?us-ascii?Q?H4Av+BB6u7T5idlZ+h0+M2XK4OwNzms8fo5GnZ26jIjoWb6gBbXiImBNOE8l?=
 =?us-ascii?Q?TguP79FrDyKA1tduEBa3s8fbjPeL2mkAZB9zRbPOYeNaxGIC6oCRGqyJJJR/?=
 =?us-ascii?Q?V4BuG/tV1ilU8B0vpWJUykPqbpWrKb6tO73YGaBs62tfAmlzox6CneI9aGIq?=
 =?us-ascii?Q?E/EosNDlAJh1j7dulDRlBDb1QcyqeboiWq3TEIXfItZxiHmR/bBbVivY8N/R?=
 =?us-ascii?Q?En2JqLPQeuOz82h8+gRhLL3V3Yp2MRTaE7X4W508GIGbMWnpfddMoIeWwBHg?=
 =?us-ascii?Q?XbGJ7oRyBbnNyiIe9N24uH4fXT5ImlUt83XaMFhKgX6v/CcnWr2wZ22ATOZX?=
 =?us-ascii?Q?uLllJGEAk/HYw4TsLe6BGj+a1ZAoG1A5dtdirItPF5kDMdZbDrEMwzPJS0II?=
 =?us-ascii?Q?cWudPGQLGzEm+zktIpm/Y/HgczP4xz5uWVn+m2q9iZ98otgHkVengj31GW3Y?=
 =?us-ascii?Q?KdeNtc8OaKUjhE+uFqxHXRK8zyABXwvDPUwiN+vOtxqTg5NAmQqzlzCx2WaR?=
 =?us-ascii?Q?7ofBY9br8QDeJRco7TGpKQy7lGP01TJRWE+wqh9UegGSSSCAZNtUy8EQx99c?=
 =?us-ascii?Q?Vt4bcJy13Uvh7qaOX6Rq34MUlmk/JhAdMdNvX7UNy5v21iozduzA5QB3dgkj?=
 =?us-ascii?Q?jLvQTVXNCMe15NQFeKZOJLe9ZocyeFWR/61+d3ma4pmgnwH5VCzo6SrnOFIB?=
 =?us-ascii?Q?nGz+NjKCI+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tXDaneEIaipR7EAb8nBIUIZRqqCU1LUd6HyPkTfeVJXZy02b2fgxHUFcYNU?=
 =?us-ascii?Q?ShX2Oy0C33SCv1YuwKa9VDH7Dz+4TH6an+FgQtvpUWXmrYGwUsZdZxUNUx9R?=
 =?us-ascii?Q?0XNZJbmkTJOaN8Je3+D7QiV+NjIUXnmHSKm0GTsxCukiQjfVmg7AaCLmzPn1?=
 =?us-ascii?Q?tdVnNsCB8Q5ZEuHjoLaDsfSnTUC+dofHQCbjiCXL1/h23j2LeaEiI4nk7CYA?=
 =?us-ascii?Q?I4jkTf2wd9pEwiHWZS9aKBPUgsrmyHl9IoO9XhD1bJzpdXdmHmYm9//3lYhW?=
 =?us-ascii?Q?KlIsWXuMUM5MdjGmWoGg2ahULuY5/kGSTlMskQrIvZB6X/BfVBZIzPRAg9JO?=
 =?us-ascii?Q?rpQYTaiusTcVSsZgZ7j4b29ht9VROeJH+1m9eZdr+MJOYb4HGgkhXmTyh5Ef?=
 =?us-ascii?Q?UFyTYcpWjSvJ5G8sOeuGv+jQUwL33vRXX0uLffF04j8MUiVqTc96sScv61sQ?=
 =?us-ascii?Q?yAeojSjj7edgWc3StKWwObiVHloePIUZPViQYb7AW/KHRROeXcGHmeoubi8L?=
 =?us-ascii?Q?ClKx6ZGpVEBTMo/mHrCx2VzEhuOiNJbniJvogD1nDqNZMEDUrRoVGmbCVsYd?=
 =?us-ascii?Q?6p8yGqA0Abnu5szTlBkMHnkmOdHX4IPce/W/xcKnioRwwW8GLPRaIqaI5XK+?=
 =?us-ascii?Q?cWfnYYZ5nPv4Z714iVxsz0LJjVpdzLVnuKeNm+U9zb3AwBHLYIJnFq6Wh93/?=
 =?us-ascii?Q?lApr8hwI79No3+kVJS+77/AACw/32dQF5tKXf0M5PQkJpEjFQF4bplui7mjw?=
 =?us-ascii?Q?KU5pdqhxSN1p0+ofl496bABsSsqjl/Y1Dn9xINynwoqeHIMirdhGdDGthaWp?=
 =?us-ascii?Q?7OT+HKWKBNoxuh6y/mnvnU5rI7FIYY9MRF6TQvq6VtX17n4PgZWp4vHM/lUK?=
 =?us-ascii?Q?fuyK8ObiWnlNKfkpBRG2AAgZ1NvpBw65nzuPixYDX0BqAr5K5AcG9ALQtQRS?=
 =?us-ascii?Q?SPIivW7Od08zpFrVBo9fW4sJPMtQgGkvFIG/6hoGyS0SCqB8Mw1ASsxWMJNN?=
 =?us-ascii?Q?Ykdhxlq9rbu3Wy35Q7kK3RI40Elt98CMMMg2Y46t6HWT7pQUQeJn31aDb7Hl?=
 =?us-ascii?Q?pEqg6h5/X6u5aeSjrRgRfV0lNWRfnmiX5uO68695vA2nLc7dM+54hiYYB/bN?=
 =?us-ascii?Q?UNP2AH+PLqderC+sqWLaj4kRl/qm2+r6Z6uqeNVP2KdL67GZU3EpOYD6UZ0a?=
 =?us-ascii?Q?PMK7h9RQCGKhICqp5d9E3gPzPCklDrRYKp68QVkNwWUmqdfQVHj3tQcSnQU+?=
 =?us-ascii?Q?5E+c5vcLI/N7YOZqdyhfPlJrs8SIx7+psAFM4NGsoVlYZfPAxT3FVAvzITI7?=
 =?us-ascii?Q?dSv0YBnPyLbVinZY36CKT43uHB5uQq9BYY7TYSVK8dOtfK6sZz2q2y6ESwWn?=
 =?us-ascii?Q?1TJpEpMKFzKeiNH5qNnOYkajkMevc0B1Wg8m1820R+ytGlisOMfyxtGA5L6A?=
 =?us-ascii?Q?BvUOqKCxKBSY/9wSDl2zZ5UWAmO545vpHlR9V8tT4FAUExx9ovu0tUaEMwrd?=
 =?us-ascii?Q?Ju2OX6Lnruxe9/89WEDAGTsQw74BgKocwKBL7vwWoIPDJartk5WFM4fnisjI?=
 =?us-ascii?Q?cJvwgiqJ5/5bVLMyaosISj8Ebbhh9whNJvUBexXdBqEZKRCAfr9xRkHqelku?=
 =?us-ascii?Q?LKSciMC4Y2b3YuBp68PFbMKhwmFEkcB6yzp8Yu4LilWKxU8RUXpXl29WV5V7?=
 =?us-ascii?Q?CXnadw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22971e9-f5ca-4cd0-ef11-08ddeedcd67e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:37:21.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c+FKJ/AI4gWoPjYJrF3ZNSbx1zkK5USvCi+l8mwm/M/Cnr8MguT21LB2WOK1nhX2hfLwBJcInpJJQwzkkpuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11700

On Sun, Sep 07, 2025 at 09:44:01PM +0100, Russell King (Oracle) wrote:
> The blamed commit changed the conditions which phylib uses to stop
> and start the state machine in the suspend and resume paths, and
> while improving it, has caused two issues.
> 
> The original code used this test:
> 
> 	phydev->attached_dev && phydev->adjust_link
> 
> and if true, the paths would handle the PHY state machine. This test
> evaluates true for normal drivers that are using phylib directly
> while the PHY is attached to the network device, but false in all
> other cases, which include the following cases:
> 
> - when the PHY has never been attached to a network device.
> - when the PHY has been detached from a network device (as phy_detach()
>    sets phydev->attached_dev to NULL, phy_disconnect() calls
>    phy_detach() and additionally sets phydev->adjust_link NULL.)
> - when phylink is using the driver (as phydev->adjust_link is NULL.)
> 
> Only the third case was incorrect, and the blamed commit attempted to
> fix this by changing this test to (simplified for brevity, see
> phy_uses_state_machine()):
> 
> 	phydev->phy_link_change == phy_link_change ?
> 		phydev->attached_dev && phydev->adjust_link : true
> 
> However, this also incorrectly evaluates true in the first two cases.
> 
> Fix the first case by ensuring that phy_uses_state_machine() returns
> false when phydev->phy_link_change is NULL.
> 
> Fix the second case by ensuring that phydev->phy_link_change is set to
> NULL when phy_detach() is called.
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
> Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> v2: updated commit description

..and made an addition to phy_detach() which fixes the second case.

> 
>  drivers/net/phy/phy_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

