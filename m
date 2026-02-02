Return-Path: <netdev+bounces-255949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PlbHejbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15017CF736
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EC430D6A0F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249FE387344;
	Mon,  2 Feb 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcY7nCJs"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16097385537
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051984; cv=fail; b=CFUt8u3HMW3sd9zzosM+/VRzs87Th5Vn0U/46wIz2dhxTQXTcX2H2d1RtxNtgoG8B+yAHQSi9bsCU6/KUxli7HNwkVIvA57RS0b+t8pU66LdwQpPu3+K5alAHI9vWi1AU1gCUyFyi4dBUZPxnp8UnPn+YR9KbedNBR9iLDglITI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051984; c=relaxed/simple;
	bh=HGTtuYG9ndscFxcmHqSSga7TmvARWwFr/+wD3S9Puh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSag6qYyD2v5LuSYPl9rBm5naqtsq3AKyubILJ8AyDoorj5xKKEKAvlEyHWUWMq5iPXk/8xnu7B5XsqVc1b5aOY3Oh5kgbs4JCGLetBxmLuSJSaGBPN/Jf1uXH9u59Hakw1323F+8oQ0sXLwcVRxAykqiEl+7pG97R6xgdU6RMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcY7nCJs; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlcWF+NZRZfGSOGVelzNXeMTvAn5qbgklzKo8SlFNwnja24R9hS+QMetl9VQrGv+UnxGfCdgfC3WVqDN/hYiD5d8aFrtdJRMRgmCMOOp3kcGcqwwGxTeFH6fzHTZyyuhuwNGQvjRIFtuK3JWdLOdwIUl4Rw59hwwL/xxo8Qdzcae26w16IvFoV4F5ayzHE/9qSQ3sPN+zv6Fk8QRDCYQxWbBaYWDpYn17eWRSE1X64zLwjRZ5WoDjznhipNAMwiQLYUJkmH4wjBCKDPmWSYbJjvzcMWXwTYrGP8S4JpYreMeIQ7KgHRr0LwaxJgAtGuGqGCMuVtejjBj4tzq5CCMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEB+y3RDxHrT9HIoH9axg20w6eTj4Kw3QgIaBAHDrHY=;
 b=WlvojvCWydG/drj+/iKH73pQZdBbj07L2OKDubUw0VpE75psI0PoAWcrF0rkQyCf5hIqGHJ3ldhoFvABeYSWFgq1IdDt6FfDFkx46nDTSmDJX/sxOdL3xynvcZpKSa1xGhkdpToLwBzg/XGJs/9H3xxjeBRkFb9CGjIVr//Jz3UGY0vSMce2AhJuXD1k8MA+JLZ/XZGJHYwQ2bDoBUItCR9uxWluk6NAARuQSJGDKNV0gQGgE/Krwe+GiUpdfQturapE2iOe2xSZOXSR25keEg+Zyt/YGcr9C1ajIKDY9eZsfC3z055X9SKVZccjLmX47u7JBE4aQtGdguQH8N2FNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEB+y3RDxHrT9HIoH9axg20w6eTj4Kw3QgIaBAHDrHY=;
 b=GcY7nCJshgWGgaBAq4iEEC0rj+Exh3BvQEDql8OJY0xYzIbMaV7U+HN2mZmaEUftOf7r4XTm8s62xgr+CWUA4kCTuvSyfpxld0F1zoFrvV8Soh9TZvYshNCuodPlQtBOiRNiQIhwqkrIPfS2Z8dJwSXrIf2GfQ4dNzI5Ac77KFARZWiQRQEc5SFOkW9dKbsJP24mmXW8CRnvQPrhRPZ7heqWgTp2fJqP9hf6r/NZv7p12/VkUBu9c/iWev9jsEZ64XUGSCKbflHPh3eMXChJC8/WQ4hPrp5RO8WvWzgXuYcqb07s82HORBzdvK/b6Gr7wlB7gScrdqcvkGmvN7MvtQ==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:15 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::83) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:34 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 05/12] virtio_net: Query and set flow filter caps
