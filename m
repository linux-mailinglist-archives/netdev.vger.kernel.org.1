Return-Path: <netdev+bounces-256477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILeRGah3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D764CDF4C9
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F66D30F6D24
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38937A481;
	Tue,  3 Feb 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjDhJzKA"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE79377541
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157791; cv=fail; b=siHY6A4yTNQ0jZi0ph7vY5novzTBOSvcUHtXLz8hkZX4MSK7aE+o31PAmXZtrD2KTueGTbw8Hi0JRO78LVbcEOeSxBv0WvJLicZV8zvBKXdOz0GA2emPzJIIiHoQlRAj4cZG/E01BZpLhnVoVSUrB9oQHLmz8iM9FAgKlrqmAzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157791; c=relaxed/simple;
	bh=w3MHI688f5cdabIN9HoHZX4Du9UGtB5K772+tGUuzpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyArOs+3x1GqVQaZ14FAHOKrts+3mD2WYMUYN/bE9ivOkl9KMhYfjvS+AdhbNMjLaQ7ycLyahcFrd7FoKxb6bMr/jRXGBDVIervlwu7p3ox2wo1DHL3SAdIAbfoUmihZWKYjwhpKzPvl3EiOAX+klu1FOL57soEKSbvohrkhvvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjDhJzKA; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1UCZxSssjKcvO4/YjTcQOlyDs70pWSpNT8oSnaI2ySk8bbHcQBAlu4aZqLuFGD5TrOoiX0rYo1WmNPCj2hGdqSxdqP9ah8kwWgfBjABZB9MCiUj1Xd2uUHQNbixrGtyAUFfJocNfTCCWtxgvIE390gD+QKHGBZmJzgo9mCGEG2ae1X/aIcY02nEkhFFACvKMqa1GjjGmBSETNbfJfyq/KqoJOF+NGqLo8DR4ega38/SUkDEN6TjB20CiQbjBILCFvGvUgQRlz1/MOQAeud7sgkPrygCcyMDcjYbjx1NtTCf6RJeO4GT3iUQ1nSKUyd+csVJiZbhWQqJmTbeOsC8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=oUogHvwqmvDNE3Xz0MIcGoNpFn40ewcmqWbdFPC5JFIFQFj0rYebGI/lnAEhWVyhpsvP+mgfDFfBqzrg0oOTuWmErOu0Gd19XYs1BicNIByL+RO/8+HyFlUvab960EEiazm1FBq8axTgaBuJKSMoaaLB1vucl4WSpBLyuRvxREIMdTGASjZXHg4sOIJSjXhxOhQWHa+Cu+4m946S/Iqe4ooXVcListzfP8zuXBi0aLOF4lu1rZN/RqU0PECmHjTSzYBPXqqeuIZQS06DoV3E/bKzqGMXSuSDc1qyrnwxmkvgSZ1bprGMOOFaDyFvssbgyR6yxugeCyQOFvRIAHI8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=WjDhJzKASqq7Jbh54LzlKroS/i3QAwgtjJ4pth9gVA9a+DSQAofCqo5Q1pYhVcCX6o1fF4WEPGBbt6D5YwJRrEj51qQrX2JNRk3ajLNC95M6zfECgZGgIWAw1cIr+uwbu5gYWoHhHhYn5B06/4uUvjYKDC4knYQwQ6zDIWnFGgAxTgomA7R3Dn4bS9hs9ZSeUpVV9u/9OxG9/FMjWZGBZCy+QcZPZKwQatfR8ivLtmalZXhoHLPuTZe0r8CsAnUFSYERGp/40mKHXGOmqjsHXG4VYHSRZ0hisTWX3ivS8BHQn2pfeUamCZcwep84CJ49cGdZe3jyKN/1G9gHwsy2nw==
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:41 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::3b) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:23 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:23 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:21 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Tue, 3 Feb 2026 16:28:58 -0600
Message-ID: <20260203222859.4219-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: af34bdef-94bd-4de7-7d5f-08de6373b960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T1eQNzenJqJwwWMxjXb6YI3l25mM/8oaw2xPOqLrpTgl4GzOSitCnmhxT45M?=
 =?us-ascii?Q?0EtYVy5xuyTE4OWn9um1NFPKSaTxW8p6HxKcndaNXy3V4Y2D8YzQ5pM73TpA?=
 =?us-ascii?Q?VznERarEf/6qA2uQBY7QJwBmcp2yJq1Ml4vT/rB2rS9N+Xk3rJa2HkWMUQiK?=
 =?us-ascii?Q?Q/7Pa2xGKLImKMbHsr4Zsk+lPU/C8FvfxdBOdKNYTuyC/x54PsOyDb0bqV9p?=
 =?us-ascii?Q?gcxuATo/PcLAt2RK9JKu+kUfI9SB8SL0HSvS7ykHzLf7Bm0uAp7DzZAuo1EY?=
 =?us-ascii?Q?gm25X9giNSkPwn113GWKcgYsjOu9mjnhJTi34q/6CFLXaDm6eiaM6pB8qv8r?=
 =?us-ascii?Q?Johmh/8JN2UkIhda7BTpxgk5ize8DEnBqIT4tRJ9phdQW2zVlG3X2arwhscY?=
 =?us-ascii?Q?+xr6QmFI8xbYdw98A4o5BZawloau0FSOmZ9Vb5ZjJ7H87SUgdfa+l6ciAcMe?=
 =?us-ascii?Q?IiGQ3KQmR4r8xTH8SfU5bFCYYVcEdx900MQVi8S53nQZf2uzFE2GmBiaA9DO?=
 =?us-ascii?Q?W4M14mvGJpgfFRBpAkvegzzZntvHMND40R+J8CkTckoxdzi6ngzVefQZ6JnL?=
 =?us-ascii?Q?3T1BNHMAnVLWgAWr9mnU7G99+U28+RaFv/w/CeGC/XNTIU3Q4S78OJ1rW6g5?=
 =?us-ascii?Q?g9TzaIZCh/g24/1+9lphiMiR2gXLfo7BU+0r4QYn3unY2t4im8DHskJjoz0C?=
 =?us-ascii?Q?3qSy6tyfRvc2euhPS9K5y5v7lnEfmuxfsdKG3XVJLzLk6eNVJ8gtOiwVwcYu?=
 =?us-ascii?Q?tvV1yJ64YAp7wnBVgbmKrXFIETeEnvqCJQ0C9p3b79w3P55wMs29Kzhpxhoo?=
 =?us-ascii?Q?uEIGzgs1rB525nkFns6Eqnjbr/T8e7z660jNajaeQcTMobwYt4wLamqZJPPW?=
 =?us-ascii?Q?7hc8s2B0qsn42rM+3cksJ/Ua9vx4QPm3aN4Mxi55mVl+cXQtpsVwqPmzak/3?=
 =?us-ascii?Q?8eq6rolNLQEf0cGtFhemBcjfSpXeDzIZzpmVZtxpsxnwrmS99uogqEwHkl6m?=
 =?us-ascii?Q?zJQlBET4UmOrfddpVSbSJZvaqQhA+MdavcqZEKBRPupLU/HzlQDnWIskb0Q+?=
 =?us-ascii?Q?WUkjG5+a4N2760B1QpPwhdzHBLKKg8bMqrLDDJ/iokDM0nXBNBptEcwcItEr?=
 =?us-ascii?Q?bbEZSKgWG35Qs4RDkh6UkGM/z7TsObIT6oKW/SHx8NDDIf+GqIYVlcN6nuI8?=
 =?us-ascii?Q?Ndu/MQb0UHcPsTocCsQdzfq3276Epvgu2KTKIhd1qiIZk9QJszcoDCmECYYV?=
 =?us-ascii?Q?5yQOCVrqfzQIPVU4G/XROvjZGt4epi4yinBwHg5WKN3NazRQYnu6W6Df0FIX?=
 =?us-ascii?Q?Fy5qLd5ge2HOYwIY++t7bwFcBtq42qyMvGi5LdUbYbKwM164zvOfb6eF82xt?=
 =?us-ascii?Q?pThd34MdweCHjR2/T6fOl298o42IyY1m7zgMVX5EuYHKJGA11Eevnr++M3qC?=
 =?us-ascii?Q?bwKXduDq+8drwqXNxP6ROkOqZjT1xnSfvIhgEGtTxLARmS1xe80FG3BT+/yg?=
 =?us-ascii?Q?rDagitiI4n75unz7q+2DV5V9BjunovqQ/rCm5WuV7so0MzvxyP8kfZNhlYf2?=
 =?us-ascii?Q?QolhxPin5ezlBveWtLsLaPmDk3hX6wgZFAT00A5JSqD0yravhytDhTBqPuS5?=
 =?us-ascii?Q?n1OkKbwWamdiRCuYFWfQ+UCaLXdi8pDn3WWiWyvzUSCnuFGP1Z1ZzMp+Hpqu?=
 =?us-ascii?Q?WkCzSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	69E1pUATzTgcd+xH1wwn0gTAFKKF5FG5uT1OxV4ZJNUoHHgY7loU7m8liapwD2pcs0ar+GGL3Bqli2pTdworml0W09YxqjUCuiYVn4Wb03ElSUjqEQ0XewYHDxrRveIo97DqRE0dRWPSyt15Oc7MM21CyKtfwiyYph8Gj/Ola1HI/BZUYMCOzfkDC54kdO2m3YPqmyiwviT3lSESfdfUThkSmKwUcWu/6yPuGmkGu2upp7dSB8uKwwY/CMcG+iLvjScf8TwQAOdVpk7e5vTs82fGYhSnZs7wNiT9O7sfL/UfzpGTJVlZ+5KIII/bRe0e4CkQ9sPUyFM4FoRL/J7lhgPA34DseMjeidwWd1kccXtV7eUdkSryadiJAvd/itFAG0jCQnn0+e9P5+cPiwrY+Fbr8uYhwkzenHQq2zQ1yJdYilwXi0Zs7V9oTyHcxGBk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:41.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af34bdef-94bd-4de7-7d5f-08de6373b960
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256477-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D764CDF4C9
X-Rspamd-Action: no action

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)

