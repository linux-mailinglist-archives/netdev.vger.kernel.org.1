Return-Path: <netdev+bounces-66008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D381583CE44
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014F01C2351E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162D13BEAB;
	Thu, 25 Jan 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDWp+1ad"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7513BEB9
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217160; cv=fail; b=Hm7b/maUqOMr+q5OqWj5yup9WElP0PxwlBtWr1UM/N+dpwmc/0v+VTWA0TMPwdJtgiO9+XqkkqIECnp6kNY5grOZwWhROCqaeNcGd9Y0jPzHJbPmIXnhb4KGOslrR5bqq1BTMm6sCxz75ocPV8XWSwQy8/HTs4mH3ZB+c2ijjko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217160; c=relaxed/simple;
	bh=cEvy3C0HPvmhws+GsBAQcI5Lzg+fnTo73EuJ/HJtrI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa/sUwoXdZ7+M+9aS9c6iODzgCtaTdRJS7MQPeqNcZ3tsyqizn61dA7lBsjsXjE/s/QCh6ZxZyNkqMV8/xTxpBgHhmW606JZ3bVGf/BN9t336UqkrXR6PsxglmZJ6jWvrxTM0VB21u+svZ8k3KsUQhGi75oXZNMO1PukZBIkGKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDWp+1ad; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpwNLj6cLyK0u1iikZ13NM7P9Bte4AQ4YLM8nZb1veyQdZ9mCqE6hSMaz3LhoYzdCFv5OaRhyiP8J7ZytcBCdbSQwc+93cNjkckeDtYYJPhUZ/dUDCk15RUz8Y4OkqSBygrk/ZDi8tdbISLXyDSrCopB3yGNEt7prKnLOp1Su7CA7tMjh7vnAFlo0YHKseV8sX127APPRSosbPv0s2DWJfVSVw7wNfBiK6lH/JqcVvkqBRrkO5yLDTPtBEvPcAYW4dM3Iedik5EUK0iZgh9c3ZyP7I4KLQAGvWtv+uIMVdZtfICnAAnX47CpyZxYilsa1X/fb1+NUtaunK6s3lVJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVvV1OseO5sA3J5Q1Rl/ltEMWyKwnEWuYtQFgamGNWI=;
 b=c+w0UKV60bfB7mvyV9rOcg2rmCHLmBnriOQC33gEVduY4hFFHx3TYQqu1TVVuaIVEyTYZBYhphcoKiy5RxOGjXpIw7YsnAUzjY3WRFIEDH4ydEwpeLtoQ2VYb6EZ7AWQFITKo7TrGSrUto+qQJ3Z/BHrOqlgtBikEmqfJGiM+Eze4/MzV29ceXV9hZBPIcxZhADRqK8Iv+zuSIwnsTvI2XZKaCVzRanTYlMzBwVT3hd2HdjuVAHkxxlgcoTHifHvcAehF+rpFb1GJknkZG/lCnJnpiP8CPz40tix6MnVQUiKwv3hks7O00eYrVzWDb1bAutYIbglN1/HYTGbvKBqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVvV1OseO5sA3J5Q1Rl/ltEMWyKwnEWuYtQFgamGNWI=;
 b=FDWp+1adSsIbV+W1DcYJEXjXK1lGvOCRAooLtCXN8CoUnA8/srY6/42AZferpCZ0Chm4hh/JvWLNfaWEIUDsoHZwnwPTHfTgUngROXtJT62f9InX7oxmY3pIJIsapyKrC4VU8bHdPs8t/YE4u3htKz5mqNQxRCEq8rWQVlVJJelmYo99Xjeiq8oPfXyDzk9yMmQrYTLNsC2BPSQ8iD82I69Uhb1F0uzliKg91V0bTXcIEIHwTy5O4vaNRSnCBlu8FQ+S7CAn/ezH03XBIln9G6Qg6O3cw6gjA/DOqprZRXSI88FR8PRpHAME9Ky0mahr3EPrTDN890pcg01IuOu+9Q==
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by MW3PR12MB4585.namprd12.prod.outlook.com (2603:10b6:303:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 21:12:34 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::53) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 21:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 21:12:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 13:12:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 25 Jan 2024 13:12:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 25 Jan 2024 13:12:27 -0800
From: William Tu <witu@nvidia.com>
To: <witu@nvidia.com>
CC: <bodong@nvidia.com>, <jiri@nvidia.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <saeedm@nvidia.com>
Subject: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Date: Thu, 25 Jan 2024 13:12:19 -0800
Message-ID: <20240125211219.5279-1-witu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240125045624.68689-1-witu@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW3PR12MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e405c9-c111-4477-51d2-08dc1dea5947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sKA+R9WLu3JPRVFTzqMFp86rMkQb4QL77HWR7f8GFCCvmrUViXUtHijut44vFMmMGXm6uoxUuvC8NMYmYR17EGh42yVyw5QeAsA2gNuLzYNitC+rSFsex3EXoBUixcMEygKUSgvpLAG5LzuXz5fISTuizm5vqUHXlKkfhe+Gmph96fESqMTbreVkFIuV6vG2W4PajVX9QKh5ItzfoFChVAC5uWe/fEKM7xtgjIyVqBQgvjsmgUkAZtVGR9y29ZxTwINgP7a53DcflIK2RUfLelHWT8ZVB9br/d/RPe0I37oh+ITVdibzAPOdcqHl6MJJNJ4fZjliB2G6Q/r7UJVXnmR38N8J0B7Iv3erc1IU/yw+W1PiUGssA00JRJw6kRyxD6LsaC18m0uBLGAFG7ccrCotQqMBV6Zq0xsxPlYIB9ZdQs1fhvWjlIDdopiF0takpJxV/i9Wsv05mPXQGe4YIhqwaokB/XEPpzUSaPobEqMVyrl59ST7yTr4NQlH10uohFEJZ6Qs5bt4dqJWk+jrqw/UVzWbleL/hq1l0O3rCEm33tRd4jifH047VtcEQWctJcc5u7ZIhj/Pe++2PnfuTkJ1DIVuN/COwRY4MsN14L7gPeNm/0G2cXG7e32MxaRU6V+/gORiwJL3zuuH0ier5WPawrulL9kINWZ5EBu0Wi/zS5mIha8Ej3PwuJd7F22A0zBd/rjOYiyDKe7rIQJf7ocybSJsV7rbR3a6UjOZJnh/Xq+UElmIghn85J5yYiUz
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(7049001)(83380400001)(5660300002)(426003)(4326008)(70586007)(8676002)(6666004)(2616005)(37006003)(26005)(7696005)(54906003)(316002)(6862004)(70206006)(478600001)(336012)(8936002)(107886003)(1076003)(6200100001)(36860700001)(2906002)(7636003)(47076005)(356005)(82740400003)(30864003)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 21:12:33.5760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e405c9-c111-4477-51d2-08dc1dea5947
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4585

