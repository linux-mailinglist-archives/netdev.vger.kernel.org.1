Return-Path: <netdev+bounces-75710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA38886AF9B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B9D1F22784
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8714AD24;
	Wed, 28 Feb 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UThVP9o1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF8149000
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125088; cv=fail; b=D3Z3lCPcbyXLLh0WRUDQWJPyLa+s25aBLflmKf2numaNK1/fm0KIkb6+/GpT6ZSPfusTM81cFjWM4/kgroznx3qfSudavXiDdLNGMDpuDHZb3qCo1PZPmoch3BxPRiiBOlw80I5knIu8vibHQS8GXDbts6kMmn1uV3aeRPy0I6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125088; c=relaxed/simple;
	bh=rWwDTMYyh4huFbmr43usIcSnJIbiEun/qxZVk90fjzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6kfhCIKsBeb6DVMF/zZfrrEl1LI52OnCgAZLtzlUKcUjwvqrqqE4J/g3DV5IGll/DUPiJIu5OGgDykFYdqaUFVIa1PkOdUolP+WuejOrB90b4VajsrBO46shlQ1gHblEaf87A9C1JJYTLht/HINEaRZve7x3KZ57ettzxXxdpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UThVP9o1; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG1gnNmDeYlF8xFSUayx/qKASboJ90+ajoLHTAkjjJgY4PItuKhQZV4YC2U8aSQi7f28fP9zWRwNq2+Vm43tqwxqdmb1ydMn6imQquufNw/p4690pxuWPWGVhCnOS58c48YhPNPhDF29HFvq0P8XqSlMbVi2T+eZU8AdCQKGE4brBY27r5dil4t6R7kHxBJbGaEOG65KA5nTfmqyNViSwxq6tsM8NCFyHnlrBLw0LRRZelsCRXA7v6aVv9HP0QE5RfSDR2gszV3I80D8fq8m/DeC58BqIWbgGrsGjpJi3DovtfzJlIcaQQ9+UYo6qJqAOB+IBX94pL7OXVI3GgRjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7fZE2qbrp3EUBu91S7bpGcXKHVPboj8VaZpFKEdGBM=;
 b=HfVTLiKqb3ZZFpUAEKqwCmsbgWX9xHA0fl4G8G/DZbaifFoGOlTcMNmqrmDTb/IAknlQ785GFBtPUduB3y+iXlkTGILMj7LFfpfhEkRZMMOc3Q5iv5CC1SsdDKJ0HYUjKn7Qlb3EZy39Gib7/tzoIdW5ncEPKB/+owMLdin45/oJmAE0PpMrPRG46/tBGOvuImdcVk09avWJ4aaSdO3v4cfwGWtSX42R5MR9I8p3zaFW7OHlrZhJxzCzZUryaBPR75dOeJrG+YHprngj65l52iG8qCxjDRXNw9J0cwK4VWXonUaENfsQPpp074fz80BEbZaaxGax8sU6DTojMiJxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7fZE2qbrp3EUBu91S7bpGcXKHVPboj8VaZpFKEdGBM=;
 b=UThVP9o1nuXuBkTDWb1yjLfqblSzo7wnAu92SucbxEfDE2d6eDck92ZMCGojhfSdhX+7c0GBWiopbB+ra6HTiRcrN/DsmLqJ9DEcWhSl5FZAPKzUD1Uy1O2uf5Y4g1EzY/fPbjjQksVJXlhJYE8HajRIydCmzebSDgxEfpcII2ihZ1ic29cydUjkgLSyMGF/CjV9QEj+cmKe+fXyHJA1sMKyZWfticHJkGWYsBg24FHpzwcMDa0PFqL1lEVrwAhOCbUUVpKcYxRZ5yZyxcjnDYo96PuY6W0vwjlDPtlYvetBdgNtP1oPS38nU7SVyq7bSQvXHdSgbeNsoIsrIXbWTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:02 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:02 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com