v12:
  - Refactor calculate_flow_sizes. MST
  - Refactor build_and_insert to remove goto validate. MST
  - Move parse_ip4/6 l3_mask check here. MST

v14:
  - Add tcp and udp includes. MST
  - Don't set l3_mask in parse_ipv?. The field isn't in the tcpip?_spec
    structures. It's fine to remove since it is set explicitly in
    setup_ip_key_mask.  Simon Hormon/Claude Code
---
---
 drivers/net/virtio_net.c | 223 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 209 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4e46b767553..155f0ceab006 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,8 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <uapi/linux/tcp.h>
+#include <uapi/linux/udp.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/unaligned.h>
@@ -5886,6 +5888,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->source) &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+			       sizeof(cap->source), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->dest) &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+			       sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5903,11 +5951,47 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	/* mask/key may be unaligned; use memcpy */
+	if (psrc_m) {
+		memcpy(&mask->source, &psrc_m, sizeof(mask->source));
+		memcpy(&key->source, &psrc_k, sizeof(key->source));
+	}
+	if (pdst_m) {
+		memcpy(&mask->dest, &pdst_m, sizeof(mask->dest));
+		memcpy(&key->dest, &pdst_k, sizeof(key->dest));
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -5949,12 +6033,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -6094,6 +6192,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6135,6 +6237,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 			size += sizeof(struct iphdr);
 		else if (has_ipv6(fs->flow_type))
 			size += sizeof(struct ipv6hdr);
+
+		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+			++(*num_hdrs);
+			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+							 sizeof(struct udphdr);
+		}
 	}
 
 	BUG_ON(size > 0xff);
