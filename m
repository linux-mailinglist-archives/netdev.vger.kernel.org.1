Return-Path: <netdev+bounces-271244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB2GMfvcwmkqnAQAu9opvQ
	(envelope-from <netdev+bounces-271244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:50:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C531B11A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 874CB301AFE3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D940FD92;
	Tue, 24 Mar 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPSRgCua"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694040F8CF;
	Tue, 24 Mar 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378196; cv=fail; b=GvPTFnmMdSogXSfnayM4vrcdwap1O724ORKzs6eIbjik8oB7zW1sUu7IIPS6d7OgUHUf+p4EnnugLeg7gYQSvr1iwx+jYfrdH7SU3kTal1NnoMBs5xGBo0Ml8poqOACgeyXkBfvG19RD8O207IpjB7SBvHGeQ49BpNNHSV9C16Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378196; c=relaxed/simple;
	bh=yoA2L75k1TjR5Ot6GbS4b+3GRetoLkh4FPQ6M48n2VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rf39GZFPk8VK4iAMZddIWcbJ5eH8AjFIR/3WOBmZXCIzUyAbM4EqhcE7qEuaSKQis+JinFDjs2GXe1B7LYs9NxRqivUAKVRHPnxvMasgxYoSK+JeQm+KAEmvOAXgX3OQz/g0ng2X5DUgrmRzev66XwIfp6Z1wb6LjMq7Ha06Hn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPSRgCua; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUwe8VmTcHMTGzyxYRiA1MD/KRsXO7hGa4uXdCdsOPQQ3REpwn6Aeco3KoLrLye3qaMQzxdhuy8yA4SEDgNJ58ZUIuPOWvEkPTGttQAnycqPltlNCWS7c1pqG+MkdzaXMDj1BwNX1iQ0ECiCh3rlJYGHDW9RJZDTMSBDPaCegLRAqpfJqGTKYi9fEnBBRaWr58LTHc8poHu2IHH95D3TZRKM8OWf4oc84VypNoqXmrKYHSwMg9rYzO1rZlVqFAuNWwj99SdgVw2wtfbBSK34RVyA1hFEfPiOhWe/aTyLmqvVTaKyJWM4eCZy5LGv3J8oNuoOBfsbefgTPmR3MAqWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFB+nVJO1D4CyNvSW6mpvTf0hPdsRYkxgD8QJuGB6NQ=;
 b=E/gEMl6eBD4znYXB0pcHi5l9SqNdXJMUgFIYKXIOtT31WDNf244/0lvLJY7E1JXKWOLTw3vfPw7tP0dvOjd+ALk1LBCOwc2bT9pXYrZUVIf86PZHvx+JQgyGx6hZia88AlQ7mpytw5KILaPTx8KwWs2u+0yt7xutjpYLYorMVom/AE9Yi5Ofyn4DNfqL8bXLhgW+d6j8Jz/Tls78us7w5Z2KjUTfLDM6xblkpI/SDtBKricZ6PHgBdMVcs9xzF0YbPXXsYIw0Zd6FDgNwV41X9/SoKL2+LgI2ltYCnjDxcKWFEEiTSUhcWFa7bEKbSX5cEz2PlnU50CXDHAobRUWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFB+nVJO1D4CyNvSW6mpvTf0hPdsRYkxgD8QJuGB6NQ=;
 b=uPSRgCuazRX3MIZEjI4e0Yoc7x9ThmsPiQK5r8gjapLvXovE8CpVTlNcerHYIY6Q2AjLZkauRBuC1ZJV6TR31Z6mSI95Ewf0dDDGftta1dEbWWz9rfb3ML0sehgXNlTRggi5f32BxEmA1AyTCkhxz4+/jN5J4jnEINxrEjzO7cvPa8fWlXWhxULaY7yM3eMNIw5+6rjhnWiAfc7iEcT44GDba+NMSY8HDW8YwzyBQM4q36L9VfOux3ZdIALDJ0F00my1YlMPWwOPrKR5uAvKaLs6DE0LAzrhqRoX0luLgJs/rYfTrofIL3f9VTYX9aLPDSRHl6GUMCjKyi240DUBMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 24 Mar 2026 18:49:46 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:49:46 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next 1/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Tue, 24 Mar 2026 11:49:40 -0700
Message-ID: <20260324184942.2828691-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324184942.2828691-1-aroulin@nvidia.com>
References: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bf6c16-a754-4fb0-1505-08de89d61de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	csOiNLJznZN0KTl3hQmdrtd1fUIYgiVAeMKZmuteq0hPoQsBHu7Dy5SauOXLsPREmJwcCfKjjnPC6DUrcuY6e7ELMG9YC7O7VM4LfPUX7JZOUbzXc9zoMkQEsv/Hgfs/6EQoTEEZpkNWCJnKXoUHPZPgZQpY9Q5mwGFpMzbYDpDeHdtiGgr6oKymldPzfKhDPqEzW+QSvNxcVdwKkB0u1voTq8eV8prwzRKTtUQsT4VWyua4xZ1dTfwyhOCnIO/dz6l1oPXbSfEPbBwmytPocsbx4K8HicesHhV7A0FG5bzZs3bUrMWV2Cjx+xMEzSGwtFlE9+v2ukoa/zTwdYbgtZEnWAyTyWp9DHzG1ZHVXioivJgJg9yHQY4ADcNY1bNFDt8S80ceFQcupi0XcVBayFQXfl9pDnM47WlIIbGCv6UmkIR9fRNsKoKemjy2t/682a5+3Gdne1oci0Iii2p06yNjdKUlw0ol+JYw0Oojgc5VM9j+m5cmo+9SpHzwFTOFVWdtOMU4mjo24movsZQA3UXRLjQv8+c5kDhrc3iigFmMXLJ0ha0e+/+8L3jlJ8M2UfSXO0BxBdER86VfT4U5Z5j6cEQxoYFdVMkjOQd7dUbWXjegQrxSc0o+/s1/Pg6+ItELXsWJyWdtVE1+FRHXTKBu1ENWiiEjkcld4Q4ygB/h5q773DBefIER+SbIWK5B8xadZb+bEYBiSgm5r0ryna8cegjdgwr2/9gdTrAZ95k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003)(18092099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8Dpe7eYHlCQS9VtDyszzEWYH1Qi91UVB65TemuXs+Ctb6kn9xsTP9cO7wjg?=
 =?us-ascii?Q?7FXQ2y1acqDc6eZED6yWMkrirAFFflQPQf64N9umh026qHGGO3FlPhuM1sk/?=
 =?us-ascii?Q?QswkUukA8IEoKKCP+94++rXblfdJQaHrFG6d7QknHAqdkS4LPx8h2C/bWdSG?=
 =?us-ascii?Q?qQSpYSoisc3sC4j3Q2nyBpdfY8qLyWIlWfWzE1BzKFGAfQ2cSqgttHGLGi3k?=
 =?us-ascii?Q?2i4tK36DD6XOFY1Yf70ndPc2fT9QI174yjOvIZ8MKHsvRGKlLxppix1hNNwu?=
 =?us-ascii?Q?A35+XUK7qxI0fwKTIcBk7UWuSbcPWB1avq0mlmOK57rhURHV/KCJLWEgvduG?=
 =?us-ascii?Q?6aP7g2npUaa7amqCR+CPbeIivwJpmhQp9WuqZvWdxva50cLBD+/Cbx/eZhyq?=
 =?us-ascii?Q?qDul01Fn7cdYu0Xk8upWv7QffUuruscBNUJJtDSooORpPm9AlJ5yrPRFREfF?=
 =?us-ascii?Q?+XngV/ciR2qxIHua4nlVe0UM29KMaHe8dgLPjrPfuxm8I+SI/wYcphUUe06Y?=
 =?us-ascii?Q?CeLD3goilf2cOk1BXGvNjSGT6OibiBWYEQcVSXP0SJueyVTgN4PcO1UJcmNN?=
 =?us-ascii?Q?hNcHdP3x+baYQKsL0k6sfakexm/FWthmnuc0DVvdVOsGV64aL+wSKe6ejzu2?=
 =?us-ascii?Q?iislQfCK9R2mkKKuCDvxuqwbs8ttve0R+I4r5RI4TT3NeNngs6+IJgVQDvUE?=
 =?us-ascii?Q?X0kZuVKnln/9cGbRf8yZE2KMC6pdti6ZY8oUbwUxBRDXlpdvGyuQDvxUFaA9?=
 =?us-ascii?Q?9LsD4qpc22fgLArz2bXGll+I8LCxchwKMFaAy2jT0tAY8tK5R+aiNLng/xo5?=
 =?us-ascii?Q?5o0u1THvpXymYuXXKtG/dh6k/B9VkbNBo9AuI7Yx0jNWGATHDFcoEsGAgXr4?=
 =?us-ascii?Q?DoleWBNwjC004q4pQcw7QCo7jrCl4lUY2ecTjp17u1ELXokORl+X4XaC5nFF?=
 =?us-ascii?Q?pPJ95WyVLt+Z5Ty8QZ+eZxpKhHqHixTMAVSNsiTQZR6H8ajo8LYlz7M6EQjQ?=
 =?us-ascii?Q?e+4u+LZDxoQwcGjg8QVmOOzQphDMAG4Z1dHldf9yL/U+eAwUUMEvTX3N6dP3?=
 =?us-ascii?Q?P3/r/Q+jz9JCRZkbqNIbail+kES787AW+4iLeAXe1r3pTl/7KXuIxHSyXnqg?=
 =?us-ascii?Q?ZtLl2c387p9BWImMf77If0hSt8K+dx/CVVnwlTGzwWiCWYT60wziMeRpR5NV?=
 =?us-ascii?Q?0RvuWuzr4y46G2KAUGBNo19aMyJ48q1IS015VD+s5oSX/fjNtvJGNoIIflrT?=
 =?us-ascii?Q?onqN70NCvlFcJeTD5aaWfA1coQqXZr0CsopIUxLeXNKl0YC3fWZ3C0kxW55B?=
 =?us-ascii?Q?UU+gMOilfHpJwY8UXyhEZBFGuHQ3Tm9+wVis+/y2rt0//Yxw+9iB9xSJsV05?=
 =?us-ascii?Q?KqoRtSOMLVDkAsXH7cIT+i1kOqz7FyRO7fgScywRglvWQvIyEHXc++lDOU9m?=
 =?us-ascii?Q?JuG3RmSur4HHE/QsaPsYMAmZ69DZCA3t3Y+GuFuPERBOAhZBCCPgbfE1FrVB?=
 =?us-ascii?Q?tOoVjbBpOIykzhxtU0KxcICM7HzyPwVZe/njf0WPXQhRiPr/TDRCBJ3QRxK4?=
 =?us-ascii?Q?oiMuIjpxaE+P2PNlXB4eEOkUajkr5rl0zW0/Rpm0PhfVfbn2jpyX8QCxPTcN?=
 =?us-ascii?Q?h6Ryc/u8X0XdOrYmuJo3KEMn+qi1rNxfyE+rEdHB2ti+BK5MasCpQYlxbz+w?=
 =?us-ascii?Q?jFpEMxzvCq/2zv1uTvfmqVUU63rQ9pkmK9FR2JWmd3aYwXv3qrnRCiNgznFX?=
 =?us-ascii?Q?7p3UmxcBiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bf6c16-a754-4fb0-1505-08de89d61de4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:49:45.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4w0rxL5eeo7TDF2oN6PecQeysgtg8LL+DHluUJ+NaSr7E7NRtrfXBGSCotc35LzsomKnrowPo8PaDtEwqP/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271244-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 1C0C531B11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons (e.g. mstpd) from
operating on bridges in other network namespaces. Since commit
ff62198553e4 ("bridge: Only call /sbin/bridge-stp for the initial
network namespace"), bridges in non-init namespaces silently fall back
to kernel STP with no way to use userspace STP.

Add a new bridge attribute IFLA_BR_STP_MODE that allows explicit
per-bridge control over STP mode selection:

  BR_STP_MODE_AUTO (default) - Existing behavior: invoke the
    /sbin/bridge-stp helper in init_net only; fall back to kernel STP
    if it fails or in non-init namespaces.

  BR_STP_MODE_USER - Directly enable userspace STP (BR_USER_STP)
    without invoking the helper. Works in any network namespace. The
    caller is responsible for registering the bridge with the STP
    daemon after enabling STP.

  BR_STP_MODE_KERNEL - Directly enable kernel STP (BR_KERNEL_STP)
    without invoking the helper.

The mode can only be changed while STP is disabled (-EBUSY otherwise).
IFLA_BR_STP_MODE is processed before IFLA_BR_STP_STATE in
br_changelink(), so both can be set atomically in a single netlink
message.

This eliminates the need for call_usermodehelper() in user/kernel
modes, addressing the security concerns discussed in the thread at
https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/ and providing
a cleaner alternative to extending the helper into namespaces.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 include/uapi/linux/if_link.h | 40 ++++++++++++++++++++++++++++++++++++
 net/bridge/br_device.c       |  1 +
 net/bridge/br_netlink.c      | 18 +++++++++++++++-
 net/bridge/br_private.h      |  1 +
 net/bridge/br_stp_if.c       | 17 ++++++++-------
 5 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 83a96c56b8cad..87b2b671ec182 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -744,6 +744,11 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_FDB_MAX_LEARNED
  *   Set the number of max dynamically learned FDB entries for the current
  *   bridge.
+ *
+ * @IFLA_BR_STP_MODE
+ *   Set the STP mode for the bridge, which controls how the bridge
+ *   selects between userspace and kernel STP. The valid values are
+ *   documented below in the ``BR_STP_MODE_*`` constants.
  */
 enum {
 	IFLA_BR_UNSPEC,
@@ -796,11 +801,46 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_STP_MODE,
 	__IFLA_BR_MAX,
 };
 
 #define IFLA_BR_MAX	(__IFLA_BR_MAX - 1)
 
+/**
+ * DOC: Bridge STP mode values
+ *
+ * @BR_STP_MODE_AUTO
+ *   Default. The kernel invokes the ``/sbin/bridge-stp`` helper to hand
+ *   the bridge to a userspace STP daemon (e.g. mstpd). Only attempted in
+ *   the initial network namespace; in other namespaces this falls back to
+ *   kernel STP.
+ *
+ * @BR_STP_MODE_USER
+ *   Directly enable userspace STP (``BR_USER_STP``) without invoking the
+ *   ``/sbin/bridge-stp`` helper. Works in any network namespace. The
+ *   caller is responsible for registering the bridge with the userspace
+ *   STP daemon after enabling STP, and for deregistering it before
+ *   disabling STP.
+ *
+ * @BR_STP_MODE_KERNEL
+ *   Directly enable kernel STP (``BR_KERNEL_STP``) without invoking the
+ *   helper.
+ *
+ * The mode controls how the bridge selects between userspace and kernel
+ * STP when STP is enabled via ``IFLA_BR_STP_STATE``. It can only be
+ * changed while STP is disabled (``IFLA_BR_STP_STATE`` == 0), returns
+ * ``-EBUSY`` otherwise. The default value is ``BR_STP_MODE_AUTO``.
+ */
+enum {
+	BR_STP_MODE_AUTO,
+	BR_STP_MODE_USER,
+	BR_STP_MODE_KERNEL,
+	__BR_STP_MODE_MAX
+};
+
+#define BR_STP_MODE_MAX (__BR_STP_MODE_MAX - 1)
+
 struct ifla_bridge_id {
 	__u8	prio[2];
 	__u8	addr[6]; /* ETH_ALEN */
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd357..a35ceae0a6f2c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -518,6 +518,7 @@ void br_dev_setup(struct net_device *dev)
 	ether_addr_copy(br->group_addr, eth_stp_addr);
 
 	br->stp_enabled = BR_NO_STP;
+	br->stp_mode = BR_STP_MODE_AUTO;
 	br->group_fwd_mask = BR_GROUPFWD_DEFAULT;
 	br->group_fwd_mask_required = BR_GROUPFWD_DEFAULT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0264730938f4b..4c607d5d17a49 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1270,6 +1270,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
 	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_REJECT },
 	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
+	[IFLA_BR_STP_MODE] = NLA_POLICY_RANGE(NLA_U32,
+					      BR_STP_MODE_AUTO,
+					      BR_STP_MODE_MAX),
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1306,6 +1309,17 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_STP_MODE]) {
+		u32 mode = nla_get_u32(data[IFLA_BR_STP_MODE]);
+
+		if (br->stp_enabled != BR_NO_STP) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can't change STP mode while STP is enabled");
+			return -EBUSY;
+		}
+		br->stp_mode = mode;
+	}
+
 	if (data[IFLA_BR_STP_STATE]) {
 		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
 
@@ -1634,6 +1648,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_ARPTABLES */
 #endif
 	       nla_total_size(sizeof(struct br_boolopt_multi)) + /* IFLA_BR_MULTI_BOOLOPT */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_MODE */
 	       0;
 }
 
