Return-Path: <netdev+bounces-256853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ5dH43Lg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:43:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6441ED0AB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B2E73043BC3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C637F755;
	Wed,  4 Feb 2026 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEbR7xFg"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA036EAA7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244830; cv=fail; b=VDyIDqy1uE44lqSnbYG5rnCCQpFBKATboe8mrbCU1F5eIn3BG8eGn8Bp8TUMee8gmvEHPiLl+YbGlKhU9DNWCQjuCGAir4B9zHjzrR5j8YgK5uNDPPtqOnOrIRReTYJx4IUWkpS87P1NxC2EMxnuB1OGUqpGNFsfjnxFMAc2htM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244830; c=relaxed/simple;
	bh=w3MHI688f5cdabIN9HoHZX4Du9UGtB5K772+tGUuzpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obUjOhU0O1wsMRx7Y7UdE0y3eA+saL5x0uGWKSFNO9TOKJRFdiPZx/Kw53APJvkJ858YQXs9MnDUtXykITXhdw3TsGeEFYiyq+HOFNumw8y4tj3wLNjm+OaJWMuVo0ZK6WnvhrKMKA4XDQLZHOEMcETilb50F1Q/voORHyFJ6VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEbR7xFg; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpkxvFcSD/uGeBr4W6NpaoI4016le19om6y9kJ/Ntxig+9Ug277GC7G0ickxx9dYJhgwpjIO+paBVdKADiqAZLBeLNFwybVTdb1C9mdmTHDPjhw9ukjo0fd2Lv1hyXzaHaSYg5/UcTn8oiURGDJfdLosrjHb8FuedDYOtFWK18k/Q948PXj5WFdXg7Ug6XAcYXWw/4tLa1r4UL/Rw9ADZ9joviNbh21xZnHMZkMe0bwdBYgpwm5uUberbUfK76u7P5Wp+li7yN9Xbt5MGlKzkTGChtJQm2bbdwclPpwURIqUS+Rm/K5CCAerUNlgWBySDvD7TyKAVeAzDkrMwPKfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=xZHP+4zoFje8hiipWKkqnAqXaONJ3qcTHGomzAP3ca/ohucgDKOAMjj6JtxRdv8rvGoditasIfVZJ25oETauewMOA+iFhU39JiCHbpNplTwQP6of9sqAZRp2VZDRntLNMurKS0M+8drd7L8js9zOupBGLrko37lX1mxwY+mLIGtkpZ6j6tfByT1CJGhAfM1Q/d+sQWnoK6ftnlulOAtR7lCCY4Uq7ppNEvFg0mdl1Ag9lTYYcbZQT8UXvN5jkCLjLysslSp34lU6JasIToELSgvHg96SJm45a0+ddpQL4bUDKiM3lLS4BVJAfiHZwnu1f02nVGpIi4UQrCk3NME/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=BEbR7xFgc0tjojvX/xtefrSKCwnwoZd2cgDHTg7W0USDzoQO5w3GMUbH/xFlPWEp3Z01Vvg+/DSbxuh/PLoDuwDwDFpEgCx+6d+4XL/o2iotjWbvutBfiOOxfWmQEhgGSONMrsMzV8HsqbABdnJyR8mNhFvoqOke9FrienrlnkqQB5ahWK6Ui521QXSXHFGCB31cnzB6djtsxoqxs0NAt4c7/UPkTifYAVkCvjgvGKLgitdsqUemipccy0izXKe03NYqVJHWrQgCJ4KlLSvwYuU86fiCtLhHQyzSbF/ulVWOAaquoDonZdz5PmQSF1E2ZFI5ImXIUmdVJQgIeyOsaA==
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 22:40:20 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::83) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend
 Transport; Wed, 4 Feb 2026 22:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:40:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:40:04 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:40:02 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Wed, 4 Feb 2026 16:39:39 -0600
