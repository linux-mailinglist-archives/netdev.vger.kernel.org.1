Return-Path: <netdev+bounces-256844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCJEFtHKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2581ED059
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3503013B77
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFA34C81E;
	Wed,  4 Feb 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gk4+EdTk"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636EF36E497
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244813; cv=fail; b=cJ9MphR52dyQ1jLZApq7hDyb2hQVPFyKwIN/7l2phy8NcCwuP31X419Wz0LUwl96nvIdL3KfjAuy/tMRYKa8FBjoCFVKIzz7s6swnSxjJ8aAmKPT1TlA9u9CQFMqUWShFXu58C7Xm+kNC8ghd5AHB5SnbLVxLAaHop2lVv6/pXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244813; c=relaxed/simple;
	bh=t2FrcKiaN++GEbf6PPdtMeEU3iJH+lARm9vGC8IeWSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azgqihFQlJ/8jIGGlkm21fq4/35kuemf38Q69QGvS/+YvRrYQ2FaugmG23Izbs0ojwMn3KXZPNTiyFwdDZB3kmP5yg8wuwAsqB6CeDV4PBqUBWebVOLiUJIi9LoVd868WT5Wy/N0ysNcP8gJbd3sux5gxlVCHazE06pAHsgA8iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gk4+EdTk; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT2Z7XzwrMZkXysO+CA8Aph3zNNkqMedDf3lZaFy9M+xAlbWdGgYH7d3UuDuQkWS+lHMOj05FlAE8jzmP2qL4MV3ek+EKwkKOa75AJJDPqMNpCcnDvRYE7zuUvp+tSOzvWv12mc388HjffyY1fJ3xDI2PcRw8bZIxkpl7oRHy1w5hJrnn4CBrv3t53bWIjaYDH2DulPjfqf+YxTSVWIyvwqZsG0XlxVNQCfcPB+7rBiytSLxLuVevfacHfK+U7enClGBDlyhTGw/w2TNql/wZYbGt3D9YPru/op/3WSKS27Mu2++GlVMHTB3Zc3dQAIZkMTxWJKXwsnpN4hdaQJDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=WXzkfeC+HZo/bOTwb8QJEhb+lqmMkoE8JtoCp9nCiLPAnxFTPuF1Uu8goLeW3K/3nfPqilbClEBBZWKi3OJ5AMUkuj0ZZiaO3vcadq9jEqttwkqRSTWgqZXdHWfNabU9RXpWclyAqp2zEAdBYswRNzG9jgWxZLN8Rf4+IY8eL23oa72ZD+AcaUP8aZIEJ6RQxHleDB8VokOlvPn5gaVPO3txt1qGIByXQqavKesJyYmh5dUh5HujMZDxRn8zqrpBKlyWvjNuxi8Lm46YQ6VzO3o1YZpTM4u74NXQDHCHPMoWqiobfUAlUh0jRtCm6dAk3FHWmnENSFYc0Ejea0kLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=gk4+EdTkE9sErRx5t+/NIuDBv4/qpM5ESLINSfjlvs45sskgLQOxMK6fXXz9IpQy1yNHGRvIwQodmu5GY/OusTrIOOWwE9hA1TCVFBLW8rhwgEcSB4YszkEGNr5qgJpDy56kfYYn5m5GAQJLHrdZ91JzJfkQpZdhKJ6TWQ10hbGSv92l0EV7tf1nI4lJRrh/gz27XAma2LKs7LCSCoYiJfQroFmAlqRN9ZfkactG8xtD4FohFDLW1nPfWqxpYAdjrdURE9UyrA+VeQQ3ELmJ+AZF3ICLlhDWWeUo5bvH+qER1dzgyYE7pilCQkMn9Z5KDSegs9T4w1/xcZOm1OSQFw==
Received: from SJ0PR13CA0119.namprd13.prod.outlook.com (2603:10b6:a03:2c5::34)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:40:07 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::fd) by SJ0PR13CA0119.outlook.office365.com
 (2603:10b6:a03:2c5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 22:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:49 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:48 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 03/12] virtio: Expose generic device capability operations
