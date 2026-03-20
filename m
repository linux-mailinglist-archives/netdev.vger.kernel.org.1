Return-Path: <netdev+bounces-269897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLmyOMMwvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:34:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1B2D9A57
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059A93148C40
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58593A8722;
	Fri, 20 Mar 2026 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtzAN+K6"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7113A9D95;
	Fri, 20 Mar 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006309; cv=fail; b=SXN7bnG34+nACQ7x3ZiJNZR7a00RDS26FXc6owkrtckybQTu4nMHzM9z2OG9LJFUmpavpUCkdBqWIz2XvGcvKUoLnnU2z65aT1Itc5/3Gnu0t79aHTZxtUrBS2YpQ7pa3oWFk+STIVLa3Zb/aOBg/lrDoubGGNDWtCjIXXEZaGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006309; c=relaxed/simple;
	bh=pzZBsHqjTB7AZYX77IosmVYZVJKaq74BG6T3vacDDjw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c8L4q0zAqxH5Ti40rFgnyX4JMg72uUndUnAFZQt8zCyzK4s2eAgKirtaBHM4JnlguYzvN3iMez5SSM+hBaXr1p15ecYffeLxdZePmy75UEnIVpDVTpqZS5RGqo0JCXxlZDZdBBkGRXc2/bfN0gNexC4JhqLiIZ7Lp1KaGQBYN/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtzAN+K6; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5wjhzDS3ynS1ob6fkS8EpSNWwB5oqiob2CErB0JWkJBAoGQFDO5+Rq4SrPoYs0qJCikysM3T0FTa9jASPqGBAtnV5GnUfxhif+OonQHMwheH+iDXaDTHScdWptfME8l2PZ5iSFSqs0yh/4QEHMeVBu85+zC+eH8Q16i1bz5XCgJqt4709nDQnEkz+CmwQr28SajFgRp34r0hb+4dUjCQE61RR6Xg92Py2PlcujNtGgCvlsIkZKLQUJ/p1Wls1Gu6qkxP6iYKB8xPhuBNX7zxxH3ZiqI5LmUiy1x++N9oauRh+CFDuZRvmoR4xN7Pv9Ljclu9Tgvtf4TNfbwBz2dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzZBsHqjTB7AZYX77IosmVYZVJKaq74BG6T3vacDDjw=;
 b=ICpMkWuFdse4/lZUDzR2Hmih2OvKSLq337Ki23SA8U/SwprEZrxcJJ7QYDfLJ6kgphCd1l0n4n1C3hgMWs+xRxwCu7bdVLuso8i3ICfyesJZMowR7jCdTnlaSFW+8wLIlllQAzPllYjuigEYVUH6yET7OrMpcinufohdnRuxR7IjMKWya8uqEXoHzWlXoun+4ZEcAczyoAbVcYuxnS3omNSyXVuCZUZH2QH0rlBL920GNf9ZFR3BW4FnqXi6GkepQiBTJjY5u60R0fbOwftDDa+2h5Vq73gdcWUs7Ja9Amq4zmbB1NTqMx8a0jrgsvLwcE2TCcIsudVAESsIaAnzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzZBsHqjTB7AZYX77IosmVYZVJKaq74BG6T3vacDDjw=;
 b=DtzAN+K6wTrBzfZfSBSDD7G88DMo52wps4Kq5iO59++wRcCzO+xAug/PdbNQsnZC9utTSz9jVp/y0yCUuAkMhcPl/PU5tnjBQgNXgj1yD8DwvFzOtEfJayM00oHqKM5K6IujQCFgG4uaKjUhIUa9unHPfPbASbDxOfH3l+leTKKzdsiVDJUdLXEt7z1IWajSVTWU8UF+NcSPBuqPtUarD5SqW0qVxmZedvejAH/HGMNYLpHwBdqv1EV1P63rfvzlSb3nn7EcozuzAKlXpBU9aSOxMfOwclPedB/y11tRZFeuIUktVD71ulwRmTcUM1jHZZ0trPycUBzqbl0QiQ4JIw==
