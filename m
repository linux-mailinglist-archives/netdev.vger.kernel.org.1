Return-Path: <netdev+bounces-65745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4883B8CD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 05:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E1D1C231CB
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9179C7;
	Thu, 25 Jan 2024 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8Y7TnSJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60901FAD
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158611; cv=fail; b=F3bEu+GTsYeOiIi50Bu4LrDBPiq7WI/YGtpwGEU2c0lsna12u/YsPIjvqDmwVNPb6UBtFr9OdoRxzbmUvJsY7i3tGcOIA5FdqnNzbTg+HsUO5aiYYGYDpfloQifA7d0p8DOBgznDTikuFoU4xvGKBK0sQgY9Zolzr91qIw1eTD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158611; c=relaxed/simple;
	bh=ApwKwNcJmppz6oD+QJ07c5iJnEzpN0ZWSxnvpdjLT3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZa26rICJBByyPIRp6EimJGCHKh0TTk4+4emy5DiJnurnyqiAOXaxvT0mz1GY2Lb8xJ7rNg4oB3ZQAkNODvbeLQ5/negsTdJUYRtyXEOIjwdvcYrAIrm4L0uj01t2ViKqFrkSxM59uGdLImnl5qWqWFFUJ1TEVpfDldCc9EU/1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8Y7TnSJ; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5H66kif025d0S6q81E4isk4rtR7jrI+neN9YH0h4M7Vv1EXGofqE7KiRvrbZFByJpFg/dXZp8m1YpRWfXrWRwX3Mk5sWKvBpyPOwXSSUGd7o9w/r8tclTfgj/uy9DLv7j1U+huLq4GMRRveCgBgiynL9Gs4BBJYkrSZ9E7Apy5q07p8u7I7dpBMpXxeV+QVpxYzONJnyPYsNkaoQhNGC/xOlBfMUwpniAi6HNqheXu6H8sC2qIk29gMuvJ6JG6fWscahr4jTkeLgNFgAyu9s6u+XIveVQLla13zbkSFiMQ/cRWOnKuyGdMdO8sAGpptCUufbN49ajsW/0URhDTrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyPEVGaVNJoTyB4jFzWnbJ2UCYRR9IJydCyIUQTt6+Y=;
 b=RJG2LuUw+UptiGEt3yXOJWIVT7w8f84Cq0ZltsM6rzD1y5+i1b8lYETT6BwJGtbXK4ur6By9hgRzrE5IGAPCLR6cjCO7b5NwxeRcvktB7sQMY2nMWh9+2iUPrxLukNYxHL3Svg5f+9r6p+CsX98V2JS45ravCBHlX1qCBjiG6+oqBMrlbaAMAeKI7LTKpyT/0lNil8a6bfPkNFnf+hPdFFR6l9AqgSCIUAKWRYcnqrU4vVVEViIp6rvyzjNNpXhhYjxV/enZU7JSNOx2NlhjVHT7OYPR14Gp0+Igc6Cr5sAF6H/Td5ttpLJ0jCtmQbaKLkHeBd91yj2pCSMn3GN4bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyPEVGaVNJoTyB4jFzWnbJ2UCYRR9IJydCyIUQTt6+Y=;
 b=M8Y7TnSJAbLkGTciQN7btROzer8EUiwXQrl9jygGXMAwo50dP6DzWz2u34JOz481Y+dZvuDUvWih7bj9H/k/6fdfsOhp9R8JbAo+pwtlCiW7MsTHsFXfvqy8ueNmWyc1u0pPaFl34x0nm8jaPO9/Ogw3FRMMO9wd0ry5i1CsWgj5PdUAhhwSsJYN+SP//eSgHWZdTpctQdgLvG41QIRFi1zpvusNlc8VIRLw+VALLr4iLBBjpuR7hj0wqcLcKPWxQCO6rEheDAx7vR9bxgqpBJTyCbV/Xuf8hhKCns+FX5oA4ElZfOPGJiyy1Sj1H35KvB2WYNkNnKGuRLSL8G9GVg==