Date: Mon, 2 Feb 2026 11:05:11 -0600
Message-ID: <20260202170518.9076-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 30042496-8b00-49ae-9a52-08de627d603d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adT5QDYGMpBols0E6zWv7hu7vvI3R9+HvHFo/SyzgDJLvWZ8/t8BeW5lBBI5?=
 =?us-ascii?Q?v/kR9h+/KMP9ZUn2CwK/TrELz2nKGdzYnxs83w1oEuE4UWOSmPgHWita6ALT?=
 =?us-ascii?Q?9kvh4CTxv7SbFabXtKnzzEGqUqPh/NqF00J4p1nVuB/B0j8IXH82YtyYRtjO?=
 =?us-ascii?Q?gXx//3AvVvi6Bi21YfELeSX2Fh46lbQB+SVvRtWlA185NV08SVWkHtqQoRNb?=
 =?us-ascii?Q?IlvBjNJYe5j3T+k7ZxJ+drrQsvnPhGFuK7c8HYQS/TSBnTM9APSMtOlk3GHG?=
 =?us-ascii?Q?is08onNtrQIa5OaX6QrOqBNBxqCFvMpmmvFkj7ykkHNUBKwmo6URkxs6oMJP?=
 =?us-ascii?Q?vpvJhweUg6iafReK3xTbMLc46nxLB6Wp5YM1OHsQznW11w5NvrVMl/ueNFp8?=
 =?us-ascii?Q?7iI/6+cQhG8a4jPr2TEViKW00Qb5yQtnSQOEu9eAS6hBsUHuEiyM/VuwqQfU?=
 =?us-ascii?Q?FhCtO3wpDy6n3lhWnbF7pLWJUbypdnUPJ1dbr/ZfEAq3vZMPwb9kJrTYlkCK?=
 =?us-ascii?Q?OGBowE5Wz3b/DzM5qxHmQ7CYrfbN6Av2i+cmeB8ME41pKpxvTJJOSQakndTG?=
 =?us-ascii?Q?77Lfc0NycGLs2J/831m8MMkgJnJIFyOHzYCTu06ynYTNlZnQmBs9Tvjlv8fs?=
 =?us-ascii?Q?EUI/sX2o4q9qF9IRqLVf+X4ITCqVNzoKaYKC7r5u7MRCo7TRGktNgXcMHVHO?=
 =?us-ascii?Q?opQCKztPswRIi4f813Nwhyx+37uuA6qLG0lIVd6/Q1HhVh2nP1B3K5jCBn4v?=
 =?us-ascii?Q?28xKIjXXN5QU74lDh3dhIFtCbwPPM8XgcWF4AcAXzoqNE0LzW8G3kB61gy6z?=
 =?us-ascii?Q?lPnozHEdJVR86W1O06aiC9Vp8bfaGvjyiqeTjujbAY7KzBXqTEg5j3Qudnb4?=
 =?us-ascii?Q?oO/TolaEqYzx1tBy/mQoZBZR/9baakcQvnDMepqdKnlraP2N0pzT4b3jJwi3?=
 =?us-ascii?Q?8K9r948Y2dp9DydN2mFc7/dmPFoHcaLv/fgVU+rEa2w4RSC0r1DjDFGM+D+i?=
 =?us-ascii?Q?hGagFhvW8FVKoYr03++aXmEbugTcitJlkkmz5Bl2D0v7NqbW/t/wHBUr/SD0?=
 =?us-ascii?Q?erO3zpHVN24TrbHJixsMynK2Pd8vbY2+M64t02p623vaMJXxHIOouEwyDEKn?=
 =?us-ascii?Q?iZKw9u7MmgnYEJiyezbaarTuSv7dPRyetIU5xV7EgCH1Jee5GWNqAvbgzKA6?=
 =?us-ascii?Q?k+NSAJUEFStQKO/rgoHm/wnWqcIDp7M0Lbs4fn9W/ZbgMhgkKaf4QadN3/cK?=
 =?us-ascii?Q?x5ZWTDpaInX3YpmYIe7sLbP4Bk4Z1i1J66WBClI7VcC9pKCrUhoxNomi9mkc?=
 =?us-ascii?Q?/6cmQOGiJQYWF6FzJ6WAHC4VoNXlV3sjUZOwpkjJHKAtUtXOTvfE3lHyedva?=
 =?us-ascii?Q?0Zy60PxyH5o96nNbDVLPD4yfE/69Cm+niJNrk3IdqPeG1Fja13Po41J6YPGj?=
 =?us-ascii?Q?L7H6YV9OnYMQ5/xOqjPGs+9ArRGR9mSMsK3iUgy0DV/UZiaDDheihYc6mIvt?=
 =?us-ascii?Q?Mbm9x2i+2SAIM1ZO6qzWN+6YB9t1DBkyvLPSTcCgU6BGOlhHUzchoDtbTfZD?=
 =?us-ascii?Q?NDhPhhishlIOtPe9OndjnMSzZ2zS1pEB0iyv3d6tCOVFihetteajLcz8RBov?=
 =?us-ascii?Q?XYdcLSwvJCwCbCV90uRWjYUI8Kt0rAhvcMKGoadIwMl2AWinBvzxcZzwKAyc?=
 =?us-ascii?Q?jMtHzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nmKHbF/cwszP6BvLTJVQ5nXrip23xTxeBa2EORxjI0fE55FZwMtyjzgMJ2ZEkbic1boUzplRFI1zfBGR9BKljT1gjTlXT7rsyC5rz2WVPtwufDZCAfDSlbfFxRrky0wiAtrSPhZLKVSvjp/Ey1UJGS44TTJK7MP8ZyhFehfoAs6mTw62ecGDk+6OKkAVzaWir0KPVpaBCSFYn/YDY0gPql5DrpEs1ZJmVAjPFR5TZIZ2Q3wv7bjUU7cJKgLlztrwd7a3yUQPWw6ogKYKtAwaWePDH1QPmnVE9dIApwnud86C1ouarFfe0dP+M/HxcKt/cmUnHY52cL2JGtFz2Cx6eWtYryBjEONxZyqcdPnFYw9SJv1K5nelqW3AhXQkcLiHQdUed3OJbKEvOMiYB/Z3IHNuSlNg28YDOrh15UcYfVECQvHcuuKokOFt1H2UJN5Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:15.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30042496-8b00-49ae-9a52-08de627d603d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255949-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 15017CF736
