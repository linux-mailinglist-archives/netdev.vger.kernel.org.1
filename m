Return-Path: <netdev+bounces-84860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DD898820
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3722AB2D06A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0682D90;
	Thu,  4 Apr 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b90y8IRn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB86BB44;
	Thu,  4 Apr 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234302; cv=fail; b=uJHi2CN39/TNop4B6aLQDOhyFsbnwNRtrBM9Qt7LMybcXv1mntwox3KlQRt51juxCTTHKS5uXpirldo+6wiWj9mIIUvEMcXO1RgkTodh6TPWWNjNLAxqrcJ2O/CDM8oEpUOKk4Gm84X27hX56IfJ8YF+elea8DQukP/ah6GrfrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234302; c=relaxed/simple;
	bh=KtnZiRdY4hosHW0L1k7xjQ7HFEcT1zBfA0bDJAUGQLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpBEHJj6mdLZHilYy8LjXfjdV4MNGRSJe8wYLOpsE6XGm4yE23wr3k6zJv8SYZo3Z2u4t/xURdAlJPvZNQf+RiX3EUtqHFQKTyHVF7DyFKMKcVpPNA3Et0Dn8u02ss9NgaXVDRu/OlYCO1tzBDQz9EhdtCB/tiFL/Df3u9oEUFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b90y8IRn; arc=fail smtp.client-ip=40.107.236.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYbPBhAYtxntobJ6/i/zPRwtDQEzGYYCunH50is0kaolIpV/40IRe1kYgKCttlQtKklWZEAQUzrqr2oMTN1H4HNs99ZFiMCYIw9ZtsnTvGQdo1uQCEv1j/vlo1TDcGsY7u8kXiEwkcfAjlSBS/C344tWMU1WcuXakgqgBGDtTMV06Hp76/Un1Hnm3m3ppWhRbGkNZ0gkoLpXFEi9y9AxUbhxRFiPj6tPdMaropFlEcyle9eaVnfczYO8OoCwWPbFBXbAHlI+Er+oWiwAaXohUzLLHnDZ6XoRWYlm2UvGulRn8862/Ix3OjnMui4TDTrSWPNMAtco8kto8oG/6aMMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRjcFhRePZFdmHH4YBz16h+3EVEEeKyJg9+kCwABFOg=;
 b=JeDU6Q71x02G95iOkuxbd8V8s04AIdPnBLW1WZm+20338BQOLo8g49NghVhRi8lhGCLxmu+vrZutZp8EHgGiBOin+qyfBHSQ8mRr6jAUth60J7vWU6s0gg3dVcfd9KT6OVDACLFH/nONAtPrI/W06t690ZAxBnHjEt6ilUSsBXDUv6kIfzjS47ZIrTXltEBnB7r88wlrUvcqKX20CeW6OXe9aamH4M2zzpxQNH6N5q+VMvwFi3L0oR56qnaxh0k34YxpDf93EKXij4ldwFpERkOdqEm/tBxvyQ7qKXubZFmC+DxtVLnxOpzchbpsJTC9c5/f9wEjfp8QxgL4M1jjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRjcFhRePZFdmHH4YBz16h+3EVEEeKyJg9+kCwABFOg=;
 b=b90y8IRnmt79fh/IfkfqI6nQhZ5mF9WGqUQssboypz+VX2+BU0HdTHkxCZ0hlDtIyRgowOlN5k0IcNmEQRbL7tSjQ5qA0u9wqfz6345cgpeuN4+KhtIyiJ45pxVQAHLXbao/me5X2bUrm/4xEIVCXcXTdWRBjtW6D6AkoWoAuA+pMhgMqdapLEbaDmKj6jjPfA4DxkITcGGLixp0UddRsH1+0fuEKaIpnU6mApM1MvTzrSJ4UJqNbaifDqSn4HIyqRFm7DYHnaEzuQ7zZP4OSQc48rW0kNkZ4ww82w5CWyA3pLjAZDuNrTdNIPcmUmU0stVnuUByOLBQGdnzavtYrQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:38:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:38:17 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v24 09/20] Documentation: add ULP DDP offload documentation
