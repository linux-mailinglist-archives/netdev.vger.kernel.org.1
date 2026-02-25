Return-Path: <netdev+bounces-260993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NNoDs8Kn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:44:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A29198E6A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990D130E26EE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158753ACEFF;
	Wed, 25 Feb 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeLf20Rz"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C4271471;
	Wed, 25 Feb 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030442; cv=fail; b=oIt42zm7WTyQz/3j8PflR/2eWRDrqUwV3aFws/Xl9l8JwIq1O5QhwlzO4h28RpgmrPO3uY08hIbwzfveH2qYOgbtvlzKSDb2b7YnqK0Qe45FaIx+2JpLMUUGMUZYJnMK5L/g1JND804eINb0ytbjNlgF3H3J/zqDH3a6IzcwLpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030442; c=relaxed/simple;
	bh=A3Jfy4g3Wtn8KQRa1WUE9bw7w4Vu92r2AVQ8iaRwUOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHEPDVWoQlMSE/W5uk8uATn3O2s2LeGrpQG4hEXHdMEbcJhT58bqGbAsHB8OeRaV4vKrureD7FgTLvpjopRjwv5vWzg+IpVsTml2+XMRI4c9Rq7u4Kbtft9r9apYQUQncgRajtoRtXZRqMotP04IUOZcrkbCLn1nxj9b7j4g66E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeLf20Rz; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPIAphv/3y0FJM3l51ETQnTINiCco7+zIxZ8P4f028TF+cZrrZujuCoWjli9ScF1QB0657+8aFiTLvdE3LK/fOuKx0KeatQpcKPkPaxhLgPsphzi9NM7dSjIpmlV7Xk/lC1iS6GZyvjPoY+hxGFkZi6P5+7P9xv+toCOk7oU+mPgZ0DxGB1pVNQR7/EUvJXDbHTnxgd6EGXbgz8GgoUDk3kRK8I8+emMxMNPqEd+rGCZSGoqyMM3/8Odv+e6Y05gUQA7gLiJeaa/A3HNolgR7r03zDKNq59v8sWUk724cNHsIitiJeB5jgIw35obkxzPahc5UkmijA0bf5Hc65W/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK3E6/9FySDP2i73YDmGWNhZ1lJAkcT2YB+GufFO37Q=;
 b=nEi7tk656Qfk/LycSdRlyvMQ+g1bYpNgpYcmVWXYw9qX0aNpPCW5enaxTEz9P5sscdbENiI5SB2OnDvQp5Eassntf6b3Z5BCgM6MhrqPPWnbP4/v+UDg7RJLPp9B/jR/fKpqa1tZujczLrQzoioc3W3vlXa6+oZZNLKn4nmP+l0knSajXlDjTgoXpXgjnF2Ax8ZNBVseBDvaz+8aTEl9hXL8E1Es2q59pDlHX+0TO9Oe6HJWzn/e4mNkQjuZ32NVqJiYr6Zm3qqJamCmOv1m5pL7mUmaz40OEXk2Gn+pbtD+NAzpi8objQxCkOCaoiNOV9VFiPsV2/nd4bvgjhdYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK3E6/9FySDP2i73YDmGWNhZ1lJAkcT2YB+GufFO37Q=;
 b=BeLf20RzXXUFfAIiI1lIRckEuKoqpcJuklgucPgPin8VEiKoIYc6rwd9eBrxcSvuQuwoUTKgkUFlDH/lse1lFZiGvmiA5fMVZZUF+lx0y4VIpEpjNpFHRUTJJa0AwrxL2lN4/6UodsdkGvsMauidSnKeSSwfe1FMKbSQaiHeX6WXQyvSZq0uNW5UeE4hb0K3a/bUnO0zAns7o53tanM+0kh4ww2U3tJP6HusnSEk8XVEhzNsOmuGdJjzKWkWAyZJjhDAnjT0hr64928vOfWLiWiRtVUbDGhMFDSMFEO3/exo6724Dp+7uaWHvkuQjR+a2ED8JRsfCJ4OTTuJzKrWoA==
Received: from MN2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:c0::28)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 25 Feb
 2026 14:40:37 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::6) by MN2PR05CA0015.outlook.office365.com
 (2603:10b6:208:c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 14:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 14:40:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 06:40:13 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 06:40:09 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net v2 0/2] bridge: Check relevant options in VLAN range grouping
