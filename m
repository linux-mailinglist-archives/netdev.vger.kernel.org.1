Return-Path: <netdev+bounces-256848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCcdAjjLg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:42:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63584ED093
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8348E302F386
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2A38B9A9;
	Wed,  4 Feb 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNsLOVh1"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19538B7CF
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244822; cv=fail; b=ouByiXQ9jvW8yy7ATj7k5UAhap9sdmtTwLMgGyLXxVKXrZS094d3PZBp9jYFE8KMsrGHEnjCW/P9g+nxQQj9Ad6/gW0BTv27fLG7V2Etu5+qQiAUAz0wvY9npV3nrblkiW2IBr4b8eZ2RJ004EsRFbMh15xPKuKaAaRaqPqCFjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244822; c=relaxed/simple;
	bh=8eVqJNRcMKcsZIjnQ8IhIdQ+B3AmfU3xtHTyLsmaV9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2jVQ5Iz31CYJTGyPAPfcMqxw2+3pLsXOVT1cCvm+qS84NzytBhAhpjjV0AWcAhTbMLavPdPfUR6d7mL3LTCVBqef5vo0FueaDwwPww97AjvHwcbPVQITLp4YxrBmm+sNCZQXZ+1y00Jbj/w4UROZI+VkIfRX72X31tWwID8Ekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QNsLOVh1; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCwk45EF9xV5Fg4Lo9omumA83Ih0WiwOzwDOJIpFecYjMDq2zysnXcl8bTZ3ETCLHYvOMD/UV+tMA6d0h0m6evdGUWBXJ35US17Fn9zSajtIzO0J4OWaMNmTuQJlxW+LCT2evWYkyqV1b4CJ9jtuKZcyARqLhj87w2N3djJSK3qsSj9X9ICWOFaPj0F+fhjC+GaVQdJFnw4KztwZXlAXroCM1v+GhvWsHeNKUzFwxNtAvIF5cp64FnJVIqewBsU/7++LwoiQCp3RTBnjIde5wEP2QHi9MYCB76NXb813i4WVALEt2HS5pLunfsimrLgPGtEQsX2PaJ/GdIaem9wMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=JLzPeQsMoKdEHUlPKTZk5bYR7F2OtrxVHMDbLFvdP8iNnUunh95CdGKHy/tfxqKIuy+Zo90QkuGHT+oBdeUZFxm3DvFHcwvauv3jcNDZafvAL1rsrp1cMiTqdbYy2h1cknVe1ZTZoPihn+WIcpYE+Lr1riRFYbLgVMOBhEKC1URMejNMfL5+CDVhiz0D5nSKKop57/hW2Z6SS6gSArPtDnyJDRc19mJAOwRP6FuKZuYqMjqmVyrZ+ClZ6ORzqgPj4bJZIk4Gdh5TxiuaO3zDxdwrTJsf+hPwnzvbNigrX2XquXcZzOAYZxaFWqSQcol4GW7VHS7Fnq5D1FhTSsJh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=QNsLOVh1RyPkAoRJV6hIl1epxJI0W8rpyXpOAEYi1GHh8uYmE9uqIN34K80XlDtAOHZN4x2sLvmbG4jUW0AYXhBNlvbgoaZvuWgJPfY3gf+T0DU6ov76BwN5on+qVGTsNOPzf4U30knd+MqznSjwTArdr9SvTQ5x+6iSb/NU9NPiWH/HSKpzouc+HmlzLpyqcdYw9LMQ7shHfB5kyJNl+di83L2Keo9q/CzS3aXKx7+mPGsOsSI1K5dGH9SLnw9A5pHfmN+SxmTqBmYK5YVWFQ03fIpfgIImDTaLQZUQ+D+U5XM/QSqkrds80CzOCJl0NzQe+3v/IManCdUpJ/uUDg==
