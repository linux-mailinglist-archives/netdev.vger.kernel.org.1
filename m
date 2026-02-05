Return-Path: <netdev+bounces-257358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAxREMsehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:50:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4413F8382
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96E23014129
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876A33A70B;
	Thu,  5 Feb 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIXSCypH"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493EB339868
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331670; cv=fail; b=GTTGAYHqHEqTcJDsfXqle7rHawuouNnuXCRydKFz2ULGyePM5qBYtcyCHjpse/y0hzo/wJqJCocXXmOT+l1IyNAuYFfcFNEpH5rhXIEdcZ9Shf6l6P1qrvrq+1zj+YZPZCwvI5Y8MibE8vGxbc1v6wmlyeTql6lI2PCEhVpZGr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331670; c=relaxed/simple;
	bh=w3MHI688f5cdabIN9HoHZX4Du9UGtB5K772+tGUuzpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cej+TkUEB0uKSWwmXySs38dP0TJcQBQbsveBDLTqPqsPE2aB0+YFkeZTHCIoPNzxMYl9J0e4yRKaGb3rdDUx8FWdbY8ae5r4MLnVaXadlDVHWynEB/Q2JiF0f39nII9lJL08NkqJMgyl+k92EQraiOTw26ZH6noukFY+vLGbI6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIXSCypH; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssbV1xisNrPsrjy9B97nK2q+CtOjnViMusGjjrLC2HohYVhQZYRPk179JnB7PJgskbrNkgilbwWvwH6b+ddFk2X0w3sgeW1sEGBaK0RXZtS4tHviE8XjyTNY4sL97vQ6rndOogn/UPVH9KlPqIE+UMdAojez+NbUmwvSRh/tMx2AKBWgFljl30j13g2Kq1knJaSZfvlU2sp/GivswpNBXuaSIPdSK6hNP/caSN2ZemsAt8Wuq8in4EkNbQz8kqEpNRofmqXytGlavG0oCiEf48E1jvclLA2zZAnV3jaPopKZCIEgaZ1oiWaAMnGLN5dZ3LpNiJkXyTGtzUvDVGvoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=v9PRFd3cPNDE+itHn7KpX4sREadekAx6+XvXW3iYcBsQgS4UR5roZ1tTVhTd3MnF7hIIsEw2xRvvrfGpmLhO6ZTsIaCZVRo6VJfnPg8tlZJuITn6rXlPxc/I/0LRmEaXG4I5MhGCTFozB4/WsHzmH9pQWl/vLs8yZDEqInJQ248dSupwDLR2mcn9f0RlMP19wYBOTyC3qNKBPRLRo2TN4hVEJO69ESQxT9uV9hSia8g8gZ2Mq+nWCWejGpyh71j9xtYwInvGO8EMyz+1pJCAgptv9EKcNTH8x79kBLQgQSN+VneMk+pWHJr+pOXbamCS0656SOiVK+ZLLCT34tdGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPvj7zKB4ElV14vr3skfmtA4C+KBFuv4Vw1FGX43SJs=;
 b=EIXSCypH3dUFzwQMfUoCDIcUyiVuHXDwSo/YytJPAIspP56WGwwKB3Oi1j6WelBVrKDELxf5hHqjTRVtCqpsKb+g2CPLkPkpZ9EubZVHiVEM3AEAtiO1N2R0QsSJQyy4KcB2utF9b5wUljWTHmznEuoSEXp96MEIUHohG+sTbnLOkzz+vtUP1jT4c1OR7QgLUKoqs/7m0Lifvf8aqiRneru9c+WSWprrFDf9tfXS782rVF3lnk9RdY38yNO92yfFIr84VSHl3+gg2v61dXZF8pXmILjiSEagGxfBVFFrVLji+wKaPZy6y2EcXXawym2uA3xxQFEw7gqpJb23zziEkw==
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:47:44 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6a) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 22:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:31 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:30 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Thu, 5 Feb 2026 16:47:06 -0600
Message-ID: <20260205224707.16995-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 227a07bf-1221-47e9-431f-08de65089345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQ0eks+GPEoAD17dyKLSIsacT6d+hZW50Z0ADkAOwhFaf5lCqSqmI6qra4Bz?=
 =?us-ascii?Q?VQEwsnXFvFlVfuKSB2Hp3qrqtOCuii9RwwTOWx7i435Liacfm9BHD/w+8B4Q?=
 =?us-ascii?Q?lZshXYtrLKsRuXpXmrE2buM5VJvQEs0Qeh5sJE2+hLA1B+8kbc+rs7CcXjvE?=
 =?us-ascii?Q?So4joDqO9IKXOO6YVo+UU0akbut1drVOKm1uCDIB55CqihZ63aPExz5e1/p7?=
 =?us-ascii?Q?jXDdPMG2EHV4qTscqOpJy/PZipxAFir1jGeiYA/1wINFrtPBc8ieN1ItSfRx?=
 =?us-ascii?Q?SwQ2zOz37IFm0aNULWqiMSxAIDIrmpair4Q82xoCiy5t46i31HTleVWl9GN2?=
 =?us-ascii?Q?CyAm0jXogHsNXGaakuK5h5h1t/oAyMC4VhydxS3BCsv8gV2NtFRsBpJWn3rs?=
 =?us-ascii?Q?xHUhZuqT5JsG2+nHj9qel3GoH742WPYO+NfzKJq/iVxnKn/JwjY5vvs2605M?=
 =?us-ascii?Q?M7JesCEPyUk8RZ94dkCbrNbSkCwFoFo70ErZzRI6vd377BGNgj2fO7OiNK3w?=
 =?us-ascii?Q?lzfbQtlgS2EdqESMxdaasemtmKagMIpVogXuZQ+t+tvrUbFGD+wm1rmx8oz7?=
 =?us-ascii?Q?8b2opT1aZxwIzFG50PdxgaQ0HXbLB9SA8dN6GXXI3xV5+OHVvMD1m+a0ea6C?=
 =?us-ascii?Q?s4VjkDMX5BZMVfATJhRjSC4Tq/9e/Rp8Py4u0PIMcJFU/nSc/+yldVfV5mnc?=
 =?us-ascii?Q?1BxCLnDHE7rnI5BiznVhfk4qCi6iqpq4gJ8xIU7HZ31un355xq4YqAwvLGbZ?=
 =?us-ascii?Q?qol1cs1a97SoAC3LNjJvOgmlGvOYX6DwwwtHeLSTTApZ1r54UREIRO6ifH3a?=
 =?us-ascii?Q?jn+Dbeub2lgwdvxW4FaVPfSEanXsGrQ5Qcf2MauK0cKTgfrkLixnB8UvVWMK?=
 =?us-ascii?Q?xqgQu4Uc/ZWZCMY+ozN3Bx6kJEfg1IcGkPmZxqQciKkfesxTvPvjS3oMNuYs?=
 =?us-ascii?Q?gA+oe8nBGtpxiIAE4n+iQSDSEll1xHPAYTJjGNxtO5ZQMdHzHH51H0Qkk7Vw?=
 =?us-ascii?Q?XwnhLvh5KiB3N37Yo2SY8sf7XzuUhRms6IGHLnIxhw8w9Arx6mYbomWL1tJP?=
 =?us-ascii?Q?/BtUgG2wxfAQoALrPW3FgUAwTN4WCfv0XgGnrDik/qULqD1UaoxS+qUSghA5?=
 =?us-ascii?Q?TGbLd2EH8HIflj/ouxU5LdS2p66XOB6UIb9rKO07B9QeiJdSirmnQUrlCFhH?=
 =?us-ascii?Q?BznIpv6HTqWVsVDLj+CaqapApBx+bb/2d73cOyyPg/xIh7l4rCvafPHyB11c?=
 =?us-ascii?Q?PLkz7+6HPZWrA1VqbVTccOg5A4EcLGedTALS/2RaoFPxpuooJ1kyZ/1Ha4s9?=
 =?us-ascii?Q?2M00sLSPmPts96sjgFEALe/E06fMMy03er08XQlKN91J78YWtWlaa2d4blTt?=
 =?us-ascii?Q?lNsn1U5wB+wxTbBTDcT4fjQfYSGVVh3qVRVosvL2OI2WBmmdsSlpcsonwf9r?=
 =?us-ascii?Q?/SNw6/ihKhKD8xhmhttpkqG6j5W49C3An3zTbk/1dWZCJ07OlL47C9yojZp8?=
 =?us-ascii?Q?jDp6NW49WFtpQraeaHsbgyIHYTscexRVRzKqSBXxBaBP8UEOlVNUGjwTd+Qf?=
 =?us-ascii?Q?NO7iT73XEm3+v5wr5cOU4gpNTIaqfhgUc4FnjCZ7GcI9JkavZS5A+fBvh9MP?=
 =?us-ascii?Q?8mrwgZBoeWnQFCGu0E2FiZCmfxFgLqqY6Pw2tvVAMn+Q4VgoXHBWpLHYGJUF?=
 =?us-ascii?Q?yQZy9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mx1OBbANpa3+jDXS25semA4Jje+c48NdLGbYG+vCZUq/1GpTxSTKl6LVydX8Y0Y+b5frt8AWq/XCGmvDS5wPbBwHs3Yfv6ARWzLtmlU3ktKMOrBxXOdIoq9W1iPBI9CwRYUa2sMlnMW9N4cTvNq6UIg1lOn+ygylWsLaEUrXIWuO0QO7AKtWhTBOvzYLYqAMZvbXcrwOyuD75d7/H4OaTIZh6MhRb4RDLUN4SBxWVa3DC10aM/jYOIfuj54sCUu1ikXjatIHCMrwgnxyokzjvB9Mg2rKl7IlXYsJtitqsMkZcMklG5JlvngYfCpUnvFv4OKFlJcVxfl5eREjdwpJ8QQsOnF7UGFgagGyt7Zzd1B2P7jKZLGA+CZmyr2ud8iULBB9dDxe/9LPYxPmbECiArzQp5f1yraDexzQO/E6tQDe9iPEgcorTy2AfpKH1ANl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:43.7965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227a07bf-1221-47e9-431f-08de65089345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
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
	TAGGED_FROM(0.00)[bounces-257358-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B4413F8382
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


