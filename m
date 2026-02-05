Return-Path: <netdev+bounces-257350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH4ZKzcehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD84F8330
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39458300B9D7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C23346AD;
	Thu,  5 Feb 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atAxuUPZ"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A4221540
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331658; cv=fail; b=RvLpEbYQ1Wp877uEx81flLGoJ1GBXdf7+XrEUxWXTZsDn+giK/3tXzM4dRBSfrzKMin+CuzkbL9NgjTwZOStTm9SQRExUuYoZHmboZA36qo1ipYDYVMCvG1J+pNvN/DD+2eGHVf4LcAFhJ5I4ycsAUDXLRnU4aE0jnVpF9/IxCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331658; c=relaxed/simple;
	bh=t2FrcKiaN++GEbf6PPdtMeEU3iJH+lARm9vGC8IeWSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2YZ1xhMyx8PqxKIyNNbAZD7QXibOmQY/MWX1lZALQpps87ic5xBBTeUOH8R6wcNWPe59ATfy1TqqHPvBJ/JFXWbEDursQFKP5TX+WWknO71zYP7xP2fB1Rti5T/hoilYjAqXliZ+ORL024c8WBdn4nsjLkWOxHEFvtLK1aCtuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atAxuUPZ; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDPXmUyK66WmHuAIwXlKQ7mmVS1SB9jpUnpqV0G3XssMbGwBbaoST8HLqD2wvYr6DIsgx2vOaG5U0G4cRDA6FLvA2N4JVbLu4oGnwwBQANIBbDGyRJdUfc7isvDiP9vTvBeSC6quwj66DDUj8igwPEjsFZpEzy1ICX0OA2stIQYU265a7mbQbtz/CwLeqb0Rpfgnl8k1T3yRlx62ds0hch3QrkfA7g3dxd6gU+yYyWTp0gfTDhEU6mVmtchs4l9GEtolsCGbBppLLlIERQHK8KVBr1rMelke+DUxXpqqkxKsRCZNW97mNwClkEnNt7YZ+z5X1jbwlpIzhC7z9lMOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=Cba9wLYWTeZ3GdIhUh492Hjl7syHSkVb4kTHY3gANaNi3jU3MHC7hNZLDgRm3I2wzA+31cKIoGYXCwLlOUDpHPRwu7tG5b39Y0PEqRddnFcYBR9fsZbe4qnIkFNSZd98fm/JD9j24IIYpzla4mAEHJ+hXhUTdSiJjoagIRTDRo5UvqX5hzldAKp2wernQIL586IBWT/s6At6wsJD//JFikc8/h50tRJm7bruye5z0Fp/a1ZlNIQSG/IzNbog+LZv7erImI+xA75bnrTQ3QULAQxiZClb9vdCx6e1FxkfS3Pr+FB5jn67qFi/e6IyHGilBbf7uv0hlklMSw1w9AGRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=atAxuUPZWoOeVxU3FeQpeDPGEsMTJU2Gs4Pj7lA6j1xqnYKKA+kErx6oUvjXiLjMmPYEsXL0rsuJlbsMLppM9ij3bmTBnwMCsMu9CIoZoOwEqkOYMCnGjJ3AIZPzPc15jj4NQDRdzJCD2d3fJAcce98/8ryff/eexxlr5XYE4Z0KHiWfw4NnUiiVFkd/pOq55pgbNE410v4d3cM5SUcNdns7f4TEUUYz+nUVVxo96vpMD2DHdg8ec3ODEjHMVpD/oB9ueeeTmVKOktwKzJeKxNUsaqeSc4gIX6dKfWLr+czWiJmcMhlI3+WEi/rbV/UXINclEETKzjfTw3S53Xt+lw==
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 22:47:30 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::74) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 22:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:16 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:15 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 03/12] virtio: Expose generic device capability operations
Date: Thu, 5 Feb 2026 16:46:58 -0600
Message-ID: <20260205224707.16995-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb0bd33-d73f-4714-47f9-08de65088b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hotnGLQmKEsUJhFGD+xB6FRmdXPk5QYXpUPc/ucOCNMOdU1IC1nzsS4teRFI?=
 =?us-ascii?Q?7RjpKvaUtNdaenN1TcPGsz4bH16znJ5eUIungPJwgc2FuQRPBl8z06VKrHWA?=
 =?us-ascii?Q?H3gamqo9RgIcv7/fenqqQhAy5Wlck2zzsc74OxJzhB4OQ+zt90U6Rv1QKqV+?=
 =?us-ascii?Q?vVyGjGs5BjS5gu59q9VnY+p4ohU+SyZ+4gBsx4RIZLEA72vwlWfw4E03evoe?=
 =?us-ascii?Q?6lUdrIBa9OfSuy6UZ4vXkj9czbvBLWpgwh5p5k4I8pxzaavEifo7wBdKOHU2?=
 =?us-ascii?Q?UDDfc6ULjpIeFRLpkC8eHlnijQVkIuZIWEQqRoM4/VZgvzeDfTlEdOQEPFV7?=
 =?us-ascii?Q?8zu5ZV9YgLBcOWQ7u1oT192xzjER6oSvNGXrbskqrXlsBkAJRu7Un+jZ5pQv?=
 =?us-ascii?Q?EvrUKyWO5x5fce7SR0jWk8ETVhRrDeMoeby0HwMJWHis94v9JTKzLS0HTgmY?=
 =?us-ascii?Q?n8o07xiQGltqizP4ddHCGFDrd2r6mZHMsGKc9orG7b5k0O/tY39Ic1Z8Sw81?=
 =?us-ascii?Q?oFJyU7P9kMyiRyA2PSfCVp5zlVjbsFewHdF7a0P67/N7k/yQRRGc3SC0sQNN?=
 =?us-ascii?Q?fWYjzUmZl2uDjvHXdr/uEmxxvbMMkr/DiWgUFWzMD2+w+aRcBOmJFIMqwqAS?=
 =?us-ascii?Q?g3ssp0T/xAG82d38yKMjhAXjpqXin32Dpv8fWRal0gc0Nbd5bmNK0s3I0Cwc?=
 =?us-ascii?Q?8mDKEz8VZD/uEDCAziHv2EGLUSbZklmvNALp6YMXh9x02NmGoFG/LS1n2dRD?=
 =?us-ascii?Q?MT9xWiDqrMLyZHQ9T3C+oAm968zn15uZQcAlhXawEYLwe8to5foEXAZxA3rJ?=
 =?us-ascii?Q?7JEEwiJRLQh94O6uTS+vDAYajE7ShjquekOokCRQbl7KNNL/5sXO5ClpLF0m?=
 =?us-ascii?Q?FWVcskd4q4NoGS9wsashaKsAg37dCZOrtx+NTdAwngUD/U5JWxRimP2NrnbX?=
 =?us-ascii?Q?IQUY5suixKAHVUkKNckpO2Uvd+33wLvqOODkbAHSPr/fZeti8gCm0gEIR9nX?=
 =?us-ascii?Q?KCLSaSYtj+pWInvG8p+zByuBmGtGgmac1rjLOHGhTD+8myo/8387A3F9qi+A?=
 =?us-ascii?Q?1frPlDNzfYF5GWdt31L2x56LXHBpw7FIRET3MBNdnhze5lbSEbA4m2Of9RPZ?=
 =?us-ascii?Q?LQAhW4FdNwPWGltfl2WkUobaAUwpYKUcnfx0kd4Xbc1vfncL79t5EWe37CXK?=
 =?us-ascii?Q?JB6A3QHS96hn7r/+nW6hJm5w7h/zhaAj4CtTf7n34Mp/b5WF4Aj+/GeCiENE?=
 =?us-ascii?Q?/FCqNHj+3rvSTeYu4y6ZXdfSmjW5zLlk4WaXqsXRapQugn6bEs8OM2xCqbW5?=
 =?us-ascii?Q?1Ez9LnSIbMmtgMZEl9e/eZBhpBWCjwzmmnA4Sh1wAlKHbbtUuq4uJxZRXWjL?=
 =?us-ascii?Q?6inYeS0YJdGRDx/0IMI8HyKBA3dO0bOz0YiwF5IGakK1w1uEshu15sL+WxA+?=
 =?us-ascii?Q?650Najp41W73Ze7WvclwsUon+fMcRmU1ln+YdPzDC+51VyedxlnFM6jXmxI1?=
 =?us-ascii?Q?rVX5glfIYOMcruUWoVFJyqBLet2u4CO1EGeOq7obiFI1eOKvcOrOOG1QQxz2?=
 =?us-ascii?Q?Kpg8vRo0XSmKR8L0NTdi1Chx0G5G3c2IZ6UBnc4rUoHfdFt+JXtB6E4jOpCD?=
 =?us-ascii?Q?EfGRNAyeQQipoy4dVk1lhtHSY8pLWZxCr8T+bk/N7zZiWjW/ftLNvHFyiFjh?=
 =?us-ascii?Q?8oFk/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tgk3zzwPiF1prM3tD0J4jkYG3o335P9ec3jnozJbk5vLvjSkvIHuli0WBwzprHBFcdhZY80FN6F+ajCy4i5XipPxyr4GbR0kKN42ldFuuwo1nUITVGVgXEsLt6tl3UyE4pnT2wyu/KeC9+ewbIJV5BG+JXawg1N5hfXmsSZvlV3dymdNFUumoqnn3DFNHXlE9DAorr3QjSQxtK3jJzVuXTGcvwauPbhiNVpB6DPLy2ITMXan1Qp2fKpn/0YLzbpV9aFY6h+1Dea8LKVKAvZyrkixbT5ZZce/nJfoDmNZQ2pAJLA1ROklQNynyPZXYub0qfyQUgMSLUaOtGqCDGihGZwMUpdS5jj/DYwMDJFAqpjLLfiGF5Mj9KP2rd7mC8w7yGsqV69dSzaUpwbmDALoRFZSro9ry8uS1Pk9UCpj5TaeUWmapYpOsZ8wC8wDKkcH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:30.0667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb0bd33-d73f-4714-47f9-08de65088b17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
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
	TAGGED_FROM(0.00)[bounces-257350-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1DD84F8330
X-Rspamd-Action: no action

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.

v12:
  - Removed uapi virtio_pci include in virtio_admin.h. MST
  - Added virtio_pci uapi include to virtio_admin_commands.c
  - Put () around cap in macro. MST
  - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
  - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
  - Updated commit message

v13:
  - Include linux/slab.h MST
  - Check for overflow when adding inputs. MST

v17:
  - Added missing includes. MST
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 +++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..2b4a204dde33 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
 obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
new file mode 100644
index 000000000000..be9144b25d84
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
+#include <linux/overflow.h>
+#include <uapi/linux/virtio_pci.h>
+
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	sg_init_one(&result_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.result_sg = &result_sg;
+
+	return vdev->config->admin_cmd_exec(vdev, &cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
+
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_get_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = &result_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
+
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	memcpy(data->cap_specific_data, caps, cap_size);
+	sg_init_one(&data_sg, data, data_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = NULL;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..4ab84d53c924
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+struct virtio_device;
+struct virtio_admin_cmd_query_cap_id_result;
+
+/**
+ * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: 1 if capability is supported, 0 otherwise
+ */
+#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be heap allocated)
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data);
+
+/**
+ * virtio_admin_cap_get - Get capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to retrieve
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size);
+
+/**
+ * virtio_admin_cap_set - Set capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to set
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size);
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..96d097d3757e 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.50.1


