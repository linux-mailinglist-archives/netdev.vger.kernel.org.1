Return-Path: <netdev+bounces-252249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BVSAtLrcWl6ZAAAu9opvQ
	(envelope-from <netdev+bounces-252249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4490646D0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C95B760390B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E44355042;
	Thu, 22 Jan 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvO/BzVk"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130632ABCD
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072961; cv=fail; b=NIdY0Hvzi+45avOelUWaT777ZYLRvZS0lKcaRo6hEnCgaE1jQF4y41FcNO0qU71Y222ee5bvk8H+9/79o5XjdDii1eiOCsD1T7xEJmXvqQxg8oXG/ed/tfBd74PkScv0uAFXNDANbQhcWWcgbHlVb8sa/Q+paVMOvToG54h60gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072961; c=relaxed/simple;
	bh=d1/XwQTDsXMsUfm3Gs36MTmnWkqxnc/d70EX9UcBtz8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kQKf9gLCIqGxzdgtxqU2INujwDE/UScxY7uTsA+DqnaYtVjKbmcpL0Lir/XGdLoqU47GI4hiA/pLsO6lQ5zKT31e3QYtksOpuw6v4maelnxVCidxEsMiN17Z1ER49ONEt5YDm+ILWYuZsu/LrVFUaBmPyHL5yXG07cCOUgR5jyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvO/BzVk; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+pHMhXM4JAsacvSCoJkmsWyvT7g3cdzpUIrdUXRRjJUqUByE7IAhK7CmUdFq1Prp8OFgYqt8aFJ8RaQCzII1JELxM/IP1YwRuqqsdEqw3xUvYFySsMI9/+/QnjrSSfxI0lJa4+XI0I2Ls2iku/FoSfMh9gYykebxtSTJFAmEU2uQStAHvGIVdmdZ06K7glELTCFZraAeTJVot0RkSMd8vb5+Jkr8VBOyntSz0OHR4iw/4u62kuPB4xmkS96MBBMFFHGWmnwoKYmRZYO2vQH6mqR5qvJJCJVrl91bXG0+Ks/EECNVAw9Ucig7v/xc7uh8l+SPLjZVkwc7AZzw/bYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1/XwQTDsXMsUfm3Gs36MTmnWkqxnc/d70EX9UcBtz8=;
 b=fbVvE0S+PqwlbBvTKaBEJx0vePMqGaodRKaaSRrgJ6OAXjofwaxruQK8g1LaK2GhanwLo2kSe2G+yqGBK1RLEjw+0QYrLSgTb88ZowE2uFE9oscsYKfaqmdMJZ0rsYCvPb4aiV2BDYs1qPpVpXggzst3gl4QhmmtpP+mIJWEq1ipM8LzvPM+fxXg0bdf/cwSN5Wm5EPTDhNi5Y61HpHJktYu8QwKGZmjCqgW9GEt45MNq53nbbK6kJeJn1Jxr2K+ogKmPlC7SxAEZLP4duH8BIFXlmmHsvsC9tPIktCzrt0ZF91VHrs0b3q8tL+/jU+b722Imf7mTjCj0YVjKfaZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1/XwQTDsXMsUfm3Gs36MTmnWkqxnc/d70EX9UcBtz8=;
 b=nvO/BzVk0DBjOEzFE4cLgy9bP8TuuVWWKCr7TU5JQ/AHYbEzPhahv9YLmUvI5Hpwp82HK/BwTc7dv9DX+26y3S5Fgoa2+z2D+e8PeJbINFngIAL370mA/pfhDXCl0W40IlMEs51J9oOzI/klG0/UPQThMX0/vldcLyLenfZn1ITcXPm84B8B6C33heUf6fX8/557i60cRg1ARiTFSxgnVVQgWKymE9Bkqudv0tDgztybN8YR58am3CY3Ml1oj+6x3rTpeOY90fCoGTKTiggkOkzMxUSljep91SEaQwsQ92aoIv1IDkB2ls97kpRs992iwcFR8Uzxkoa8y4cwYmW2Tw==
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 09:09:15 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::2a) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.7 via Frontend Transport; Thu,
 22 Jan 2026 09:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 09:09:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 01:08:40 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 01:08:33 -0800
References: <cover.1769011015.git.pabeni@redhat.com>
 <61f2c98ba0f73057c2d6f6cb62eb807abd90bf6b.1769011015.git.pabeni@redhat.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, <sdf@fomichev.me>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <idosch@nvidia.com>
Subject: Re: [PATCH v5 net-next 10/10] selftests: net: tests for add double
 tunneling GRO/GSO