Received: from SA9PR13CA0166.namprd13.prod.outlook.com (2603:10b6:806:28::21)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 11:31:42 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::e5) by SA9PR13CA0166.outlook.office365.com
 (2603:10b6:806:28::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 11:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:31:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:31:29 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:31:24 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-7-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 6/9] selftests: drivers: hw: test rmon
 counters only on first interface
Date: Fri, 20 Mar 2026 12:31:02 +0100
In-Reply-To: <20260319160410.2515105-7-ioana.ciornei@nxp.com>
Message-ID: <87cy0y91q1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: faa47de6-52c4-4f60-0089-08de867442d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xJBM1AXtm9bl1nVAXIFTjlF2fhs8jwHrtBClnrawqhN2esekPAuhkS7w2fQoU26kbXOnM1Jzb6cksXfSvGeX70CWVSnGDtmxnfwe6TJj30ww6ycAcoWARzObDr6eoR3Fj/T/D8DwoU/BdStuAADnbcuizEWTgiyKeTm/CMf7jWgB38bD1WADs4ZA5KL+ombQryiqGhw8rVHkKdU7jEtjLVouh+smT3yIV30hz6S1iqbmH5BwZwKIUsw10aKzjr/M1X3dkpgX0jIJt0QWO3XiMUKe+l1uOB2QElu2zzj3YMdWY7/Ndce45uREWRB6387WlYcE0PgVdGbKUwLOIR82uhD6YA4rsbXO+2Rx5MPC9Iqjk51So9MHLQiL/6M6HtuhcK8hZoKnbbOrqW2YYe2ySvH+pLv41JVMMCOivQofGNifSJDM8cJMmHigtf9HIC2jdbKWflZm6xXBEfHXXbsKsF4OzLvFVNj0NV+ijsGrqKK/3Mofmv9fRQcEaC+UziXEpUzR1wORupyt2hebgtiaJVCAdVvHRWfIrGap6PEhI5nhrVbuvZAdtyHcmByPoouNQ9PoTQ1vJKIp7Q+4zc5+TbYJB1ArNGnMNllhlfiu2OwxyXGzrbIVamqY9H5lfRyt9UQ0UaMDR1Q0nzp6vae7/i9MEETPbiddKIQGIEYkmHO2waaWFwK8hm8mp+wsKy/EO5ifxoGSMpwcz3S2VSSZ1MpX6byFbi9C8g+5ulZi2GdcVK5nFtNTH3XMxPn/Rvzum2V467QdI005+H6l/B4icA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qwv7QvnZz1Bv9BZsgBN8P0wsKgKJD36EnBGwOr9UBzyjhePt0Le5IdTUjOJsqEguYPL0sLZ1chc8UbN8AZ6c7OTyjD6Idq2nlDCThX0i0RTKrDbA1bfXQYa/3FC55Hk3hbmGwtNnCzvn6AV7S7ZX9/EV+/rwFRag8EqPMx29ukX0trML0YVrO3Cc0c1bOq6twW4rVjVY49XbSiHBD5sv5CuumQWMEndYUQIoVTUxI/u8iAbzo5fGxOeI05VqkpBTINAL4QOISvWSEtGPiRCatzH7xjE35dCws1QfMoKN86inFFKkarUB/lO3xCNGW5+9uIsgifL80Id9bPNDp6uUimGVLZFLFHjdJNi8DIkqn8G1ExxAXe/h5NWxkZ/kFaLgHlLQoFrlOOzQG2c4IYK6HGgyDhogiLi3s/7231G/wwvuFic/AJAo6lkcDb3386Jh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:31:42.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa47de6-52c4-4f60-0089-08de867442d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269897-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6CC1B2D9A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> The selftests in drivers/net are slowly transitioning to being able to
> be used on systems with a single network interface. The first step for the
> ethtool_rmon.sh test is to only validate that the rmon counters are
> properly exported on the first interface supplied as an argument.
>
> Remove the rmon_histogram calls which intend to test also the rmon
> counters on the 2nd interface. This also removes the need for the remote
> system, which should be used only to inject traffic, to also support
> rmon counters.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