Add devlink-sd, shared descriptor, documentation. The devlink-sd
mechanism is targeted for configuration of the shared rx descriptors
that server as a descriptor pool for ethernet reprsentors (reps)
to better utilize memory. Following operations are provided:
 * add/delete a shared descriptor pool
 * Configure the pool's properties
 * Bind/unbind a representor's rx channel to a descriptor pool

Propose new devlink objects because existing solutions below do
not fit our use cases:
1) devlink params: Need to add many new params to support
   the shared descriptor pool. It doesn't seem to be a good idea.
2) devlink-sb (shared buffer): very similar to the API proposed in
   this patch, but devlink-sb is used in ASIC hardware switch buffer
   and switch's port. Here the use case is switchdev mode with
   reprensentor ports and its rx queues.

Signed-off-by: William Tu <witu@nvidia.com>
Change-Id: I1de0d9544ff8371955c6976b2d301b1630023100
---
v3: read again myself and explain NAPI context and descriptor pool
v2: work on Jiri's feedback
- use more consistent device name, p0, pf0vf0, etc
- several grammar and spelling errors
- several changes to devlink sd api
  - remove hex, remove sd show, make output 1:1 mapping, use
  count instead of size, use "add" instead of "create"
  - remove the use of "we"
- remove the "default" and introduce "shared-descs" in switchdev mode
- make description more consistent with definitions in ethtool,
such as ring, channel, queue.
---
 .../networking/devlink/devlink-sd.rst         | 296 ++++++++++++++++++
 1 file changed, 296 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-sd.rst

