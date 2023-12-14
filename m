Return-Path: <netdev+bounces-57433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C7813181
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3641C21361
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89865644D;
	Thu, 14 Dec 2023 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mm9vOsdi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840141A5
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WahGl5T5wpVtxkrpLAds5G+6040K/Ugpi4Hd/AexYp7In5aam8JgR2yo8OGwbN95wtfbMKdgfsWClos/p9DzUR0PrJiUayWd3gn8cnxVBtIc4QGsvF6M5SSWjrWilFuNbiFPlGhQhkl3LbaFIKavBCjoWV/lsOwdVf+OVUI+6P0mYPLjyoheIxyn+7G2UcEBWMvZ23eyBTmYoSmJreruUq2ABIwH2WKg/8sz1Tal7XJmyogBQztlEi7LczJsQYwBhcRjHQpDtA1ccHhQu7WrFrtvg5aOJy44sfu7NxdQWwM13bah95/Rbl/SoYU+bKEsRAnlJuvRvAFE9U7WxpdVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL1SxzXZu9C/qJk28P9uGfUGX/uprzp8paRG6aHJh9Q=;
 b=UkCWnX2Pminrt67KHJ1kRXlOsyGSu7wyzihclk+MDg7TenqT5p4vEQW7C2X0fsefrBXxsFdtQFp3Pn80RlXApxCR+YJGnJBLuKBoGM2IJGHAUcYoY5AKUJTFP9GlnuW1IrrApkp4rAOeXbGlzSvJjHih3HettR1HkJ0qEzPt8D3ZaYwHdC1Y9rbeZjCapB+sjBsDF3B8KJTKzdirWyN81+6W53T4J8pvgkCwwJCpASft8GhjKPlgeqolTcWCekrf4cS//QrB7Av6k3qRUJ0hAgCQ0p5blwLAZHkTpB1FfnrBpXOx8A9gmGY0LcpTqvpiRqqgxGcm2OgAfEdvR3AkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL1SxzXZu9C/qJk28P9uGfUGX/uprzp8paRG6aHJh9Q=;
 b=mm9vOsdimcnVF1m+Rz/rln+nXjiilwrCU7OJS0TzHCICsEFJyIz646rjheOGfDaXZq02eMz6x5q/5Mv0jdjlK/1Jy1jshJ1GyELVqyXxrwjNhMUAaZrndLhP2PyzK2Du4kgHH4Pvw3dpIn+NDN8lwWB/xbgHqs01RH5pKgJd7O00P7AugA88lExEzwEc0EwSPyRLPYEdwl0+QsCtFgb4WTTJFIVISAjOMN1aniW5K7diPFpqgx1tXwiZd2caS1uI6WIwbpdMwvu+s2WZVT4dJVdMyXwMyXCI6HFHenEzqGuRooK8X/Z8jt4Du6m16a0iVv2AFJi3Ad6l3ugRO6/8tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:26:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:26:47 +0000
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
Subject: [PATCH v21 02/20] netlink: add new family to manage ULP_DDP enablement and stats
Date: Thu, 14 Dec 2023 13:26:05 +0000
Message-Id: <20231214132623.119227-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7435eeb3-935d-402c-7242-08dbfca85272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xjBnzlcQq+hfeCUFMdk57UozSZKlmJcaWWasWcPu0rYpdRksqQjIQtQfBV9XzwRKvDbT9lI1gKaTjTR9YZNun2YmtIyp5pwx9B/mMRSfWIuYn07GurjQj5CYOBh2jiyMQR5w9J6DMfvKqYc4lsmVNIBfbNYuv1KjwljpuKURit3UAwq8w1wCzd8mbYmZuvgrVk9EtRt+NHyZjeTWUWa0C7EgjkWGmKArIhBVtUXIJMGsLz2pbphgzV+K5bcJF+2TPdfedxnhqnnv7rBdbvl3Z7YYZ0ujo8+TPtroQlHRBkQHYMjbd9J0PKVqSDKl7E6esZOoNqQkk9NJ3yL0Nw5HPAOyx17qLnMgiuAR0Bi3vqlOj7VKfpxMG8kW6js/4iXxOAwGYo5YAZ1PSSsbMWy7NbOpBsqPCL6nSzU+Uf84Ol095XG8Q3UFyXgo0oc9HtRekisQHtt855iGMVW+jFiMYe3THYbudD2pmeq6uNxGIAy0VpCLCA74F4vgoOj+UNJg2VyRbgYZYD2Nz+UUsZgmYEszf8heOHdQfUKIMY9iNY0p0YXVBRiZC1HfqjNvwBk7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7416002)(30864003)(2906002)(38100700002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(6512007)(6486002)(6666004)(478600001)(83380400001)(66476007)(66556008)(316002)(66946007)(6506007)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/esKVHFAjWEs92uVeYO0ZloNT2TDnmcWFhL5vEkFS6zF7ffBy0N2NCjD+Hog?=
 =?us-ascii?Q?jy7u7Sk8j19njss0D1X8CMxZNnHJrePS/Bh/gNbAPbV/U4LgCEbB3KK7nut3?=
 =?us-ascii?Q?SYKE3THERuLNM4q9+xnFRmlJEOyTXmaqwN1rstTSy9IGkMEBHRhiEP4SRBuC?=
 =?us-ascii?Q?x94W6KUWMiGMgvU11gHz9K8/RvvSOtpj/KAUFNTvgyFyZwnZE91yxAyKy7B7?=
 =?us-ascii?Q?uBt1gxZUHWMSl0Nj8bjf5mPDN/0aeD0z7tlqJ/bFzbmjqEbao9F4dsaMIjKW?=
 =?us-ascii?Q?/IbouEb1AWgq7So7rN4E5C3+H+EPzQ15O+NJ8h1cu3YiLNxWe6Php2udNsqW?=
 =?us-ascii?Q?EUQYMkaXK78ztwu9vsjZ+DgZLho52GsOqsVfgjnDAYGETzSSlGt77m2cNOiZ?=
 =?us-ascii?Q?0tUTq/mYcKnTvKrluTBfFIu/JC1HzPX+OZ2F3/BtF3mGrkx3PIMhnUnA8EL0?=
 =?us-ascii?Q?2ZUkJwC81bBP2vD95qhnPYI/AdDDTJn9wBY4MfqsllTVfD/pLfE6MJVGPoW1?=
 =?us-ascii?Q?tzbRgFhckIfLQrRS/c2rKc2xoC4hmtAHIsiEuaqgECIQ9wY8Svvpjb4v+W7q?=
 =?us-ascii?Q?PHn7SvgYcKXskplKqOcBxGJVzRp0k7B1EPIsSd1ueBk77X/xc1IMvbE7zP48?=
 =?us-ascii?Q?SWwgULNlt+1niHjyJUBygd9YrOLj9FtZcg0wAqE5nO9MW7WGpauDI+24L87O?=
 =?us-ascii?Q?jfR7lBTC6mJH8AONEUG7NyxLj9fKdQJeHykWuY6SYejAxOAYp4rXt3BRJNLB?=
 =?us-ascii?Q?iL4Nk5flGCiW7Ak0uG4BQn/m3MdWOHZ4LxKmBnpcC5WxxlFmgWNk0BGNr9kC?=
 =?us-ascii?Q?/GQ/vLruTPJAVXgJCkxuXpHimGj9p2p8vfKB9/FaSTO8f/rk3FVxooGZs+J4?=
 =?us-ascii?Q?iMm7ft+k5eDTW/kBjyuKWiXT5ptC2v2pMZ3Pn8YGBBbEtKtz6WlH3/reCkOZ?=
 =?us-ascii?Q?/DegXZd9A23EJa5+GO1CRiiDoteL2VpoiRB+Yy6vmlENnSdWTzvnCCMRtziu?=
 =?us-ascii?Q?O2r2MZepOIRHgZQ6ETUc/M98aR4wRFxn+jZa6oUIdCQMhFmTHbh0wWAU/+Ns?=
 =?us-ascii?Q?FIr7HxFlIdqba+rB3zmspDtguvOuhyJNAPZlJwgDm5wbEfYX/TN2WuH24QZz?=
 =?us-ascii?Q?qGP82bpjqrEa/IPLTKzdXSIULU10K1K0+nUnfR/sgoFDp7o+swCJwxzAVeRy?=
 =?us-ascii?Q?q1HW9TiLUQsvlhveyBrtnOVhr2+GQt0q+N1ERUb/xFekeQTePcAQZipkswRe?=
 =?us-ascii?Q?kskNT++KJx+EI6FBxxx8HK19Mn3gLy4hfyVtwiMu3oLi9DUc+wHSBw1frdZF?=
 =?us-ascii?Q?cyPm9gKpWNF5Sde8ykwEj/TozMfpNHdG4bxCXNmZ2cMrg4/wZKJ0m3iV1d9k?=
 =?us-ascii?Q?nOqBNfY504PaLukKdMJxzNdEFOzvmhMWHhnhY2+6uFndVD/a15hnysnd9MmG?=
 =?us-ascii?Q?MmIS+1G/5N5HGupm8IhN6WT2dlkz/w83YYR6TE/e5FAJ1hEL0kcnkkeT4QXo?=
 =?us-ascii?Q?pa1tnY5L+DL9/ENukYZMCDmfY0OVXESdH6tt3pt63T3z2iQZjDpCRjXUu6GG?=
 =?us-ascii?Q?tQJf2A8eI1CQ50NmW8uGgT2PCKg6P7uJ4UCr9d9D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7435eeb3-935d-402c-7242-08dbfca85272
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:26:47.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3P07Ty4wPaONMhcaKceEz3W2ZivgE/eUFkbJKcYqNdQnuiKOc84bVQGntGW39yL0/It50JXdRBxw5t6XSJA0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

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
 net/core/ulp_ddp_nl.c                    | 342 +++++++++++++++++++++++
 7 files changed, 683 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
new file mode 100644
index 000000000000..7822aa60ae29
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
+        doc: interface index of the net device.
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
+        doc: interface index of the net device.
+        type: u32
+      -
+        name: hw
+        doc: bitmask of the capabilities supported by the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: active
+        doc: bitmask of the capabilities currently enabled on the device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted
+        doc: >
+          new active bit values of the capabilities we want to set on the
+          device.
+        type: uint
+        enum: cap
+        enum-as-flags: true
+      -
+        name: wanted_mask
+        doc: bitmask of the meaningful bits in the wanted field.
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
index 000000000000..6f6e603fa2d4
--- /dev/null
+++ b/net/core/ulp_ddp_nl.c
@@ -0,0 +1,342 @@
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
+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info, &notify);
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