Received: from MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::17)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:40:15 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::61) by MN0P223CA0028.outlook.office365.com
 (2603:10b6:208:52b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 22:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:40:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:40:00 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:59 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 4 Feb 2026 16:39:37 -0600
Message-ID: <20260204223940.39581-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b86e9-6382-48ba-a860-08de643e5d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIWopdxrNlP0EW9vdI/nP1OYpLWSIPJcHLZwNgnSOnbzE2HJQJttzxmznftV?=
 =?us-ascii?Q?7dWMp9B1+gf1DuLg/0QM/AT/2iUcJu8y4x9B/LDm9h+l/7zMBmoEU28MulPl?=
 =?us-ascii?Q?kda+t96vbnBAR2TMTel8/XbTYxxccptLJkcZMnv61WY/HNLhA7Jkm0WnWgQG?=
 =?us-ascii?Q?9v/7B0LF1MOvEu4ZClAJ+qa5tMu+q53zIEu4iPLPtlBJOx1t5wR/mF4Wc+d/?=
 =?us-ascii?Q?jI6h/gAc0gTGqYFIuemCgDwgzJwv5gnsKOGTLY4yxXI/cjX6jo2iW4s3XSAn?=
 =?us-ascii?Q?kxPdSQfqVYakm7me6yNnPAiY5FEFtW08k4EOXDsNOSHVHYsajGKMJbj0xf+o?=
 =?us-ascii?Q?ISaKWtfcowz2Os0kEUMFE8eNMIfkgCjaoMID4lyphkHLwj81Wgjm5/9CtYUn?=
 =?us-ascii?Q?wwus6FglLhazI+apnbYmZPTKEefejPDEF133nwPOmlAN2GSY3zfOsr6VlT0v?=
 =?us-ascii?Q?g53yZWA/GOrt9OF1senuxYDYRc8cArnidBYQ9hSbsK/GMc4mDKSJMCU+gSVt?=
 =?us-ascii?Q?3RmkHF78jfAYZHcbuGxqyIxWlOTNN14qmiVoG7mp4hAxAuVIy9q3oo/M/vS1?=
 =?us-ascii?Q?y4KFP8Ez1zE3JEfdbYWzgqPRMO12ZAQN7V/8AGztjk5bDcAUKgHO3FXeT0fO?=
 =?us-ascii?Q?ujbuKHWnIM27S224esqRyLjoKB3VF1lUnNBxEHD63DGfEyJrSLHtWLvgDEu4?=
 =?us-ascii?Q?NonvnylcOSngQgZhCIoUEO9VRoR7nwLo9WEsuPxQOBq/KP77dNAzj4A2axs0?=
 =?us-ascii?Q?LxVrlywLeW/5GYaitptBw72pVQyfBGF4W6kbvgtEUZoTm/LRhMyfC2ygF0y+?=
 =?us-ascii?Q?8YQjg6vMDNQFOYMz6G8o10w7N8zI6WUBKfOkp4bOUkgq/ttVCGDUc1ygAoO1?=
 =?us-ascii?Q?HoaxfezfDrVlnbgZvKDjs+XEXy6zE8xHkMZKrB9HTubSLJqZcADqkyIgdL07?=
 =?us-ascii?Q?0bhQ6d8e2m2pwvNGBpTOH/WbaPA1uBV7IPy4PWqeP9a6BAL//1OsEyfrvXuY?=
 =?us-ascii?Q?YTQ/KojOLQz/C1sGnrmCCrRQRLftGFjzmX5a7cvty8RqRa/HLl5HLLS1azRZ?=
 =?us-ascii?Q?b0o//hlQbam5+HFyvRM1jkpOM43KFLmjDcozr7pcyGieZzGcEZWNRC6SGgtT?=
 =?us-ascii?Q?3cMLufev55cAlS/ztLvLWKjbDv6lZ1wbMZA/fJXDdNW6V2p80i4dbJm0h8GD?=
 =?us-ascii?Q?35ESFvDbd9zIAL5J0DYPsdvaXznXL/jJCwkNzxsAWRcXXd4XhnuNTt96SACb?=
 =?us-ascii?Q?t6LdRXeKMGVZ8JVQU0STJ3Q+dgdOp6ad+3Jq9dlRCmYWSLY5Z4c2D0rhmAB6?=
 =?us-ascii?Q?GEJt6CMrQI9Xrc2eiubMDb2Ex0nF+DDVm561ysrujLg39Z9vZO63urG07sJZ?=
 =?us-ascii?Q?+7fj+dwk0iqA5UzrUfrNVjnGUFhrts1wyW8Nathdq/Ajp7KPpnQAbkBffuxn?=
 =?us-ascii?Q?vCTRyR7CWfT9kt18NYngvRX8NAuTf3xu5pFShIh3ur4QiQwcQ0h3PCwwUwe+?=
 =?us-ascii?Q?tP7Bbbm1ez86mI3drB2VzOmBP0arrStGe3AZtydvcp8JHuG3UzyEbuw5B014?=
 =?us-ascii?Q?HTiPxEIOvo9JaT13lJ+RTMjnsdbE69lNGWc8ra7U3YRE9vAbkJmlaAIlAtfn?=
 =?us-ascii?Q?jHOHWCr1nSYAKXgmKXmNZbmdJXrH6ytLGI7dK9RvqpbJB1M3S+12lvW1HFL/?=
 =?us-ascii?Q?6px1OA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XgRdiZ9TXkY13ajUxEu6rKhdH86HV2ZtOLgnQDGNZrkDmXsIwm5YEMkwtrp+WKH1kC6e/wICgxtxYYbZVgMK1GxVGhfbtdY0SQSyoj2AAZYI9mO/tN8cWzq5WzgKhnIywW+vx9lMy+c+Ut/Z27CcQRf1OAMj+z/NQzt4Y5T6O8BNIq0XagsAPBQXrqfW3IgHUNfd4JxoyJSHqmHO9M44FeJqL8gvcVvZ5U/Q1d/Xa/S9CtfYpkT4Xz8yYMlnJ4UzRaXPwE2KrxPwNJo9h6muMeU+0faDfQV28M9lSn0oqPMnCQ3hT/DiHdY/7Hcvnxtf7Va50TWqGCqNnkwKuBZLPm5clw0MKMZKoQ2fsiH5r8Oyv1RW3yo2CncUSj5SbY3FyGygiPOTtC1Ef6dXXwqXZ0w+gIa706cBsKxc5QQXNOiDF2fus2/QDfUXH3+boTb1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:15.0769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b86e9-6382-48ba-a860-08de643e5d79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256848-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 63584ED093
X-Rspamd-Action: no action

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST

v17:
    - Fixed portability bugs for unaligned reads and writes. MST
---
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5cbf26d8f7ad..92e34f51737c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5818,6 +5819,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5829,11 +5863,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	if (l3_mask->ip4src) {
+		memcpy(&mask->saddr, &l3_mask->ip4src, sizeof(mask->saddr));
+		memcpy(&key->saddr, &l3_val->ip4src, sizeof(key->saddr));
+	}
+
+	if (l3_mask->ip4dst) {
+		memcpy(&mask->daddr, &l3_mask->ip4dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, &l3_val->ip4dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -5969,6 +6033,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6000,8 +6065,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6013,8 +6088,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -6022,8 +6098,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6045,6 +6148,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -6082,7 +6192,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


