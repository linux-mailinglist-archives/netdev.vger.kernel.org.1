Return-Path: <netdev+bounces-256854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJlBKbbLg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:44:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88BED0BB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810DD304C7CD
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6E31A558;
	Wed,  4 Feb 2026 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITD87HFP"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB3366567
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244834; cv=fail; b=cvL9Bj4HZsJ2PpHHoKgFCK73w3W+9Jxdp3aw9LNBQ+rgHWG5vwRAhd+Z3LnfOX7anEH9lqN4yZzjv336FJyUJr5sVVLReva7Ibm7s21Cz5gJC0mxCQg9SZVyjf3Ur1CN3+biAfWt98qmYH22XafOxLVZ+h9Hk5yvWRioNHo2kfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244834; c=relaxed/simple;
	bh=5oe1nXGi3E+gGMDVFF3qYsKmk1k27GVgn2xR9ysqahw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/04Xy7xT3Y5pKh4aUHuBYWu85MVNObBZvzWVlje8F8zdwVgGkBvaWFG8p2z7U0HWCGLSTW/pVCRM+/N5we0yssVu8exKBzwTMos/IRSoeEN2arqz7l3nEQTQ8vNFfb9+gpHs7AHN+y5JJyobqpDpLLEX/GA56SFig78Ts3pBMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ITD87HFP; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPxU/Jn8LK1A2debebLkchXdjNoh+QIkJ6N9H3rL8p7PL1rYXVlHEq5hvKvnxbShLFELGWrZ6Eg0oLIhvBGjv9jiYhE4waXcANxeRJ8zaOeh5A79M35xwAJcFcf/sHAsQZYIru8panuz++5dmolBkQo0PAqQk9jMtuupiK75r31lxqDaW2X9DlhpiN/LAsgWqAuINgSIAhZh/+46WDxGaO+xnsbD5B/YU7gmnmkbSdgU3miYg8ky9Fn4KCtYYBzUD86EtStxt6r/zRf9Gi6+DYJnUOSuOzrTZGl1nQtS6xtREU70NlSfanuIRaPPHvaTVban8Y7uTdzAjdVzUjRMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=YowIg055tht3wfYF6A+Y6tCzoaBjgqIzhDKutMgU2CP3uvTPbK65meldU4E9Vy+ycNx3l5dk+676rXgpMtiBpv5xRlu+IXdz2BcZDUoqxfCyYN/cXAzPO01O9ggkRixliwiBfAkcGZbmHkzUF3CooDj0270JkiYc6G5OtJk0IqkgE6gMnjjklsqZlKvgerQk9NNr/hoGM6C5fZcl0oTo2mG6DKys2Hjf7blcVt05toojWs42DwkyWiQVd/Lz7tIicuJfJ9pApFkY+o9P2osTSMDLi5Neb7Z/raOT0GHURoP0hwlhKU2TEBSoj6CVWt61hEPLdVifPbdWKMR3DiuycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohwOjv+NSzMEm5Bz4uQz2APcJHHvtzWsrGQBotNnWkk=;
 b=ITD87HFPyHTOgcPsSzhULzpTADx7et/J/+h68jOpkQKf62aMlSk7WLN7ALbvh7dXLzNLjEH40NLEUITnE6+14K9pGaqEXHL2Zi5Snyt3yckkhxjun1rlvQQ3lN/6t7L5nZFtYTQQC1gkSvUxcGpDTN0d8C5J6qZjF6ylaet2mLNNnfODSewyrkqYvwZa+iI6/5K5P1N3Qez2Dz16db5mlca77GNezoks+8PQ54Zcua3SJAo2O9KVkDNrcLu3Z5RFnqYBla99vZiKga9+Qc31bx0XpQm9Tdadose18Qfis2wOtSBxVvEjwnXvdEAk3gbSvGt+pBv1KUbf6/LvJKcjiQ==
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 22:40:29 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e1) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 22:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:40:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:40:06 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:40:04 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 12/12] virtio_net: Add get ethtool flow rules ops
Date: Wed, 4 Feb 2026 16:39:40 -0600
Message-ID: <20260204223940.39581-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260204223940.39581-1-danielj@nvidia.com>
References: <20260204223940.39581-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: e40d5f64-17ab-4182-8b22-08de643e6555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kkFnM3inT7XaAOijU07VSxmXcTtIArlMWVKSHWFxB5D9DwtYHe6ClzUepfR2?=
 =?us-ascii?Q?6BzTLE+i7RUzU+I1MbnWmQ+Se+lQ9G3sKYrRZaJZJZ4MDRXvJFElOaBN79cy?=
 =?us-ascii?Q?NVwOc9g+J3ztATG+o24pT/qCUKSd6DaKWjSyXWHzpDq1RQIp9W8PXto1q1i0?=
 =?us-ascii?Q?kq/8GX48M8IJ9Isxnw8teFbltlc0hMWJMW00rQpAaS9qKc7T7ktvtseq6K2d?=
 =?us-ascii?Q?DOCoIckXdMcSU5TKt0Fuosy6uBazV5CaoRLJd1uFBHl8+7imZg8ddZad86YM?=
 =?us-ascii?Q?X7AUTYu/sigGkPd7M9q9Dslqt6Db4kjX0iti7zJ17tWg9NsENWKQ6tZkzn2i?=
 =?us-ascii?Q?srliqghGNt6ZohCRb/MEzaXIXCtNpOSNh3ib/swLHGUcDMSFg8EGE7yZVJbF?=
 =?us-ascii?Q?ADxD0kdPBcYwNBmUfxK4lBbEwnGzcW4ljooF5g5LicJV3ISUO9Osw8NxLjX0?=
 =?us-ascii?Q?pi87kl8hEJV5IK/Ueskdh+WCk8g+up/rXP+e85xuH7pTHIn8C5X90cHuEFkK?=
 =?us-ascii?Q?LONC3QMnf+Zm/ZMRwJ7qVLHBAVTeLsBWr0A8MDgKazMCbpmrrCuS8qOdzGcm?=
 =?us-ascii?Q?tMZwOhYcHNp/5QSDd8DOe8Eza/PxQ3xrnEL2uXNAoBrv67ZxrhVoNoS4hpwG?=
 =?us-ascii?Q?/xHJpk9lwPzrx1vKFUdCS5glpT0JozzoHD1XI913NeUUF8B4ju/RTe8Qgx1n?=
 =?us-ascii?Q?MH5Zy4DPWZ7npLeOoohh9gOj5z4hsflC+vpHvqlj5lXWfKY+PJfk4XpbZDfy?=
 =?us-ascii?Q?NTkIHZ0gJVOn1c2q4GKpdBRlfadiogjx944bhtCtE6v/E0UCGD8wPE4ra0C/?=
 =?us-ascii?Q?JEH7vOQCoChh3ubz66Sbx+zZRfKUPehoUeOGc2vUvdhZWe7Qkm10OYShN4T3?=
 =?us-ascii?Q?V2jURCyB8xG9jet7ExydXbFisn62sgLKqxrBZs7o3iGItYvhV8LUke2qHyWq?=
 =?us-ascii?Q?NTery97my+hVWdG5H3HLcQzUYQoRd4nazQsPzZIVgLxdyCHmzpXnD0kAvEpz?=
 =?us-ascii?Q?p/XwGthwtbZvK1HeEsgW9OWJ7F0ujuCDC+Jd8gFvTJkFqx7GTqsIRy+EOhyX?=
 =?us-ascii?Q?FOuc/LCb7qjVKs/ADc4+QuuEnTvaDABIUIGTosMSpL6olXblPwTrBuwkZ/lr?=
 =?us-ascii?Q?eVt0inyY37a6ca66ulfKpnXZMzV7cQx17MlvOy9l9LPQI10/o+xUrN+WQG9N?=
 =?us-ascii?Q?Uq8d9ot1h/IyfBSMBypNTfY1yC8qdJeFAm2PzqKcoUsR90+E7uf2TC2l7QKr?=
 =?us-ascii?Q?A6BpVbGQ6AMr9wxqtonPv5VgaFoF5jdouxSk9Y8uDRkOXrEF8LXhSrOlXfe7?=
 =?us-ascii?Q?KMaVcSZESr6/gbgCP+7uDN7C7LUGCEXy7sk5G7NIeXyMB6olPq88HaKX7GQH?=
 =?us-ascii?Q?C/uY7iKzSHCpISNfm+gG9R61NYRK7yxHzo9ljiAANFZW7K64Q4zInO2CPf2S?=
 =?us-ascii?Q?lwRb95XSTltUVonWZUzK7LEDYuyygOhV67v8Sxkbj3J9FlhaLyKITFhomvIC?=
 =?us-ascii?Q?1Kmf6EmHG/og7njzIkfrp7ACcB3eNn5Bl07YsgQ+wPEhQ435NZx6bJw+ii3F?=
 =?us-ascii?Q?hr/gcYQVYwp26vKI5Zz4geVGBqGu/5InaofnhHFBqPc2gj7URgsOPByf8jsB?=
 =?us-ascii?Q?5ofpsXIPzW9ljXG1Y9s2eo8zn9SXLpr4KYJBWZb9b/utDyDHt9rZMUI+bU+o?=
 =?us-ascii?Q?iVDb+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UgENp7YfyscZ1Wy5Pmtc8djPkf+xMgqM7Oyjn6esks+VjRnJSkq2PDJ+pm1zHeVXe+qELpF+7Hy+iWPkJo8xzollxsYwqEKqxO2xMnjLMwSoCQ7eprRoPS7R5/Zc17b03aUpVADmf1IUdgAVtBb4GW+2rKuyLjAEYNOtDXnwp/pSJJjZv2tT21gBZlfgfFPsiVog/hoRsY2xpaL1w+3exqqJpo5QvQJlN2nxQ5Iq4qEpfr/vKCycvadMkwDLMS36xsIJvnXFxECe8FGxJBhuF0jzzskyoNvPfU5NUpgu83XwdbEIwhfr0dt6YXNW8qeZfBhWjpJzrYai83qky+whFnzSzc8YrgPTWjgWBKwsvGZ/ovrzFh0cy4BZmsZqGS923YFS7eEAf0+2f/6AD7m3tHesPIkE0qEssNficpjk44dB5Bw/ocLZbcPlhWQ6t0WI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:28.3107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d5f64-17ab-4182-8b22-08de643e6555
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256854-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0A88BED0BB
X-Rspamd-Action: no action

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 155f0ceab006..24e586ff6b14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -313,6 +313,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5596,6 +5603,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5637,6 +5666,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6568,6 +6598,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