Received: from CYZPR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:8a::6)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 04:56:46 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::ce) by CYZPR10CA0002.outlook.office365.com
 (2603:10b6:930:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 04:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 04:56:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 20:56:31 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 20:56:30 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 24 Jan
 2024 20:56:30 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: William Tu <witu@nvidia.com>, <kuba@kernel.org>, <jiri@nvidia.com>,
	<saeedm@nvidia.com>, <bodong@nvidia.com>
Subject: [RFC PATCH v2 net-next] Documentation: devlink: Add devlink-sd
Date: Wed, 24 Jan 2024 20:56:24 -0800
Message-ID: <20240125045624.68689-1-witu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: ac09de40-93d5-462c-c73a-08dc1d62088b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Td869DWGZahpdmNeJrU2SU5nU5jAhfCt1Ne7Cz9KgzqWRo2wk/qgBpi+kEacnZdYFcj8nPS3ZkQ9K2y7BSQU6cghfMpx62szm6ilytFYU0m6CAOA2M2r8Zg1irTAbGvngCVNo/ezH10lCIiyYiErnnoFLhlcxkFVQG34fatMdlzX2fpiR9BDgwJxrtKIOeI92UCezDfCqnOT0VEN57oejCbWZ5fVBl6U1K5ovp47hKl/6BH5YzzlV5Ia89sOqYLAIj8jAR7heACm421Fea6tOVjY7vqgrsWp17KDH4dbB9RtZlgt8ZwDHRBnCN+9CP3n5Bfo8tLRoTBLxFIM7U0MrTUDH0gXmX3AitHSbclPVPw9gV0D7uwFMloDNKyNd2gEWlUxDUXPDL+7YiTTRPCVTBSolxz2j7DS2QxSxhKkzD+5/5ADr16h2iTAkUNft8FApRi0Ojz2fjw+blAjA5NEeuRiOlGDZN+7rWZIgYGbXyv7/Bcy1dLxacIyJjXd3LV3fi77w41gvZT90qWYKG6WTnS1eUgRXG19sqzOvTy2GYR7768+DppgLDJ5zdFRQBk2i2xbatXxm5751P12KNetgj4jcqN4Hn0+X5UTbrX4NxVuPTrNzkiUtiUcHU4b+FR2/XUiLU0aqUsbOGqqpauIucjdbEkC6DO17CDdVmptA+FAfdRnPx46cbUSmSaXrHWebVQNMI0KlFjYEWAAbjceZJjZ3piav+d+2xpi0ja9Z4WD8q7EXlz4rL8z7UynHqLC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(426003)(41300700001)(1076003)(7696005)(336012)(2616005)(107886003)(30864003)(82740400003)(26005)(5660300002)(8676002)(8936002)(478600001)(2906002)(316002)(70586007)(54906003)(36860700001)(4326008)(6916009)(7636003)(70206006)(36756003)(356005)(6666004)(86362001)(66899024)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 04:56:46.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac09de40-93d5-462c-c73a-08dc1d62088b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

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

AFAIK, Intel's ICE driver and Broadcom's driver also have the switchdev
mode and representor ports, thus the proposed new API should be useful
for other vendors.

Any comments are welcome, thanks!

Signed-off-by: William Tu <witu@nvidia.com>
---
v2: work on Jiri's internal feedback
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
 .../networking/devlink/devlink-sd.rst         | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-sd.rst

diff --git a/Documentation/networking/devlink/devlink-sd.rst b/Documentation/networking/devlink/devlink-sd.rst
new file mode 100644
index 000000000000..09182693522f
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-sd.rst
@@ -0,0 +1,284 @@
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
+* Bind/unbind a representor's rx channel to a descriptor pool
+
+In switchdev mode, representors are slow-path ports that handle the
+miss traffic, i.e., traffic not being forwarded by the hardware.
+Representor ports are regular ethernet devices, with multiple channels
+consuming DMA memory. Memory consumption of the representor
+port's rx buffers can grow to several GB when scaling to 1k VFs reps.
+For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
+consumes 3MB of DMA memory for packet buffer in descriptors, and with four
+channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
+ports are for slow path traffic when flows are mostly offloaded,
+most of these rep ports' rx DMA memory is idle.
+
+A network device driver consists of several channels and each channel
+represents an IRQ and a set of queues that trigger that IRQ. devlink-sd
+considers only the *regular* RX queue in each channel, e.g., mlx5's
+non-regular RQs such as XSK RQ and drop RQ are not applicable here.
+Each device driver receives packets by setting up RQ, and each RQ
+receives packets by pre-allocating a dedicated set of rx
+ring descriptors, with each descriptor pointing to a memory buffer.
+The ``shared descriptor pool`` is a descriptor and buffer sharing
+mechanism.  It allows multiple RQs to use the rx ring descriptors
+from the shared descriptor pool. In other words, the RQ no longer has
+its own dedicated rx ring descriptors, which might be idle when there
+is no traffic, but it gets the descriptors from the descriptor pool.
+
+The shared descriptor pool contains rx descriptors and its memory
+buffers. When multiple representors' RQs share the same pool of rx
+descriptors, they share the same set of memory buffers. As a result,
+the heavy-traffic representors can use all descriptors from the pool,
+while the idle, no-traffic representor consumes no memory. All the
+descriptors in the descriptor pool can be used by all the RQs. This
+makes the descriptor memory usage more efficient.
+
+The diagram below first shows two representors with their own the
+regular rep, RQ, and its rx descriptor ring and buffers::
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