Date: Thu,  4 Apr 2024 12:37:06 +0000
Message-Id: <20240404123717.11857-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZQuD7tjdlh1lflFnC+IlYXGk4wXJpCMfhBwxKsbCAaCewDpcRR8X+34t67scELKsRcXbbglzg5M8lx65MQz39bXcOmK7jEE3hOOokNLmZj7HePmOnzZGcpaniv+J7dkSAWYOLnDMiQBt/M6Tb3RaGLQcmIVkXE9je9N8Vl5GjsY40UTu6mA0SkWrdlcL1SsofsdC7So65woPkWKflvMpb7Tay1qr4+QB9S9zwaXKisYXvhIh71UE7hafOQrR/3H+Mvb8JpGqd7/Qpi3c6CUVDa94CM0ZBGny8HkcpctnIzuvfliK6GIHJ5QrJ/5Ui8qgZtE02SL1jFsvZFJs9T+z8PccCIkZyWOpP6X7aN5mnTb42ZXIKBLF40mh1koin8sG2LdNdjqas3pApCVfDTaA2S30SRPfUYyXCEagCY52S/4ARw286tdeCQXAxXYBJiChFsFJU0A7jHc8WE1qv+z2MUbgo/T6wblnsEqfBODBHrNlMVW9jOsoe0rbwmXRJCeV0SaLasox2UJxKUUD34Vf1CQsLUuThoEXQpILeEpfxizaK9wIFmC8oC6iVrMFc3JuhZ3TPWKOFsUwHHpX7Pkn7pLEhuZ23Z4vNrjsPAZS0rVmNKz1K6V+VlM4B/ICkO2P7nwDpezI5KF3A5HencaZh9Mhm6U4gBZ+D/VNJMJVGcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EaCngvtVRCpWTyEeZyBi+ZcLCSlp/kOZyB0hEsKv5ur/s22gZH3EPJaWBR4/?=
 =?us-ascii?Q?uJ+Az61F3su6rEIsY5QJoub2OEOhA/6A9fIDV8k3/kNWzSAcc4TFqUtgwZTr?=
 =?us-ascii?Q?cmzTBbA022jdPAs0Qe3tqwO4TLaHtfXDcJ5witCEWtUQZS8xAcx3quvAfIIX?=
 =?us-ascii?Q?+Lt0sI1jmonhJBukxj1KsxQI6nCIDs+poiPl6+JkxUY8efhpj0q9XRn9Ip7q?=
 =?us-ascii?Q?ZcRLuSmywIv+azSbuQ19HrKRyviBsbZDbZkif15Gkprr9C46/d6B/6czgkrD?=
 =?us-ascii?Q?lzrxM+J/xe9znYj3L0yQ8tG9UK8FzTidZn89qBaO8lsq8S1W5ek2uA0uAk+x?=
 =?us-ascii?Q?E65WSgEVGHt5mYZYdDxC6KvCuZr08ZCAtAVQeMqRmv0J2tB/udzB6j9IPAxJ?=
 =?us-ascii?Q?2TjDHciDHL0/60ezlH6l0ch62AbpFFvV4PxhYVFEOnY5kBxBnrge2cCwg9pE?=
 =?us-ascii?Q?vdtwKwymqv8R9CoVxqbfwibzcZOZ+DuudJbVSk6f6ie8KqyVNGxR/T+HF6+g?=
 =?us-ascii?Q?PuEwSW3+yMW0J5TAA+ObNxmRb/y4zDp78mgcG7itPYSNThffI1veb7eV+mk8?=
 =?us-ascii?Q?uybzqWjbsOwYDi0Xj3L2jq6gXVY4ZFglvHzDHs36xQrpByimCCHuul/voWqH?=
 =?us-ascii?Q?QeIephI8r1rQuPG/av6eKSWEfP/98TdtLiFVsPz9xXkh6AtgITfPHbWtLq56?=
 =?us-ascii?Q?tZyrm1tz6tBHVqD0ivQdazdNPI0E5yQNl+KSqGB1YNO0Lgh7I1OsVlJ6xKLY?=
 =?us-ascii?Q?zF16lQEEfDHoicPu3b/x40FYjAhpQaQxUBTu6qzrPeDJh59YruzlbhyzgcqU?=
 =?us-ascii?Q?ICkKGTvmzeygOb07kpTS39HXv2YjlBculgOpD9altBbwSmwMZBKn+gbuB0hW?=
 =?us-ascii?Q?zqXUSmF7yeD4ifl7pL6N8byXUwjkV9strmF+hgePWVjsPvde8iCwX4jmqNP1?=
 =?us-ascii?Q?77ADrSRyVgEGJp4wy4c2SlKZHkNWlU/5Odb/yEiY8aOHB3Qq2Dvk01pzQ9Rr?=
 =?us-ascii?Q?XRQDnGMFgPOmktCMF4xhl8hIKNZwaOHP4ZUgRQC7s0JTtNykjuTMfRInRZ1T?=
 =?us-ascii?Q?g8XBLwJlrNhCOInRg8mIGdPvQc0lU8X2xxaUKQXr0YAKCsf7+N3+cM9Ja/yP?=
 =?us-ascii?Q?Z7de0rlCb+WXLn9VFSDstc2C1kjMXpJ0tiWwoyLyOXUz7sd9IOysTv56oSM4?=
 =?us-ascii?Q?f7PSd0p7a5okPkwFlhNpY1WUGnbklIFTpxheaFdXnAo5OP3fA5r4PFoNdx4E?=
 =?us-ascii?Q?lrqaUaVcio4KfdHsSvaggpHPKNROK0QjZy1ojkQmQ7W+NiZXDCX/ftTru7m0?=
 =?us-ascii?Q?o8gNUe2ftW9puTBLb93gjConeFn6QJxSZVuWD4Dp4FTtnzVRrqzwSbnJQZ5k?=
 =?us-ascii?Q?HJ/KFjnsI/+PjLkN4XtelZjRgmHoATJbOqRmE+LY9jiXlqekBHQAuw7fGQGM?=
 =?us-ascii?Q?gYXeAvBQ1eBfv3SyVoqXsafn2zjSf0+TdLHjAgSezb8iVs+Pey1sdv4m/ZeC?=
 =?us-ascii?Q?gETwaT6H6LODgxflqwly7Ovk+7+qp21laVl5detSU5zR+rIiOmF1+TmdEhaU?=
 =?us-ascii?Q?p1e6I+XK7rj78uI+1tk7xg8LQLX0+hX9FMbdZA5I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a73139-5318-43f4-e683-08dc54a419fe
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:38:17.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoAixy+0rFjWO0mXakl5QVzLcDeN3dOAqK5ZYK+fbxhb3i8OtXaE2ntI83t51PBfUcN7yBdqu9t5dN5nJp6RGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 473d72c36d61..77d69aa68f4c 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -111,6 +111,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