Date: Thu, 22 Jan 2026 11:05:13 +0100
In-Reply-To: <61f2c98ba0f73057c2d6f6cb62eb807abd90bf6b.1769011015.git.pabeni@redhat.com>
Message-ID: <87fr7yezcv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: cb454f27-208e-45e8-ab92-08de5995ea5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q9XXw19yM8ci+JJZ9gbbG1IaXgD96HWhfQHmcSJxRMo/WXVgBrZnFLYsxPjS?=
 =?us-ascii?Q?wRm7QB6RCVaHkhfhLYA+IELaHJbw/oC2ULw7oBQJAOWRccJGHLAGy+WfNNy8?=
 =?us-ascii?Q?y7P9WNlDikXDdIZeM2kFhZSvW11QL4muQ2weN4iexzCsNoMefDwSTWbyDU8m?=
 =?us-ascii?Q?liaA9yfTAAzRN/zXqCArlO1J3+xhMMRoeSffmNaC4v5uhm9r9d9vVB1bp6Kv?=
 =?us-ascii?Q?IS1KyLUzbqd+1uZ/YPjx1ltHrpWCp0cVYw8f/RdOcCtMEbWUrcZvGNw9Cfks?=
 =?us-ascii?Q?RRYyXvaisRe7Lw7YSpNxefw8goICe5JPeOgklNm6eAVhzipo54wB6HNXvECh?=
 =?us-ascii?Q?fBS/ZBYPn9QEgf/yNmvp4cD3ai2M1zfpgtSaR7d8+srAOaryyyAPtfPdIi33?=
 =?us-ascii?Q?76aLG4AGKF2/hgL3qBfchUG1PDHQapgeuprx1/1TgI+E1zdtByyCjVZqqxKH?=
 =?us-ascii?Q?cjuHIAYXlN1uhQgpkz+XGPk20IHnssvmUTRi+gTTMt1qTZvTE+PletX0YKAP?=
 =?us-ascii?Q?9LooLoxfHQnnbvEKQWWRHreevn3GJQzSi/pb/Jfsie6SLapvz/lhIuEQhohC?=
 =?us-ascii?Q?fpAayiamJBPbdYDjxN2fr/3niqeH3mG9N/0pueGYUUpbHyM2IeKiGcjUvnNI?=
 =?us-ascii?Q?9tpy1Mvlhtdt/Cre0kLSJMJH4WTcWqAWobiX1+TWmFy1MU4pO7kT7HGa3kk3?=
 =?us-ascii?Q?AXcj+pv1HCDt1bRcvEXM0ac+CEq49XRUGnmGKbbEdH5xgHEQv+v2Ld14kTW/?=
 =?us-ascii?Q?C8h75tYW31Y1Q3Z7hatT2/s0Y9ubaNdw3n5oT4NkMn6V7ZLVZhLewK075Xr6?=
 =?us-ascii?Q?Qb3pdbQlDpH0qZdYtdBbMrroy0XQ6NVrtDGeOzlipTM60+7Iz78CO8cchWO0?=
 =?us-ascii?Q?i/adwdFTjPb7TYW1q0NMsV1NfwjNmbBzZSy9PX/ITvfvDIxpga/49bjuIZ5G?=
 =?us-ascii?Q?LVNqz0SZG9PHsE9XUW9oNvzHijdijmsIbOkRDrQtieOzNAUFqmZdoT1RXmFQ?=
 =?us-ascii?Q?0hrsDUjrjB6xcf+5yciQvzRfM9uMaQNLMZAzeiRVBz91F8LU6hroHXtm+oaq?=
 =?us-ascii?Q?nRWLRHxbKffCvZvD4WFAlebZkm9uBWZgztWYn4xWxU1of11aqwCYY68d6ztB?=
 =?us-ascii?Q?jKckTmWv64ndwl9/wBs3IVMdyo5m+F8r+4geaVAbO++HCm41DZ1Cw9Pz/xJh?=
 =?us-ascii?Q?TXDYtufkym06PciOTyre51KtoJwisB5ClgBnHRNUVWW+p2mGxXeuM37czh7A?=
 =?us-ascii?Q?qb/XSMomi2EUYRDmP24xqbQ8/KRFn88zfXI9Vf8ohedzQu3hZlC7YapQhZE6?=
 =?us-ascii?Q?mY9njW7pPICmMsKg+gxbJ/4yyg18OXJxC74R4FzMLcI/rlEuNcDxMV114IGj?=
 =?us-ascii?Q?v6BWbc2853b/UicvntEX0td+T2B2HFSB6ihe3ZtKqC0RYpHnRN7jZMEzDP2s?=
 =?us-ascii?Q?qFcQs+TZ8E6uV6LqRYXLxTZr0XJH8/YerU4SGkMwXQ6Z+02z3Vdj4oFLjlgQ?=
 =?us-ascii?Q?kJf++jhHMoRygbgvTwvSfLfNBhpKDOMKffb63qefkGyv3CR16dYBQ8bLBz0S?=
 =?us-ascii?Q?E1iP8XgD1eWaXGI4SA7vWHJ/nn6jA2lcy6QPYbXhAC5uAzkOJMJfVwci2c4J?=
 =?us-ascii?Q?BeeFKcRbuhWy5DC2/2PxrRCc9FRYsPMZ0kYDHlNbjIFlVdIcHnzMchyQKjB5?=
 =?us-ascii?Q?+Pt29Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 09:09:14.8933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb454f27-208e-45e8-ab92-08de5995ea5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252249-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A4490646D0
X-Rspamd-Action: no action


Paolo Abeni <pabeni@redhat.com> writes:

> Create a simple, netns-based topology with double, nested UDP tunnels and
> perform TSO transfers on top.
>
> Explicitly enable GSO and/or GRO and check the skb layout consistency with
> different configuration allowing (or not) GSO frames to be delivered on
> the other end.
>
> The trickest part is account in a robust way the aggregated/unaggregated
> packets with double encapsulation: use a classic bpf filter for it.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