Message-ID: <20260204223940.39581-12-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caad716-a34a-4cf2-1f3d-08de643e60bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ngr3RY1sBxCFmuh/Oo/9sLygcC5spNx+DFXK9zAvkTXviqPyWVPBBbYDd8e6?=
 =?us-ascii?Q?dPEEcjdFlFCSrTXIt7bGQxxjx3+X/mdIF7IfA1m4CEnYNOs1n4f9KtAzYh4n?=
 =?us-ascii?Q?v4IsT6O//XUFGLj7UtyOf8W6dRxuOChS5HQdhKdRPowOGlh8B1e5bMLYAMz2?=
 =?us-ascii?Q?4Bkyy41lr6kDRIpSUu8hwnMj9UIzy+NDtUkc7ci1O9P6qF/eD5lO3GNUeaEX?=
 =?us-ascii?Q?ShQbHm9+5Ux3Uye78RPkQHdasFkmSKyC2xZ3+9aM0acLCiLRcOpR6EyvI8co?=
 =?us-ascii?Q?fg1T81fydvMEXFZMiEbxPrzulhIsjHQwoQ9pqzMThbzowmlxh6QQl5CxyUOC?=
 =?us-ascii?Q?059t0wPniYtn/ksMzFnng2THw2+Am21acw8X7ZLHRznu/0JVb7u5cUZtpYds?=
 =?us-ascii?Q?NaU1ZqT5tOkuT9ZxtWSnFF1VoMdQlaZpnBWyOK4AHo1G4HzKv736nGsyu96b?=
 =?us-ascii?Q?24d0cSOGso2aEaAF+aBYXBaVDMj2BAqQv6j3ztjnOTJiXgB1JolYoFBjMXGk?=
 =?us-ascii?Q?awj4G01NvpAmshU01/82vIm3ksAp56c/z3zAFW6jgYIoiS43Mun9CsE/Bf8V?=
 =?us-ascii?Q?7HiFuqap4TN9txfOp0LYlUSxI4iRiB1J900MG0y93aq/3OcLtgNDQy/ES36W?=
 =?us-ascii?Q?ebOR2vSm+UICNQ585lWpPuZ/72+MW1X9hcNaCTm0bsJBWHpsWsjf76vQ8GXx?=
 =?us-ascii?Q?+uI+v1oJcjPkg7yq4ZtFA2ltVHwwxOnPVHRcU8Qhofu3KBzGlwb/+xg8HJZ+?=
 =?us-ascii?Q?sWtwZnNYkAC8bxWc/IvQ6ZKvXXCNYrA2hYYTu+XhuFgb2EFtpO7khoXul4rs?=
 =?us-ascii?Q?K0AAL+aP7RUuV1aKj2uT72Fi9MglcC3yTDkSrISba1M94A6mVf/hDOil25Pz?=
 =?us-ascii?Q?n5aS2XY2bTUcjSN/H4InQDQUO+qPpCK2LOX9Q1AuT/BUgv1UWag6Cfep96ix?=
 =?us-ascii?Q?ZTaDXZhg1oRTXBif7yyX++NenK0MSDJWpGqv/lPRDJiEKaT0ZdTlRVeSuC+S?=
 =?us-ascii?Q?FyfJSj2mijFdvAVCb8Lsc+1DxEfq8vkPYt5cEsPt2uwoNRyiOqBwfr2NJyBZ?=
 =?us-ascii?Q?Y1UMuz+ovqkoF7PGvW2VqBaKwa6IYXT80YjNw3wvfRtNFshBsHwbgrgyaQyA?=
 =?us-ascii?Q?ux0lwLDI43rwmVWQO+ltKNdHNHfAQf4CKz/20g4CP4ypSWNlS617fEpoJ5Rq?=
 =?us-ascii?Q?ATlygMZ5Znwu5wQVFE0ile4SmAoa+DOAQt1t6b8AllyltWT96fJN1tUntMj0?=
 =?us-ascii?Q?1RLj5mbLzus6RzvWdjhw/31kmFszhGAwWm3qSyjwncTUandAZwpNXCt5QIpx?=
 =?us-ascii?Q?GjIZMgIkOY+3YmFxoQsiys+0CVi0v3TdYrxLYcOmdrk1Eot9xjbnG1pGH1HD?=
 =?us-ascii?Q?qdSKYarXgUTFAVkBP5w51m3DjCtm6kjvl8TaCCIfcbZLPa/Xy8g84Txn0645?=
 =?us-ascii?Q?uQXNpwAKjJ/So6mILgpTo1Qpz/HO6WB4MvhrJVzU5O4t1shjURCs2wheNJfk?=
 =?us-ascii?Q?uSgR3THaBzWob7jcI/NLv1ZJ4bA/YBTUMM3KspOBSOPkjtJ4Ze3+IEYZR7CH?=
 =?us-ascii?Q?MS6JR+EiF68UHuUvPGaMSOgSkq1itHuSpOXJFLbCZP61e48QeCOip3lSNpgX?=
 =?us-ascii?Q?W0IsTLZto0tzrVDvspmX682gB1YxrJTEzAwCRy4/qC9YyGzaK07oAFRzOevP?=
 =?us-ascii?Q?QzefIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AUb2BmbhZjTdScBrX0jy0DDkJJCmJD/1EjC7JBZT2USSI6CuqDbjuT2tjpaM8R5cRjVQBFzU38iFN5yCsX0uPTjNp7/ZNXkA55gcyHnlCQ8HKqMxNJBU8MJlJSdS8yGtUmXcOXbtqYs/DpxZSd/Tp/EJgqGvH1C5WHvGYtg3BPC0q0+qlZgkLMhQheuXu8inz1FKU6AtSw/jlvtNMI0PQ9lYo6UuPDiBo/ABgwYbdZ88xVFJX24z+8jGJXAWZ+G0HFVgSJElBQh13Y1OjtRQ9YPXCm/GgiWKxXPq8jTUmnarWJM9Tl/JQtNfIiLM/6bDdlH/ZEjt2x1UAqeaCwQZ2J5vsIAbwikhzbkxWaKXPiBEETiDNqEeftw+WVrIKkailz5JclSjZBDNR6y4UIVXvs6M6k95C0Xq4HqbjM/cW/UKbZ50Ugo2m/Mz0HgHOzpE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:20.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caad716-a34a-4cf2-1f3d-08de643e60bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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
	TAGGED_FROM(0.00)[bounces-256853-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D6441ED0AB
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