Subject: [PATCH v23 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Wed, 28 Feb 2024 12:57:15 +0000
Message-Id: <20240228125733.299384-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 338824b2-2b37-45eb-faf6-08dc385ce5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RjMg/qGKOcv6uyf6t2cVCxM/TTNMqNPIiMqdckhsRrwhwdjxwhOgIM4l0IcIrVNzLqWmlgBECSsq8xwnebK7f5gjEuyaBu5VwGZUJG3WPf/zxDqYTZnNmsMWPpYqIZldlrn839f9xsccCHnb703DQmpsSDyv/8n9SZW29dQ/LdDMhxB9+uyLnXRloOvUZ8/bhjZdVtq76l9Tie7t2TaszCQUT9KjpIEyvvL64tSBkAeTQ+0HGqxb1G8JfRH2NrYi5wIMmIVDDO2gYivVdKYQjbrkKw+ts2s01r9lbW8FOPN/g6SpCWd9lbTRGaIhIApypr0/ffx7hX4DMwR/2hF9Vq/EibDedp1Ey8KEZRV7MNmBD5B0oL+UoB0+KP3Up8WpqMMTcZoj7RTu22rj1BXSk1NOvYtana0zZfLtuVWa1Hw5ap0sIryQLnEKRieM2rTrSL/fqom5bJJEfRJ8rZZLXY0pbynhYFKtJVq5C0ZaLMqMZUCma1XBCOo4iZJkm5pWmw8TvGbut0Er/8vfDdXNKfw8r0khPKFywHTxLkwaQA9+48h2Q/+qZxX2HlXv+hJoYWXQj2rfwrIWORyCEbbOIxTwQf3E3mFu6HCk/hoFbyDEUN8NHxHMnGi6ST+qZNat
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NE/xpLvHTVB7GrcM/HDlCcNsacg0NmqZUQdBHvDK3ooxCcdg8kSSST6Zzu08?=
 =?us-ascii?Q?M1iT7Yh3TJmn9LPkUC1UEEL1YETHOoruhJiQDk14ToCXx6DSSytca7+n8i77?=
 =?us-ascii?Q?XAKH8NjsljDQNEBLNnLCUq2tVRE/wzCJJ+LoxMR/IWeWQs7T9m1+/OsLW3xf?=
 =?us-ascii?Q?QEpjk9BtT35CuSj8QoBIJ815ID7Vs6w6LbTOpCXSTVld8PbF81HNSYjm2Pmb?=
 =?us-ascii?Q?Pn/GzreI0XrM5wFZ+/C5aEEalqkmGmwRJrNz0gwK7uevPzi7bHlQRAELFOl7?=
 =?us-ascii?Q?ko6uuBsvDdLRKqzdUgnHiBMHxICJ9um2raGEADzO+LdgDIn47wni62mwlFWo?=
 =?us-ascii?Q?ju0BvzWUJbEbiEtGAfRm3TgLsez942hExBjcGWb/tG0vM2lxjBOCQYl7Xsuk?=
 =?us-ascii?Q?z8Inm9NYBAB/HuOoO5zGvVqJW33cLQtfjn8BlybdQ9h4gsAclAxI0+O7SiDB?=
 =?us-ascii?Q?JmPWCoiJI+BYWYQX1zxe/NHj9/dyZ6SXF4lRyxo8mfSaPtE8NnPMf4kCdN9R?=
 =?us-ascii?Q?WCiwq+77D8xrgv1yN/rivEUlIAwMBCXButoCS72UOr6AbPZfPwmqMzuBRYXU?=
 =?us-ascii?Q?/2jRJC0QuBHlUnOUSyXanAEjtlrcMBUifut7FSyxFWRL7vdGtUYcn7hHYZrM?=
 =?us-ascii?Q?jUsMQDMJZ79FobaLHYFMK7cN8nfl+vNxy+R3HKCyGJQu37anf23v/u75jasR?=
 =?us-ascii?Q?VzNPaWtmCQ/l5JoAulLA7nKxZjeZBnUW/NCj2duLAKqjmlh6oqrqZC9/bzX6?=
 =?us-ascii?Q?o3OuSsms9crOhxl4DGJTUtiBffFUlEtXKZwBOmMQKujtOcHrm5nbalpE0jDp?=
 =?us-ascii?Q?TZDWjpiAVm2wcSMwoZmnUUmdztBR+Ce3wRkInYFg/56ohNGsQ08BfxG/iR/g?=
 =?us-ascii?Q?2EzrRg0Z8JCLL7f19RwGGEMns2LKCbmEnr37DrjRq1+yjUd0E4si1WnXVsHH?=
 =?us-ascii?Q?irJ16kAolEX8WnQVFViOySfjmIq+BXigHHGCJMN4lolp8UiC6Oaqa0526ZnN?=
 =?us-ascii?Q?BR262TbkuC6mRLXHukz9JVqj8aUji8H8E0CJUUhK9WgngrSmTaRX+elJ+svU?=
 =?us-ascii?Q?u8VAJPX2CYDKQ+gdsHSnByS3fakUrVgFEAPXJSGjvNn3LWOjXzkwYYnqpsOT?=
 =?us-ascii?Q?modsA0ng2vIJX3P97EWPy5Lbc6CTA/bxePuKcEHCz9zz9fHfYWg4uzsfEG9c?=
 =?us-ascii?Q?/S5xewXqY7/CEqKzLs0MajCu033HEYyxqKWXuStUSYSg3czjDqulVMHtCix2?=
 =?us-ascii?Q?dzWKRCoznV9rK2FEcB0neCiX6Zl3XPvgEHKxw9HvLNQpa/TOz4OYe9PimBek?=
 =?us-ascii?Q?bOUfscD4SlOab9s8r2qJfxqykADVRUwa7T95RVkPGhyWKaoSvjT74QUlgPnR?=
 =?us-ascii?Q?pRmfWyHDe70ajFJkpYL1V77VZKe1URRReph3sGXpO0UG9JErPA+0PfN3S34q?=
 =?us-ascii?Q?ANsLtKNJdvEeNlq+1/Cp1hqaik9u25NGLk/gOXY0Flx0zPLHbfTDT4NHJzgg?=
 =?us-ascii?Q?YsfGkPW5E/1U85P1q4aw0h5zKIURsHjMS82aT6nQ1L2pKD1zsr6MVAu9oO8L?=
 =?us-ascii?Q?6XrY6u6QS45fAa4Gnvi3yHmfb6jpaCDANXa3YPr/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338824b2-2b37-45eb-faf6-08dc385ce5b2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:02.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVDN9zdqvUlTSbFdbBzGusnqXWGd/0CB+l0FlBTu6PEw/Dl22JsWMQCPey2ZF/xekxrMMyAT/U1dGRs7eMGNHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

Add a new netlink family to get/set ULP DDP capabilities on a network
device and to retrieve statistics.

The messages use the genetlink infrastructure and are specified in a
YAML file which was used to generate some of the files in this commit:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    -o net/core/ulp_ddp_gen_nl.h
./tools/net/ynl/ynl-gen-c.py --mode kernel \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
    -o net/core/ulp_ddp_gen_nl.c
./tools/net/ynl/ynl-gen-c.py --mode uapi \
    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
    > include/uapi/linux/ulp_ddp.h

Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/netlink/specs/ulp_ddp.yaml | 172 ++++++++++++
 include/net/ulp_ddp.h                    |   3 +-
 include/uapi/linux/ulp_ddp.h             |  61 ++++
 net/core/Makefile                        |   2 +-
 net/core/ulp_ddp_gen_nl.c                |  75 +++++
 net/core/ulp_ddp_gen_nl.h                |  30 ++
 net/core/ulp_ddp_nl.c                    | 344 +++++++++++++++++++++++
 7 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..27a0b905ec28
--- /dev/null
+++ b/Documentation/netlink/specs/ulp_ddp.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Aurelien Aptel <aaptel@nvidia.com>
+#
+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+#
+
+name: ulp_ddp
+
+protocol: genetlink
+
+doc: Netlink protocol to manage ULP DPP on network devices.
+
+definitions:
+  -
+    type: enum
+    name: cap
+    render-max: true
+    entries:
+      - nvme-tcp
+      - nvme-tcp-ddgst-rx
+
+attribute-sets:
+  -
+    name: stats
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: rx-nvme-tcp-sk-add
+        doc: Sockets successfully configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-add-fail
+        doc: Sockets failed to be configured for NVMeTCP offloading.
+        type: uint
+      -
+        name: rx-nvme-tcp-sk-del
+        doc: Sockets with NVMeTCP offloading configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup
+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-setup-fail
+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
+        type: uint
+      -
+        name: rx-nvme-tcp-teardown
+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
+        type: uint
+      -
+        name: rx-nvme-tcp-drop
+        doc: Packets failed the NVMeTCP offload validation.
+        type: uint
+      -
+        name: rx-nvme-tcp-resync
+        doc: >
+          NVMe-TCP resync operations were processed due to Rx TCP packets
+          re-ordering.
+        type: uint
+      -
+        name: rx-nvme-tcp-packets
+        doc: TCP packets successfully processed by the NVMeTCP offload.
+        type: uint
+      -
+        name: rx-nvme-tcp-bytes
+        doc: Bytes were successfully processed by the NVMeTCP offload.
+        type: uint
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        doc: Interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: Bitmask of the capabilities supported by the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: Bitmask of the capabilities currently enabled on the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          New active bit values of the capabilities we want to set on the
+          device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: Bitmask of the meaningful bits in the wanted field.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+
+operations:
+  list:
+    -
+      name: caps-get
+      doc: Get ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: stats-get
+      doc: Get ULP DDP stats.
+      attribute-set: stats
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - ifindex
+            - rx-nvme-tcp-sk-add
+            - rx-nvme-tcp-sk-add-fail
+            - rx-nvme-tcp-sk-del
+            - rx-nvme-tcp-setup
+            - rx-nvme-tcp-setup-fail
+            - rx-nvme-tcp-teardown
+            - rx-nvme-tcp-drop
+            - rx-nvme-tcp-resync
+            - rx-nvme-tcp-packets
+            - rx-nvme-tcp-bytes
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set
+      doc: Set ULP DDP capabilities.
+      attribute-set: caps
+      do:
+        request:
+          attributes:
+            - ifindex
+            - wanted
+            - wanted_mask
+        reply:
+          attributes:
+            - ifindex
+            - hw
+            - active
+        pre: ulp_ddp_get_netdev
+        post: ulp_ddp_put_netdev
+    -
+      name: caps-set-ntf
+      doc: Notification for change in ULP DDP capabilities.
+      notify: caps-get
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
index 5be527332799..ce333e28e089 100644
--- a/include/net/ulp_ddp.h
+++ b/include/net/ulp_ddp.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <net/inet_connection_sock.h>
 #include <net/sock.h>
+#include <uapi/linux/ulp_ddp.h>
 
 enum ulp_ddp_type {
 	ULP_DDP_NVME = 1,
@@ -128,7 +129,7 @@ struct ulp_ddp_stats {
 	 */
 };
 
-#define ULP_DDP_CAP_COUNT 1
+#define ULP_DDP_CAP_COUNT (ULP_DDP_CAP_MAX + 1)
 
 struct ulp_ddp_dev_caps {
 	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
diff --git a/include/uapi/linux/ulp_ddp.h b/include/uapi/linux/ulp_ddp.h
new file mode 100644
index 000000000000..dbf6399d3aef
--- /dev/null
+++ b/include/uapi/linux/ulp_ddp.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ULP_DDP_H
+#define _UAPI_LINUX_ULP_DDP_H
+
+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
+#define ULP_DDP_FAMILY_VERSION	1
+
+enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
+
+	/* private: */
+	__ULP_DDP_CAP_MAX,
+	ULP_DDP_CAP_MAX = (__ULP_DDP_CAP_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_STATS_IFINDEX = 1,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+	ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+	ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+	ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+	ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+	ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+
+	__ULP_DDP_A_STATS_MAX,
+	ULP_DDP_A_STATS_MAX = (__ULP_DDP_A_STATS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_A_CAPS_IFINDEX = 1,
+	ULP_DDP_A_CAPS_HW,
+	ULP_DDP_A_CAPS_ACTIVE,
+	ULP_DDP_A_CAPS_WANTED,
+	ULP_DDP_A_CAPS_WANTED_MASK,
+
+	__ULP_DDP_A_CAPS_MAX,
+	ULP_DDP_A_CAPS_MAX = (__ULP_DDP_A_CAPS_MAX - 1)
+};
+
+enum {
+	ULP_DDP_CMD_CAPS_GET = 1,
+	ULP_DDP_CMD_STATS_GET,
+	ULP_DDP_CMD_CAPS_SET,
+	ULP_DDP_CMD_CAPS_SET_NTF,
+
+	__ULP_DDP_CMD_MAX,
+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
+};
+
+#define ULP_DDP_MCGRP_MGMT	"mgmt"
+
+#endif /* _UAPI_LINUX_ULP_DDP_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index c135195005f5..da381587a161 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -18,7 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
new file mode 100644
index 000000000000..5675193ad8ca
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ulp_ddp_gen_nl.h"
+
+#include <uapi/linux/ulp_ddp.h>
+
+/* ULP_DDP_CMD_CAPS_GET - do */
+static const struct nla_policy ulp_ddp_caps_get_nl_policy[ULP_DDP_A_CAPS_IFINDEX + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_STATS_GET - do */
+static const struct nla_policy ulp_ddp_stats_get_nl_policy[ULP_DDP_A_STATS_IFINDEX + 1] = {
+	[ULP_DDP_A_STATS_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* ULP_DDP_CMD_CAPS_SET - do */
+static const struct nla_policy ulp_ddp_caps_set_nl_policy[ULP_DDP_A_CAPS_WANTED_MASK + 1] = {
+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+	[ULP_DDP_A_CAPS_WANTED] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+	[ULP_DDP_A_CAPS_WANTED_MASK] = NLA_POLICY_MASK(NLA_UINT, 0x3),
+};
+
+/* Ops table for ulp_ddp */
+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_get_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_STATS_GET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_stats_get_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_stats_get_nl_policy,
+		.maxattr	= ULP_DDP_A_STATS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= ULP_DDP_CMD_CAPS_SET,
+		.pre_doit	= ulp_ddp_get_netdev,
+		.doit		= ulp_ddp_nl_caps_set_doit,
+		.post_doit	= ulp_ddp_put_netdev,
+		.policy		= ulp_ddp_caps_set_nl_policy,
+		.maxattr	= ULP_DDP_A_CAPS_WANTED_MASK,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
+};
+
+struct genl_family ulp_ddp_nl_family __ro_after_init = {
+	.name		= ULP_DDP_FAMILY_NAME,
+	.version	= ULP_DDP_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ulp_ddp_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
+	.mcgrps		= ulp_ddp_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
+};
diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
new file mode 100644
index 000000000000..368433cfa867
--- /dev/null
+++ b/net/core/ulp_ddp_gen_nl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ulp_ddp.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_ULP_DDP_GEN_H
+#define _LINUX_ULP_DDP_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ulp_ddp.h>
+
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info);
+void
+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info);
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info);
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	ULP_DDP_NLGRP_MGMT,
+};
+
+extern struct genl_family ulp_ddp_nl_family;
+
+#endif /* _LINUX_ULP_DDP_GEN_H */
diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
new file mode 100644
index 000000000000..04feefce23c2
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ulp_ddp_nl.c
+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#include <net/ulp_ddp.h>
+#include "ulp_ddp_gen_nl.h"
+
+#define ULP_DDP_STATS_CNT (sizeof(struct ulp_ddp_stats) / sizeof(u64))
+
+struct ulp_ddp_reply_context {
+	struct net_device *dev;
+	netdevice_tracker tracker;
+	struct ulp_ddp_dev_caps caps;
+	struct ulp_ddp_stats stats;
+};
+
+static size_t ulp_ddp_reply_size(int cmd)
+{
+	size_t len = 0;
+
+	BUILD_BUG_ON(ULP_DDP_CAP_COUNT > 64);
+
+	/* ifindex */
+	len += nla_total_size(sizeof(u32));
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		/* hw */
+		len += nla_total_size_64bit(sizeof(u64));
+
+		/* active */
+		len += nla_total_size_64bit(sizeof(u64));
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		/* stats */
+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
+		break;
+	}
+
+	return len;
+}
+
+/* pre_doit */
+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
+		       struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx;
+	u32 ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_IFINDEX))
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);
+	ctx->dev = netdev_get_by_index(genl_info_net(info),
+				       ifindex,
+				       &ctx->tracker,
+				       GFP_KERNEL);
+	if (!ctx->dev) {
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not exist");
+		return -ENODEV;
+	}
+
+	if (!ctx->dev->netdev_ops->ulp_ddp_ops) {
+		netdev_put(ctx->dev, &ctx->tracker);
+		kfree(ctx);
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
+				    "Network interface does not support ULP DDP");
+		return -EOPNOTSUPP;
+	}
+
+	info->user_ptr[0] = ctx;
+	return 0;
+}
+
+/* post_doit */
+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+
+	netdev_put(ctx->dev, &ctx->tracker);
+	kfree(ctx);
+}
+
+static int ulp_ddp_prepare_context(struct ulp_ddp_reply_context *ctx, int cmd)
+{
+	const struct ulp_ddp_dev_ops *ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		ops->get_caps(ctx->dev, &ctx->caps);
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		ops->get_stats(ctx->dev, &ctx->stats);
+		break;
+	}
+
+	return 0;
+}
+
+static int ulp_ddp_write_reply(struct sk_buff *rsp,
+			       struct ulp_ddp_reply_context *ctx,
+			       int cmd,
+			       const struct genl_info *info)
+{
+	void *hdr;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	switch (cmd) {
+	case ULP_DDP_CMD_CAPS_GET:
+	case ULP_DDP_CMD_CAPS_SET:
+	case ULP_DDP_CMD_CAPS_SET_NTF:
+		if (nla_put_u32(rsp, ULP_DDP_A_CAPS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_HW, ctx->caps.hw[0]) ||
+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_ACTIVE,
+				 ctx->caps.active[0]))
+			goto err_cancel_msg;
+		break;
+	case ULP_DDP_CMD_STATS_GET:
+		if (nla_put_u32(rsp, ULP_DDP_A_STATS_IFINDEX,
+				ctx->dev->ifindex) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
+				 ctx->stats.rx_nvmeotcp_sk_add) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
+				 ctx->stats.rx_nvmeotcp_sk_add_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
+				 ctx->stats.rx_nvmeotcp_sk_del) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
+				 ctx->stats.rx_nvmeotcp_ddp_setup) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
+				 ctx->stats.rx_nvmeotcp_ddp_setup_fail) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
+				 ctx->stats.rx_nvmeotcp_ddp_teardown) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
+				 ctx->stats.rx_nvmeotcp_drop) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
+				 ctx->stats.rx_nvmeotcp_resync) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
+				 ctx->stats.rx_nvmeotcp_packets) ||
+		    nla_put_uint(rsp,
+				 ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
+				 ctx->stats.rx_nvmeotcp_bytes))
+			goto err_cancel_msg;
+	}
+	genlmsg_end(rsp, hdr);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(rsp, hdr);
+
+	return -EMSGSIZE;
+}
+
+int ulp_ddp_nl_caps_get_doit(struct sk_buff *req, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static void ulp_ddp_nl_notify_dev(struct ulp_ddp_reply_context *ctx)
+{
+	struct genl_info info;
+	struct sk_buff *ntf;
+	int ret;
+
+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(ctx->dev),
+				ULP_DDP_NLGRP_MGMT))
+		return;
+
+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_CAPS_SET_NTF);
+	ntf = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET_NTF), GFP_KERNEL);
+	if (!ntf)
+		return;
+
+	ret = ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info);
+	if (ret) {
+		nlmsg_free(ntf);
+		return;
+	}
+
+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(ctx->dev), ntf,
+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
+}
+
+static int ulp_ddp_apply_bits(struct ulp_ddp_reply_context *ctx,
+			      unsigned long *req_wanted,
+			      unsigned long *req_mask,
+			      struct genl_info *info,
+			      bool *notify)
+{
+	DECLARE_BITMAP(old_active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(new_active, ULP_DDP_CAP_COUNT);
+	const struct ulp_ddp_dev_ops *ops;
+	struct ulp_ddp_dev_caps caps;
+	int ret;
+
+	ops = ctx->dev->netdev_ops->ulp_ddp_ops;
+	ops->get_caps(ctx->dev, &caps);
+
+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
+	 * new_active &= caps_hw
+	 */
+	bitmap_copy(old_active, caps.active, ULP_DDP_CAP_COUNT);
+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_CAP_COUNT);
+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_CAP_COUNT);
+	bitmap_and(new_active, new_active, caps.hw, ULP_DDP_CAP_COUNT);
+	if (!bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT)) {
+		ret = ops->set_caps(ctx->dev, new_active, info->extack);
+		if (ret)
+			return ret;
+		ops->get_caps(ctx->dev, &caps);
+		bitmap_copy(new_active, caps.active, ULP_DDP_CAP_COUNT);
+	}
+
+	/* notify if capabilities were changed */
+	*notify = !bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT);
+
+	return 0;
+}
+
+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	unsigned long wanted, wanted_mask;
+	struct sk_buff *rsp;
+	bool notify = false;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED) ||
+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED_MASK))
+		return -EINVAL;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_SET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	wanted = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED]);
+	wanted_mask = nla_get_uint(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);
+
+	rtnl_lock();
+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info, &notify);
+	rtnl_unlock();
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_SET);
+	if (ret)
+		goto err_rsp;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_SET, info);
+	if (ret)
+		goto err_rsp;
+
+	ret = genlmsg_reply(rsp, info);
+	if (notify)
+		ulp_ddp_nl_notify_dev(ctx);
+
+	return ret;
+
+err_rsp:
+	nlmsg_free(rsp);
+
+	return ret;
+}
+
+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
+	struct sk_buff *rsp;
+	int ret = 0;
+
+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_STATS_GET);
+	if (ret)
+		return ret;
+
+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
+	if (!rsp)
+		return -EMSGSIZE;
+
+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_STATS_GET, info);
+	if (ret)
+		goto err_rsp;
+
+	return genlmsg_reply(rsp, info);
+
+err_rsp:
+	nlmsg_free(rsp);
+	return ret;
+}
+
+static int __init ulp_ddp_init(void)
+{
+	return genl_register_family(&ulp_ddp_nl_family);
+}
+
+subsys_initcall(ulp_ddp_init);
-- 
2.34.1