diff --git a/Documentation/networking/devlink/devlink-sd.rst b/Documentation/networking/devlink/devlink-sd.rst
new file mode 100644
index 000000000000..e73587de9c50
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-sd.rst
@@ -0,0 +1,296 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Devlink Shared Descriptors
+==========================
+
+Glossary
+========
+* REP port: Representor port
+* RQ: Receive Queue or RX Queue
+* WQE: Work Queue Entry
+* IRQ: Interrupt Request
+* Channel: A channel is an IRQ and the set of queues that can trigger
+  that IRQ.  ``devlink-sd`` assumes one rx queue per channel.
+* Descriptor: The data structure that describes a network packet.
+  An RQ consists of multiple descriptors.
+* NAPI context: New API context, associated with a device channel.
+* Device Naming:
+
+  - Uplink representors: p<port_number>, ex: p0.
+  - PF representors: pf<port_number>hpf, ex: pf0hpf.
+  - VF representors: pf<port_number>vf<function_number>, ex: pf0vf1.
+
+Background
+==========
+The ``devlink-sd`` mechanism is targeted for the configuration of the
+shared rx descriptors that host as a descriptor pool for ethernet
+representors (reps) to better utilize memory. Following operations are
+provided:
+
+* Add/delete a shared descriptor pool
+* Configure the pool's properties
+* Bind/unbind a representor's rx queue to a descriptor pool
+
+In switchdev mode, representors are slow-path ports that handle the
+miss traffic, i.e., traffic not being forwarded by the hardware.
+Representor ports are regular ethernet devices, with multiple channels
+consuming DMA memory. Memory consumption of the representor
+port's rx buffers can grow to several GB when scaling to 1k VFs reps.
+For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
+consumes 3MB of DMA memory for packet buffer in descriptors, and with
+four channels, it consumes 4 * 3MB * 1024 = 12GB of memory. Since rep
+ports are for slow path traffic, most of these rep ports' rx DMA memory
+is idle when flows are forwarded directly in hardware to VFs.
+
+A network device driver consists of several channels and each channel
+represents an NAPI context and a set of queues that trigger that IRQ.
+devlink-sd considers only the *regular* RX queue in each channel,
+e.g., mlx5's non-regular RQs such as XSK RQ and drop RQ are not applicable
+here. Each device driver receives packets by setting up RQ, and
+each RQ receives packets by pre-allocating a dedicated set of rx
+ring descriptors, with each descriptor pointing to a memory buffer.
+The ``shared descriptor pool`` is a descriptor and buffer sharing
+mechanism. It allows multiple RQs to use the rx ring descriptors
+from the shared descriptor pool. In other words, the RQ no longer has
+its own dedicated rx ring descriptors, which might be idle when there
+is no traffic, but it consumes the descriptors from the descriptor
+pool only when packets arrive.
+
+The shared descriptor pool contains rx descriptors and its memory
+buffers. When multiple representors' RQs share the same pool of rx
+descriptors, they share the same set of memory buffers. As a result,
+the heavy-traffic representors can use all descriptors from the pool,
+while the idle, no-traffic representor consumes no memory. All the
+descriptors in the descriptor pool can be used by all the RQs. This
+makes the descriptor memory usage more efficient.
+
+The diagram below first shows two representors with their own regular
+RQ, and its rx descriptor ring and buffers, without using shared descriptor
+pool::
+
+      +--------+            +--------+
+      │ pf0vf1 │            │ pf0vf2 │
+      │   RQ   │            │   RQ   │
+      +--------+            +--------+
+           │                     │
+     +-----┴----------+    +-----┴----------+
+     │ rx descriptors │    │ rx descriptors │
+     │ and buffers    │    │ and buffers    │
+     +----------------+    +----------------+
+
+With shared descriptors, the diagram below shows that two representors
+can share the same descriptor pool::
+
+     +--------+            +--------+
+     │ pf0vf1 │            │ pf0vf2 │
+     │   RQ   │            │   RQ   │
+     +----┬---+            +----┬---+
+          │                     │
+          +---------+  +--------+
+                    │  │
+              +-----┴--┴-------+
+              │     shared     |
+              | rx descriptors │
+              │ and buffers    │
+              +----------------+
+
+Both packets arrived for pf0vf1 and pf0vf2 are consuming the descriptors
+and buffers in the pool. Once packets are passed to the upper Linux
+network stack, the driver will refill the rx descriptor with a new buffer,
+e.g., using the page_pool API.  Typically, a NAPI context is associated
+with each channel of a device, and packet reception and refilling operations
+happen in a NAPI context. Linux kernel guarantees that only one CPU at any
+time can call NAPI poll for each napi struct. In the shared rx descriptors
+case, a race condition happens when two NAPI contexts, scheduled to run
+on two CPUs, are fetching or refilling descriptors from/to the same
+shared descriptor pool. Thus, the shared descriptor pool should be either
+protected by a lock, or in a better design, have a 1:1 mapping between
+descriptor pool and NAPI context of a CPU (See examples below).
+
+API Overview
+============
+* Name:
+   - devlink-sd : devlink shared descriptor configuration
+* Synopsis:
+   - devlink sd pool show [DEV]
+   - devlink sd pool add DEV pool POOL_ID count DESCRIPTOR_NUM
+   - devlink sd pool delete id POOL_ID
+   - devlink sd port pool show [DEV]
+   - devlink sd port pool bind DEV queue QUEUE_ID pool POOL_ID
+   - devlink sd port pool unbind DEV queue QUEUE_ID
+
+Description
+===========
+ * devlink sd pool show - show shared descriptor pool and their
+   attributes
+
+    - DEV - the devlink device that supports shared descriptor pool.  If
+      this argument is omitted all available shared descriptor devices are
+      listed.
+
+ * devlink sd pool add - add a shared descriptor pool and the driver
+   allocates and returns descriptor pool id.
+
+    - DEV: the devlink device that supports shared descriptor pool.
+    - count DESCRIPTOR_NUM: the number of descriptors in the pool.
+
+ * devlink sd pool delete - delete shared descriptor pool
+
+    - pool POOL_ID: the id of the shared descriptor pool to be deleted.
+      Make sure no RX queue of any port is using the pool before deleting it.
+
+ * devlink sd port pool show - display port-pool mappings
+
+    - DEV: the devlink device that supports shared descriptor pool.
+
+ * devlink sd port pool bind - set the port-pool mapping
+
+    - DEV: the devlink device that supports shared descriptor pool.
+    - queue QUEUE_ID: the index of the channel. Note that a representor
+      might have multiple RX queues/channels, specify which queue id to
+      map to the pool.
+    - pool POOL_ID: the id of the shared descriptor pool to be mapped.
+
+ * devlink sd port pool unbind - unbind the port-pool mapping
+
+    - DEV: the devlink device that supports shared descriptor pool.
+    - queue QUEUE_ID: the index of the RX queue/channel.
+
+ * devlink dev eswitch set DEV mode switchdev - enable or disable default
+   port-pool mapping scheme
+
+    - DEV: the devlink device that supports shared descriptor pool.
+    - shared-descs { enable | disable }: enable/disable default port-pool
+      mapping scheme. See details below.
+
+
+Example usage
+=============
+
+.. code:: shell
+
+    # Enable switchdev mode for the device
+    * devlink dev eswitch set pci/0000:08:00.0 mode switchdev
+
+    # Show devlink device
+    $ devlink devlink show
+        pci/0000:08:00.0
+        pci/0000:08:00.1
+
+    # show existing descriptor pools
+    $ devlink sd pool show pci/0000:08:00.0
+        pci/0000:08:00.0: pool 11 count 2048
+
+    # Create a shared descriptor pool and 1024 descriptors, driver
+    # allocates and returns the pool id 12
+    $ devlink sd pool add pci/0000:08:00.0 count 1024
+        pci/0000:08:00.0: pool 12 count 1024
+
+    # Now check the pool again
+    $ devlink sd pool show pci/0000:08:00.0
+        pci/0000:08:00.0: pool 11 count 2048
+        pci/0000:08:00.0: pool 12 count 1024
+
+    # Bind a representor port, pf0vf1, queue 0 to the shared descriptor pool
+    $ devlink sd port pool bind pf0vf1 queue 0 pool 12
+
+    # Bind a representor port, pf0vf2, queue 0 to the shared descriptor pool
+    $ devlink sd port pool bind pf0vf2 queue 0 pool 12
+
+    # Show the rep port-pool mapping of pf0vf1
+    $ devlink sd port pool show pci/0000:08:00.0/11
+        pci/0000:08:00.0/11 queue 0 pool 12
+
+    # Show the rep port-pool mapping of pf0vf2
+    $ devlink sd port pool show pf0vf2
+    # or use the devlink port handle
+    $ devlink sd port pool show pci/0000:08:00.0/22
+        pci/0000:08:00.0/22 queue 0 pool 12
+
+    # To dump all ports mapping for a device
+    $ devlink sd port pool show pci/0000:08:00.0
+        pci/0000:08:00.0/11: queue 0 pool 12
+        pci/0000:08:00.0/22: queue 0 pool 12
+
+    # Unbind a representor port, pf0vf1, queue 0 from the shared descriptor pool
+    $ devlink sd port pool unbind pf0vf1 queue 0
+    $ devlink sd port pool show pci/0000:08:00.0
+        pci/0000:08:00.0/22: queue 0 pool 12
+
+Default Mapping Scheme
+======================
+The ``devlink-sd`` tries to be generic and fine-grained: allowing users
+to create shared descriptor pools and bind them to representor ports, in
+any mapping scheme they want. However, typically users don't want to
+do this by themselves. For convenience, ``devlink-sd`` adds a default mapping
+scheme as follows:
+
+.. code:: shell
+
+   # Create a shared descriptor pool for each rx queue of uplink
+     representor, assume having two queues:
+   $ devlink sd pool show p0
+       pci/0000:08:00.0: pool 8 count 1024 # reserved for queue 0
+       pci/0000:08:00.0: pool 9 count 1024 # reserved for queue 1
+
+   # Bind each representor port to its own shared descriptor pool, ex:
+   $ devlink sb port pool show pf0vf1
+        pci/0000:08:00.0/11: queue 0 pool 8
+        pci/0000:08:00.0/11: queue 1 pool 9
+
+   $ devlink sb port pool show pf0vf2
+        pci/0000:08:00.0/22: queue 0 pool 8
+        pci/0000:08:00.0/22: queue 1 pool 9
+
+The diagram shows the default mapping with two representors, each with
+two RX queues::
+
+     +--------+            +--------+     +--------+
+     │   p0   │            │ pf0vf1 │     | pf0vf2 │
+     │RQ0  RQ1│-------+    │RQ0  RQ1│     |RQ0  RQ1│
+     +-+------+       |    +-+----+-+     +-+----+-+
+       |              |      │    |         |    |
+       |  +------------------+    |     to  |    |
+       |  |           |           |      POOL-8  |
+   +---v--v-+         |     +-----v--+           |
+   │ POOL-8 |         |---> | POOL-9 |<----------+
+   +--------+               +--------+
+    NAPI-0                    NAPI-1
+
+The benefit of this default mapping is that it allows the p0, the uplink
+representor, to receive packets that are destined for pf0vf1 and pf0vf2,
+simply by polling the shared descriptor pools. In the above case, p0
+has two NAPI contexts, NAPI-0 polls for RQ0 and NAPI-1 polls for RQ1.
+Since the NAPI-0 receives packets by checking all the descriptors in
+the POOL-0, and the POOL-0 contains packets also for pf0vf1 and pf0vf2,
+polling POOL-1 can receive all the packets. As a result, uplink representors
+become the single device that receives packets for other representors.
+This makes managing pools and rx queues easier and since only one NAPI
+can poll on one pool, there is no lock required to avoid contention.
+
+Example usage (Default)
+=======================
+
+.. code:: shell
+
+    # Enable switchdev mode with additional *shared-descs* option
+    * devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
+      shared-descs enable
+
+    # Assume two rx queues and one uplink device p0, and two reps pf0vf1 and pf0vf2
+    $ devlink sd port pool show pci/0000:08:00.0
+        pci/0000:08:00.0: queue 0 pool 8
+        pci/0000:08:00.0: queue 1 pool 9
+        pci/0000:08:00.0/11: queue 0 pool 8
+        pci/0000:08:00.0/11: queue 1 pool 9
+        pci/0000:08:00.0/22: queue 0 pool 8
+        pci/0000:08:00.0/22: queue 1 pool 9
+
+    # Disable *shared-descs* option falls back to non-sharing
+    * devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
+      shared-descs disable
+
+    # pool and port-pool mappings are cleared
+    $ devlink sd port pool show pci/0000:08:00.0
+
-- 
2.37.1 (Apple Git-137.1)