X-Rspamd-Action: no action

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v4:
    - Validate the length in the selector caps
    - Removed __free usage.
    - Removed for(int.
v5:
    - Remove unneed () after MAX_SEL_LEN macro (test bot)
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
    - Use new variable and validate ff_mask_size before set_cap. MST
v7:
    - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
    - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan

v8:
    - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
    - Set err after failed memory allocations. Simon Horman

v10:
    - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
      Jason/Paolo.

v11:
    - Return -EINVAL if any resource limit is 0. Simon Horman
    - Ensure we don't overrun alloced space of ff->ff_mask by moving the
      real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12:
    - Move uapi includes to virtio_net.c vs header file. MST
    - Remove kernel.h header in virtio_net_ff uapi. MST
    - WARN_ON_ONCE in error paths validating selectors. MST
    - Move includes from .h to .c files. MST
    - Add WARN_ON_ONCE if obj_destroy fails. MST
    - Comment cleanup in virito_net_ff.h uapi. MST
    - Add 2 byte pad to the end of virtio_net_ff_cap_data.
      https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
    - Cleanup and reinit in the freeze/restore path. MST

v13:
    - Added /* private: */ comment before reserved field. Jakub
    - Change ff_mask validation to break at unkonwn selector type. This
      will allow compatability with newer controllers if the types of
      selectors is expanded. MST

v14:
    - Handle err from virtnet_ff_init in virtnet_restore_up. MST

v15:
    - In virtnet_restore_up only call virtnet_close in err path if
      netif_runnig. AI

v16:
    - Return 0 from virtnet_restore_up if virtnet_init_ff return not
      supported. AI

v17:
    - During restore freeze_down on error during ff_init. AI
---
 drivers/net/virtio_net.c           | 233 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net_ff.h |  90 +++++++++++
 2 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..e884073eba5d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,11 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -488,6 +501,7 @@ struct virtnet_info {
 	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
 		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 	);
+	struct virtnet_ff ff;
 };
 static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
 	      offsetof(struct virtnet_info, rss_hash_key_data));