Date: Wed, 25 Feb 2026 16:39:54 +0200
Message-ID: <20260225143956.3995415-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b931b96-b8a4-478e-d9a1-08de747bd6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Pyey/jr6ioG4xYvVhyHC++fhQt+DQIxSxH4oHQXPuBWsSeRTmgn/zcD6HUqNRgo9cogs1g/5HPadvtOIDsSjSocE0s254ijam45//giwyDXyBFxdikoZT1O6SPFaQHDVIHIxcg5ubiqz7ZcYYYMcqEXW6dlx91tvN1E8yklpZqeVTW/2fHuujY5jREA6kL52ySuKkXbjbhA1DvJ6n6ujBCqplP7UUwFdh2ughSlIAidP3GNTmp1UgtNfkL5lKWfMgPTQQidp022vVOzOeJOMtjW5Q4bSFBuuEM5jWBlNkhOxc/UAGXaPFx6IWjRvZX6EglkLkuVp1+S+ltL0Ooqmc8wtFdC3k2cOnofc3GGJ6cYHm+fzd4YGI2ei3p3jphqRik+NZGzSpFPKIEMHGnIuOwqyBN799lu5Ny0T6BKEK4F2OuowgReuvG+Zg/N9TWBX0Lw8R+yxNuYqqhAWZrKihEYtRJ44U3ENws/a6mKifVhWMZR5Rt2Ruf6O6qR+tEEEmyx5ya4V1pGurXVT4EN7vV+dRZI5JAkzdZu8b8ha+EMEQH81tYJIxIYP6gLp+uRxQKMQQxaCykM2auW3eDXZwyAR0WlKrUyIVvtki7gfNA6sbdB9wFlQNd+aNCgMTvgH3MHrsCi8VBJo418IQqt1UJIlSXMSXY8PF0EHdMlImImmOuxyrZ8T9afCxZ1LcEA6+LWbQa+Cw/n7xY4ZnL7+jz6ZlBHIOLG2XoCiFl3EkFEgwtcImZcGYHC5pUfhP+O5L9HfEuo5g4hsv/WGyikuag2aKUZln2GBRWTLSN+G4uX+ZZNaExKasSogt6jgKgmrPkULVbN3zt5DPrt8XB71ow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gXbbmq5fdyyRj6yn1+7dVwTpIKnairebEO5C8KddNwdUfuGFhMS/LP2kHuDIEbwVQIqYYt8Nr/imwaqy7DPlqGYpV4+PDkOcj/ArwGtNbZmCNsj2kN6IsMbWsRnpzhsrDr8ATJlZg0SDIgpQmhV6Zyg48NM1Ko2oyRiHoVV9tVN+/1H2EGUUJNUxVH2h5++HPSl2n1vUI8VJtvP4mbvzA5YqX68MNUhF9N6grendV28KbgnyD7pOY0GAeARjlWJ9nScqHlCqWGVjZ/oDLKfeFVlpyiLS2zRAM7xpJIkOfb7Ss60Ob+u4GkyGNx/TW4LT74CRuHNJtNcZnK8MqGq7hpeHncjVUiCx7PQ20QJYJNOKBDY8o2Bt6TDIJ6Kb6no1AxXAX/fEb6WozU+ZSe9iao2h/8ejgZPX8kDiW7kz5W1id3+BxnxBA2gOlon8AYeC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:40:36.6261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b931b96-b8a4-478e-d9a1-08de747bd6f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C1A29198E6A
X-Rspamd-Action: no action

The br_vlan_opts_eq_range() function determines if consecutive VLANs can
be grouped together in a range for compact netlink notifications. It
currently checks state, tunnel info, and multicast router configuration,
but misses two categories of per-VLAN options that affect the output:
1. User-visible priv_flags (neigh_suppress, mcast_enabled)
2. Port multicast context options (mcast_max_groups, mcast_n_groups)

When VLANs have different settings for these options, they are incorrectly
grouped into ranges, causing netlink notifications to report only one
VLAN's settings for the entire range.

Fix by checking priv_flags equality, but only for flags that affect netlink
output (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED and BR_VLFLAG_MCAST_ENABLED),
and comparing multicast context options (mcast_max_groups, mcast_n_groups).

Add a test with four test cases for each option, to ensure that VLANs with
different values are not grouped into ranges and VLANs with matching
values are properly grouped together.

Patchset overview:
Patch #1: fix
Patch #2: test

v2:
	* Address shellcheck-reported issues.

Danielle Ratson (2):
  bridge: Check relevant per-VLAN options in VLAN range grouping
  selftests: net: Add bridge VLAN range grouping tests

 net/bridge/br_private.h                       |  10 +
 net/bridge/br_vlan_options.c                  |  26 ++-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_vlan_dump.sh | 204 ++++++++++++++++++
 4 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh

-- 
2.51.0