Date: Wed, 4 Feb 2026 16:39:31 -0600
Message-ID: <20260204223940.39581-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: a9194de4-b288-4ab5-31e5-08de643e5894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMPEPw5ucnPCYFlm1q/NpZA15HC+SI5mJfEQ9asz3Fn7Iek+DkJdMw/vxyEh?=
 =?us-ascii?Q?R3tQgZUyG1orii+6NhvrRnXNZe0+I7+0Cu3kf2nzR5E0VW4ZNbYL+H+yNNcl?=
 =?us-ascii?Q?NvEtkJdDFQWJQTLEdaRbjAkX6SJxfiOW6YKbOK9go9xmUthMp7KM/SpeiZZk?=
 =?us-ascii?Q?4GHUglrzZGk1hrVTRAzlWgs7Q/jsSYofCjkb7vYURn0GQEXx7QCsI2Ho7aB2?=
 =?us-ascii?Q?1YwBc7DUzlIqpXPyLwygUBrl+7rQTnfJe/OBPKyvGxZ+LKOC1HBr+oPRjJO7?=
 =?us-ascii?Q?qXADzq4q7ISlkfwskFoh9IOyogPg5G6EP2FkXuebdwVFaNtbAD6uALMj2hDk?=
 =?us-ascii?Q?ixpBCVGaHo3BPQTB5Vpd6BMWiQqkIJagZVU0nl/+NPj9Bn4CXk8cDXmnH990?=
 =?us-ascii?Q?rKlcX2pHK28cV29/FyVY2wrhbhnjRGGy5hUFh1yvpYOmWI2DIbjewVx8bHes?=
 =?us-ascii?Q?PcIIhAAQ0xvN37Aj0tdvWoC3FAziwhVJKa7UPViGFlNGQN44sEPkO4l14n2k?=
 =?us-ascii?Q?VLOBsASGQFeYxzRA33n0g0xkm5n8H/VuRmTFGjBRNc7xUhvu+/YdOfyhfZWB?=
 =?us-ascii?Q?0JZsLD+HOhiALttARaCpEWiiklOkdm3eHXNYzVGhECHLIKnxP3jgW4LZJOcg?=
 =?us-ascii?Q?w3OHM5N8FmvlPkLrxL3GUgnDFEuq0POVtmyTGdH0/2GUu1r9wOHBfCCBKbEc?=
 =?us-ascii?Q?5lto3y8xhaeCD0u9tvPg6d4fASSoahh7uSOyNxX6DG8U8n61LLnZPEErBsSO?=
 =?us-ascii?Q?Xl8+/Ak5LElU56+c9vV74k0k/PafG5evCdgLUKrHQLoOrSUdoQq+BzNwKwds?=
 =?us-ascii?Q?sLiZ208+N5Yyse0InZp14bVCBZgPL3GloI0kWpC/RZXZ1gUz5SYOEB+3EZKP?=
 =?us-ascii?Q?lBjhNgzcIxubHn9lof/o7cxLEmjVy1jcDNpC+x4Zg6uJ+YLM/kB6UqPjwirQ?=
 =?us-ascii?Q?a+orXoGnOBAcaBFU6pkeJrwDe1VEVRDNCHVvJ28g3NlexIMbfPEWbJlLbcj1?=
 =?us-ascii?Q?ZMbLIAyfgK/ziJstsS6SLSA60MXDK7biksXXgEoABhrMNzdpsXEfuaQRBb1t?=
 =?us-ascii?Q?NJH3TjS9y+kOk2FYiHmfBBDHOAa5dSidKRD/Ds2P7iuRME/JqrC2AlM9OukO?=
 =?us-ascii?Q?PPufLJGRxedcakwlBeRXTlswJdVHMN4TFyOlV5ThYQZdR+JDi2o1sgUAXye/?=
 =?us-ascii?Q?DbAphVjYMWiO+YX2MG/oB0Z0PoWEk/ZiH2YDu6VjEi8HSqicFmMrG6okpEsc?=
 =?us-ascii?Q?ceStOyj5Gd6mIFaVmjiR7JFAeEsnydb9LYI9Qv3dJDac+qghG09fDY1/370G?=
 =?us-ascii?Q?NRb/XzGrVlgfLaTFr8xBTIAIt2o+autHcqFkJO0PwJ2q661wjTzSZ25fAn72?=
 =?us-ascii?Q?efS2lCVgOzS8mA36bSOs+6cH6pagfuqNAnIMnStzxQhKSFfKExWUT5E8CuTh?=
 =?us-ascii?Q?BvshdobIqLO+JteFlaSyZdBqUOg88LQfglX2QkoihKYdZasRtmYTKKodJjy6?=
 =?us-ascii?Q?yhzlZxc5Wwu6DEaRPvVIUexyv1zeOu10ZSTftchb4G09SWW0iZDeI9+ZgeF6?=
 =?us-ascii?Q?TNUOyHRig4LLB79qUz4+2sUf2AETRIDpcEOc74iYcdnHMziCYx7aQ/mRTzFg?=
 =?us-ascii?Q?UC1ceEVfHrcUHihZuVETe+azzH6YAXviKUFBXKZ5eMvszf7AM0nQHFJTN59k?=
 =?us-ascii?Q?eb5nLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4MsgCTsaVWWp3UO5mu4MdT9XlcEMGRNdnuSPuj5U0H9XaqNoMAeoc9RmjqUeYQ7iBnFD/1D99BFMtks+ombos6TSi6jbB7lhxaj8cEIaIzWggHugNXXnsCAgJLuq2NaFmHBW9wG+wY69wNwQtu3B/TL6B+v54p+q+tGNlr1lKZJax1iIoDBPxr009Qw5pUhX8y+b4aQwvXBVhAr/BOgaGlL1R3TXOKessuonWRwheB5SGek5G4QdTwwficvQZEDJccWaYp3YEW0C9THzwEivuw1wyzqo2S4F5SHR3sS/mWNLB13T9wnvE7ERUGVZaNUBNVW+46cGH+ocmTs91TH93PYbEwXy0Te5+DpzixC9VVVNA47+HD2IjQ8jCu8iQLwOAneOl/3deOGLXHMQunKLRIQ7iUGBOdeA4gmGkrOhxXIjAIAmiRZ+4dmXylsJ+g52
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:06.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9194de4-b288-4ab5-31e5-08de643e5894
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
	TAGGED_FROM(0.00)[bounces-256844-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E2581ED059
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