@@ -6174,7 +6282,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6186,27 +6295,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->length = sizeof(struct ipv6hdr);
 
 		/* exclude tclass, it's not exposed properly struct ip6hdr */
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass ||
+		if (fs->h_u.usr_ip6_spec.tclass ||
 		    fs->m_u.usr_ip6_spec.tclass ||
-		    fs->h_u.usr_ip6_spec.l4_proto ||
-		    fs->m_u.usr_ip6_spec.l4_proto)
+		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.l4_proto ||
+				      fs->m_u.usr_ip6_spec.l4_proto)))
 			return -EINVAL;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip4_spec.ip_ver ||
-		    fs->m_u.usr_ip4_spec.proto)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->m_u.usr_ip4_spec.ip_ver ||
+		     fs->m_u.usr_ip4_spec.proto))
 			return -EINVAL;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -6246,6 +6427,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6278,11 +6460,24 @@ static int build_and_insert(struct virtnet_ff *ff,
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
 	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
+		key_offset = selector->length;
 		selector = next_selector(selector);
 
-		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		err = setup_ip_key_mask(selector, key + key_offset,
+					fs, num_hdrs);
 		if (err)
 			goto err_classifier;
+
+		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
+			key_offset += selector->length;
+			selector = next_selector(selector);
+
+			err = setup_transport_key_mask(selector,
+						       key + key_offset,
+						       fs);
+			if (err)
+				goto err_classifier;
+		}
 	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
-- 
2.50.1