@@ -526,6 +540,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void remove_vq_common(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -5684,6 +5699,194 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
+
+static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	unsigned long sel_types = 0;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return -ENOMEM;
+
+	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		goto err_cap_list;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP))) {
+		err = -EOPNOTSUPP;
+		goto err_cap_list;
+	}
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps) {
+		err = -ENOMEM;
+		goto err_cap_list;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	if (!ff->ff_caps->groups_limit ||
+	    !ff->ff_caps->classifiers_limit ||
+	    !ff->ff_caps->rules_limit ||
+	    !ff->ff_caps->rules_per_group_limit) {
+		err = -EINVAL;
+		goto err_ff;
+	}
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask) {
+		err = -ENOMEM;
+		goto err_ff;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions) {
+		err = -ENOMEM;
+		goto err_ff_mask;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = (void *)&ff->ff_mask->selectors;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		/* If the selector type is unknown it may indicate the spec
+		 * has been revised to include new types of selectors
+		 */
+		if (sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
+			break;
+
+		if (sel->length > MAX_SEL_LEN ||
+		    test_and_set_bit(sel->type, &sel_types)) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		if (real_ff_mask_size > ff_mask_size) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   real_ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	kfree(cap_id_list);
+
+	return 0;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+	ff->ff_actions = NULL;
+err_ff_mask:
+	kfree(ff->ff_mask);
+	ff->ff_mask = NULL;
+err_ff:
+	kfree(ff->ff_caps);
+	ff->ff_caps = NULL;
+err_cap_list:
+	kfree(cap_id_list);
+
+	return err;
+}
+
+static void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+	ff->ff_supported = false;
+}
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5702,6 +5905,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5727,10 +5934,23 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 			return err;
 	}
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	rtnl_lock();
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		virtnet_freeze_down(vi->vdev);
+		remove_vq_common(vi);
+		return err;
+	}
+	rtnl_unlock();
+
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	return err;
+	return 0;
 }
 
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
@@ -7058,6 +7278,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7073,6 +7302,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7121,6 +7351,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..d025e252ee26
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+/**
+ * struct virtio_net_ff_cap_data - Flow filter resource capability limits
+ * @groups_limit: maximum number of flow filter groups supported by the device
+ * @classifiers_limit: maximum number of classifiers supported by the device
+ * @rules_limit: maximum number of rules supported device-wide across all groups
+ * @rules_per_group_limit: maximum number of rules allowed in a single group
+ * @last_rule_priority: priority value associated with the lowest-priority rule
+ * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+	/* private: */
+	__u8 reserved[2];
+};
+
+/**
+ * struct virtio_net_ff_selector - Selector mask descriptor
+ * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
+ * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @length: size in bytes of @mask
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @mask: variable-length mask payload for @type, length given by @length
+ *
+ * A selector describes a header mask that a classifier can apply. The format
+ * of @mask depends on @type.
+ */
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[];
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+/**
+ * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
+ * @count: number of entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: packed array of struct virtio_net_ff_selectors.
+ */
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+/**
+ * struct virtio_net_ff_actions - Supported flow actions
+ * @count: number of supported actions in @actions
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
+ */
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[];
+};
+#endif
-- 
2.50.1