@@ -1686,7 +1701,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
 	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
 			atomic_read(&br->fdb_n_learned)) ||
-	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
+	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned) ||
+	    nla_put_u32(skb, IFLA_BR_STP_MODE, br->stp_mode))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6dbca845e625d..e4bb9c3f28726 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -540,6 +540,7 @@ struct net_bridge {
 		BR_KERNEL_STP,		/* old STP in kernel */
 		BR_USER_STP,		/* new RSTP in userspace */
 	} stp_enabled;
+	u32				stp_mode;
 
 	struct net_bridge_mcast		multicast_ctx;
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index cc4b27ff1b088..fa2271c5d84fe 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -149,7 +149,9 @@ static void br_stp_start(struct net_bridge *br)
 {
 	int err = -ENOENT;
 
-	if (net_eq(dev_net(br->dev), &init_net))
+	/* AUTO mode: try bridge-stp helper in init_net only */
+	if (br->stp_mode == BR_STP_MODE_AUTO &&
+	    net_eq(dev_net(br->dev), &init_net))
 		err = br_stp_call_user(br, "start");
 
 	if (err && err != -ENOENT)
@@ -162,7 +164,7 @@ static void br_stp_start(struct net_bridge *br)
 	else if (br->bridge_forward_delay > BR_MAX_FORWARD_DELAY)
 		__br_set_forward_delay(br, BR_MAX_FORWARD_DELAY);
 
-	if (!err) {
+	if (br->stp_mode == BR_STP_MODE_USER || !err) {
 		br->stp_enabled = BR_USER_STP;
 		br_debug(br, "userspace STP started\n");
 	} else {
@@ -180,12 +182,13 @@ static void br_stp_start(struct net_bridge *br)
 
 static void br_stp_stop(struct net_bridge *br)
 {
-	int err;
-
 	if (br->stp_enabled == BR_USER_STP) {
-		err = br_stp_call_user(br, "stop");
-		if (err)
-			br_err(br, "failed to stop userspace STP (%d)\n", err);
+		if (br->stp_mode == BR_STP_MODE_AUTO) {
+			int err = br_stp_call_user(br, "stop");
+
+			if (err)
+				br_err(br, "failed to stop userspace STP (%d)\n", err);
+		}
 
 		/* To start timers on any ports left in blocking */
 		spin_lock_bh(&br->lock);
-- 
2.43.0


