Return-Path: <netdev+bounces-50589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244667F63D3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5332815F0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0823FB01;
	Thu, 23 Nov 2023 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="li/8zhv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C4A3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:21:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548b54ed16eso1439338a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700756517; x=1701361317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhcxN+uaakzTg6HbjpZhi2ldjWgaMxkSyC5nG3wFaH0=;
        b=li/8zhv3I0T5GFB6LgDNhG9e1fsP530LKb1UDW3nhZKau6NR2HZuKX51/wlA0wm09Y
         h3JpmHt64hsdNs76UgudDTuuvpqWgiII9PdZslBR8UeEqJ7hUK53Qezz3qAaZDO5LYRF
         ozv7+NQ8STscQkIIXJwLAse+x44BiFNVjzdn6dene1zcvArej/w4PcOT6W3niQBwn9bt
         mBAlUcgBnrINctlNW+a/obt0j506SReBZiCIM6Hck6gT64XSBcZdZkP9uQInYb4HMqyi
         HYZqlpaWqi9rM/JmVy6A2HQ55XVHUoVjS8ev9hV2q9ID6fGfcpf0JKIZshCjBOss6lh1
         xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756517; x=1701361317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhcxN+uaakzTg6HbjpZhi2ldjWgaMxkSyC5nG3wFaH0=;
        b=m4MH1bXrclGj7BpbSaT6Av9rZiWOf9RvLwVjQxLg0TLjF97phrOcfJh/B8/8b96Rj6
         S7t3Xce/9PSkaIjqhd7N/LDZrsu9L02mGnxMXsm5RI8JwQkojIHEGCjp30EnteLThHm4
         jSseCffr4hBsRol+dF092o1f5c6iKwJgkPVAeA89y7LDs5vJK2dP5nmnd/cGtlGfG0Y6
         v3LyNIillRcolKqoVRlg0Uw6saVMyxvP0Q4aRxk/F1J70st8LQ2yFFgb7JDCIj/mlwx6
         gUKlxgl3CukNFQd3cLxcMzGXo8nQQkaBHFMSY23dvPpab0d2/yFRGU4ijr0zVkvDUxWF
         OA2w==
X-Gm-Message-State: AOJu0YxA1BRl7xA4Yv42T0jOf7gUqre3mC1RmulSBglQps7KtQ6+uf0Q
	35FTu7M2Nzq0iiOW3B33ASu0hq+IPUp304uIblw=
X-Google-Smtp-Source: AGHT+IGzJHUMa1KClcBArReAXgh3mjTM86Mz2QuAM92Rt09dvADodoAszTSnPYofMDc/J4gBceUJQg==
X-Received: by 2002:aa7:d587:0:b0:544:1fa7:b6c1 with SMTP id r7-20020aa7d587000000b005441fa7b6c1mr5467909edq.0.1700756516879;
        Thu, 23 Nov 2023 08:21:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x1-20020aa7d381000000b00548ab1abc75sm818217edq.51.2023.11.23.08.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:21:56 -0800 (PST)
Date: Thu, 23 Nov 2023 17:21:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v20 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZV98IyA3LSsk2BXs@nanopsycho>
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-3-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122134833.20825-3-aaptel@nvidia.com>

Wed, Nov 22, 2023 at 02:48:15PM CET, aaptel@nvidia.com wrote:
>Add a new netlink family to get/set ULP DDP capabilities on a network
>device and to retrieve statistics.
>
>The messages use the genetlink infrastructure and are specified in a
>YAML file which was used to generate some of the files in this commit:
>
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    -o net/core/ulp_ddp_gen_nl.h
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>    -o net/core/ulp_ddp_gen_nl.c
>./tools/net/ynl/ynl-gen-c.py --mode uapi \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    > include/uapi/linux/ulp_ddp.h
>
>Signed-off-by: Shai Malin <smalin@nvidia.com>
>Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Overall looks good to me, couple of nits below, take it or leave it.


>---
> Documentation/netlink/specs/ulp_ddp.yaml | 172 ++++++++++++
> include/net/ulp_ddp.h                    |   3 +-
> include/uapi/linux/ulp_ddp.h             |  61 +++++
> net/core/Makefile                        |   2 +-
> net/core/ulp_ddp_gen_nl.c                |  75 +++++
> net/core/ulp_ddp_gen_nl.h                |  30 ++
> net/core/ulp_ddp_nl.c                    | 335 +++++++++++++++++++++++
> 7 files changed, 676 insertions(+), 2 deletions(-)
> create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
> create mode 100644 include/uapi/linux/ulp_ddp.h
> create mode 100644 net/core/ulp_ddp_gen_nl.c
> create mode 100644 net/core/ulp_ddp_gen_nl.h
> create mode 100644 net/core/ulp_ddp_nl.c
>
>diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
>new file mode 100644
>index 000000000000..7822aa60ae29
>--- /dev/null
>+++ b/Documentation/netlink/specs/ulp_ddp.yaml
>@@ -0,0 +1,172 @@
>+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+#
>+# Author: Aurelien Aptel <aaptel@nvidia.com>
>+#
>+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+#
>+
>+name: ulp_ddp
>+
>+protocol: genetlink
>+
>+doc: Netlink protocol to manage ULP DPP on network devices.
>+
>+definitions:
>+  -
>+    type: enum
>+    name: cap
>+    render-max: true
>+    entries:
>+      - nvme-tcp
>+      - nvme-tcp-ddgst-rx
>+
>+attribute-sets:
>+  -
>+    name: stats
>+    attributes:
>+      -
>+        name: ifindex
>+        doc: interface index of the net device.
>+        type: u32
>+      -
>+        name: rx-nvme-tcp-sk-add
>+        doc: Sockets successfully configured for NVMeTCP offloading.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-sk-add-fail
>+        doc: Sockets failed to be configured for NVMeTCP offloading.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-sk-del
>+        doc: Sockets with NVMeTCP offloading configuration removed.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-setup
>+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-setup-fail
>+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-teardown
>+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-drop
>+        doc: Packets failed the NVMeTCP offload validation.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-resync
>+        doc: >
>+          NVMe-TCP resync operations were processed due to Rx TCP packets
>+          re-ordering.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-packets
>+        doc: TCP packets successfully processed by the NVMeTCP offload.
>+        type: uint
>+      -
>+        name: rx-nvme-tcp-bytes
>+        doc: Bytes were successfully processed by the NVMeTCP offload.
>+        type: uint
>+  -
>+    name: caps
>+    attributes:
>+      -
>+        name: ifindex
>+        doc: interface index of the net device.
>+        type: u32
>+      -
>+        name: hw
>+        doc: bitmask of the capabilities supported by the device.
>+        type: uint
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: active
>+        doc: bitmask of the capabilities currently enabled on the device.
>+        type: uint
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: wanted
>+        doc: >
>+          new active bit values of the capabilities we want to set on the
>+          device.
>+        type: uint
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: wanted_mask
>+        doc: bitmask of the meaningful bits in the wanted field.
>+        type: uint
>+        enum: cap
>+        enum-as-flags: true
>+
>+operations:
>+  list:
>+    -
>+      name: caps-get
>+      doc: Get ULP DDP capabilities.
>+      attribute-set: caps
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+        reply:
>+          attributes:
>+            - ifindex
>+            - hw
>+            - active
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+    -
>+      name: stats-get
>+      doc: Get ULP DDP stats.
>+      attribute-set: stats
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+        reply:
>+          attributes:
>+            - ifindex
>+            - rx-nvme-tcp-sk-add
>+            - rx-nvme-tcp-sk-add-fail
>+            - rx-nvme-tcp-sk-del
>+            - rx-nvme-tcp-setup
>+            - rx-nvme-tcp-setup-fail
>+            - rx-nvme-tcp-teardown
>+            - rx-nvme-tcp-drop
>+            - rx-nvme-tcp-resync
>+            - rx-nvme-tcp-packets
>+            - rx-nvme-tcp-bytes
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+    -
>+      name: caps-set
>+      doc: Set ULP DDP capabilities.
>+      attribute-set: caps
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+            - wanted
>+            - wanted_mask
>+        reply:
>+          attributes:
>+            - ifindex
>+            - hw
>+            - active
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+    -
>+      name: caps-set-ntf
>+      doc: Notification for change in ULP DDP capabilities.
>+      notify: caps-get
>+
>+mcast-groups:
>+  list:
>+    -
>+      name: mgmt
>diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
>index fa3f84939901..4dfc98bbfd07 100644
>--- a/include/net/ulp_ddp.h
>+++ b/include/net/ulp_ddp.h
>@@ -10,6 +10,7 @@
> #include <linux/netdevice.h>
> #include <net/inet_connection_sock.h>
> #include <net/sock.h>
>+#include <uapi/linux/ulp_ddp.h>
> 
> enum ulp_ddp_type {
> 	ULP_DDP_NVME = 1,
>@@ -128,7 +129,7 @@ struct ulp_ddp_stats {
> 	 */
> };
> 
>-#define ULP_DDP_CAP_COUNT 1
>+#define ULP_DDP_CAP_COUNT (ULP_DDP_CAP_MAX + 1)
> 
> struct ulp_ddp_dev_caps {
> 	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
>diff --git a/include/uapi/linux/ulp_ddp.h b/include/uapi/linux/ulp_ddp.h
>new file mode 100644
>index 000000000000..dbf6399d3aef
>--- /dev/null
>+++ b/include/uapi/linux/ulp_ddp.h
>@@ -0,0 +1,61 @@
>+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN uapi header */
>+
>+#ifndef _UAPI_LINUX_ULP_DDP_H
>+#define _UAPI_LINUX_ULP_DDP_H
>+
>+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
>+#define ULP_DDP_FAMILY_VERSION	1
>+
>+enum ulp_ddp_cap {
>+	ULP_DDP_CAP_NVME_TCP,
>+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
>+
>+	/* private: */
>+	__ULP_DDP_CAP_MAX,
>+	ULP_DDP_CAP_MAX = (__ULP_DDP_CAP_MAX - 1)
>+};
>+
>+enum {
>+	ULP_DDP_A_STATS_IFINDEX = 1,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
>+	ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
>+
>+	__ULP_DDP_A_STATS_MAX,
>+	ULP_DDP_A_STATS_MAX = (__ULP_DDP_A_STATS_MAX - 1)
>+};
>+
>+enum {
>+	ULP_DDP_A_CAPS_IFINDEX = 1,
>+	ULP_DDP_A_CAPS_HW,
>+	ULP_DDP_A_CAPS_ACTIVE,
>+	ULP_DDP_A_CAPS_WANTED,
>+	ULP_DDP_A_CAPS_WANTED_MASK,
>+
>+	__ULP_DDP_A_CAPS_MAX,
>+	ULP_DDP_A_CAPS_MAX = (__ULP_DDP_A_CAPS_MAX - 1)
>+};
>+
>+enum {
>+	ULP_DDP_CMD_CAPS_GET = 1,
>+	ULP_DDP_CMD_STATS_GET,
>+	ULP_DDP_CMD_CAPS_SET,
>+	ULP_DDP_CMD_CAPS_SET_NTF,
>+
>+	__ULP_DDP_CMD_MAX,
>+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
>+};
>+
>+#define ULP_DDP_MCGRP_MGMT	"mgmt"
>+
>+#endif /* _UAPI_LINUX_ULP_DDP_H */
>diff --git a/net/core/Makefile b/net/core/Makefile
>index b6a16e7c955a..1aff91f0fce0 100644
>--- a/net/core/Makefile
>+++ b/net/core/Makefile
>@@ -18,7 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
> obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
> 
> obj-y += net-sysfs.o
>-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
>+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
> obj-$(CONFIG_PAGE_POOL) += page_pool.o
> obj-$(CONFIG_PROC_FS) += net-procfs.o
> obj-$(CONFIG_NET_PKTGEN) += pktgen.o
>diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
>new file mode 100644
>index 000000000000..5675193ad8ca
>--- /dev/null
>+++ b/net/core/ulp_ddp_gen_nl.c
>@@ -0,0 +1,75 @@
>+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN kernel source */
>+
>+#include <net/netlink.h>
>+#include <net/genetlink.h>
>+
>+#include "ulp_ddp_gen_nl.h"
>+
>+#include <uapi/linux/ulp_ddp.h>
>+
>+/* ULP_DDP_CMD_CAPS_GET - do */
>+static const struct nla_policy ulp_ddp_caps_get_nl_policy[ULP_DDP_A_CAPS_IFINDEX + 1] = {
>+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
>+};
>+
>+/* ULP_DDP_CMD_STATS_GET - do */
>+static const struct nla_policy ulp_ddp_stats_get_nl_policy[ULP_DDP_A_STATS_IFINDEX + 1] = {
>+	[ULP_DDP_A_STATS_IFINDEX] = { .type = NLA_U32, },
>+};
>+
>+/* ULP_DDP_CMD_CAPS_SET - do */
>+static const struct nla_policy ulp_ddp_caps_set_nl_policy[ULP_DDP_A_CAPS_WANTED_MASK + 1] = {
>+	[ULP_DDP_A_CAPS_IFINDEX] = { .type = NLA_U32, },
>+	[ULP_DDP_A_CAPS_WANTED] = NLA_POLICY_MASK(NLA_UINT, 0x3),
>+	[ULP_DDP_A_CAPS_WANTED_MASK] = NLA_POLICY_MASK(NLA_UINT, 0x3),
>+};
>+
>+/* Ops table for ulp_ddp */
>+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
>+	{
>+		.cmd		= ULP_DDP_CMD_CAPS_GET,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_caps_get_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_caps_get_nl_policy,
>+		.maxattr	= ULP_DDP_A_CAPS_IFINDEX,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+	{
>+		.cmd		= ULP_DDP_CMD_STATS_GET,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_stats_get_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_stats_get_nl_policy,
>+		.maxattr	= ULP_DDP_A_STATS_IFINDEX,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+	{
>+		.cmd		= ULP_DDP_CMD_CAPS_SET,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_caps_set_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_caps_set_nl_policy,
>+		.maxattr	= ULP_DDP_A_CAPS_WANTED_MASK,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+};
>+
>+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
>+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
>+};
>+
>+struct genl_family ulp_ddp_nl_family __ro_after_init = {
>+	.name		= ULP_DDP_FAMILY_NAME,
>+	.version	= ULP_DDP_FAMILY_VERSION,
>+	.netnsok	= true,
>+	.parallel_ops	= true,
>+	.module		= THIS_MODULE,
>+	.split_ops	= ulp_ddp_nl_ops,
>+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
>+	.mcgrps		= ulp_ddp_nl_mcgrps,
>+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
>+};
>diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
>new file mode 100644
>index 000000000000..368433cfa867
>--- /dev/null
>+++ b/net/core/ulp_ddp_gen_nl.h
>@@ -0,0 +1,30 @@
>+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN kernel header */
>+
>+#ifndef _LINUX_ULP_DDP_GEN_H
>+#define _LINUX_ULP_DDP_GEN_H
>+
>+#include <net/netlink.h>
>+#include <net/genetlink.h>
>+
>+#include <uapi/linux/ulp_ddp.h>
>+
>+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+		       struct genl_info *info);
>+void
>+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+		   struct genl_info *info);
>+
>+int ulp_ddp_nl_caps_get_doit(struct sk_buff *skb, struct genl_info *info);
>+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info);
>+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info);
>+
>+enum {
>+	ULP_DDP_NLGRP_MGMT,
>+};
>+
>+extern struct genl_family ulp_ddp_nl_family;
>+
>+#endif /* _LINUX_ULP_DDP_GEN_H */
>diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
>new file mode 100644
>index 000000000000..4e8b210f6734
>--- /dev/null
>+++ b/net/core/ulp_ddp_nl.c
>@@ -0,0 +1,335 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * ulp_ddp_nl.c
>+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
>+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+ */
>+#include <net/ulp_ddp.h>
>+#include "ulp_ddp_gen_nl.h"
>+
>+#define ULP_DDP_STATS_CNT (sizeof(struct ulp_ddp_stats) / sizeof(u64))
>+
>+struct ulp_ddp_reply_context {
>+	struct net_device *dev;
>+	netdevice_tracker tracker;
>+	void *hdr;
>+	u32 ifindex;
>+	struct ulp_ddp_dev_caps caps;
>+	struct ulp_ddp_stats stats;
>+};
>+
>+static size_t ulp_ddp_reply_size(int cmd)
>+{
>+	size_t len = 0;
>+
>+	BUILD_BUG_ON(ULP_DDP_CAP_COUNT > 64);
>+
>+	/* ifindex */
>+	len += nla_total_size(sizeof(u32));
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_CAPS_GET:
>+	case ULP_DDP_CMD_CAPS_SET:
>+	case ULP_DDP_CMD_CAPS_SET_NTF:
>+		/* hw */
>+		len += nla_total_size_64bit(sizeof(u64));
>+
>+		/* active */
>+		len += nla_total_size_64bit(sizeof(u64));
>+		break;
>+	case ULP_DDP_CMD_STATS_GET:
>+		/* stats */
>+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
>+		break;
>+	}
>+
>+	return len;
>+}
>+
>+/* pre_doit */
>+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
>+		       struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct ulp_ddp_reply_context *ctx;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_IFINDEX))
>+		return -EINVAL;
>+
>+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>+	if (!ctx)
>+		return -ENOMEM;
>+
>+	ctx->ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);

You don't need to store ifindex. You have ctx->dev->ifindex with the
same value.


>+	ctx->dev = netdev_get_by_index(genl_info_net(info),
>+				       ctx->ifindex,
>+				       &ctx->tracker,
>+				       GFP_KERNEL);
>+	if (!ctx->dev) {
>+		kfree(ctx);
>+		NL_SET_ERR_MSG_ATTR(info->extack,
>+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
>+				    "Network interface does not exist");
>+		return -ENODEV;
>+	}
>+
>+	if (!ctx->dev->netdev_ops->ulp_ddp_ops) {
>+		netdev_put(ctx->dev, &ctx->tracker);
>+		kfree(ctx);
>+		NL_SET_ERR_MSG_ATTR(info->extack,
>+				    info->attrs[ULP_DDP_A_CAPS_IFINDEX],
>+				    "Network interface does not support ULP DDP");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	info->user_ptr[0] = ctx;
>+	return 0;
>+}
>+
>+/* post_doit */
>+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+			struct genl_info *info)
>+{
>+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
>+
>+	netdev_put(ctx->dev, &ctx->tracker);
>+	kfree(ctx);
>+}
>+
>+static int ulp_ddp_prepare_context(struct ulp_ddp_reply_context *ctx, int cmd)
>+{
>+	const struct ulp_ddp_dev_ops *ops = ctx->dev->netdev_ops->ulp_ddp_ops;
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_CAPS_GET:
>+	case ULP_DDP_CMD_CAPS_SET:
>+	case ULP_DDP_CMD_CAPS_SET_NTF:

Hmm, you never call ulp_ddp_prepare_context() with
ULP_DDP_CMD_CAPS_SET_NTF. Perhaps just warn if this case is hit. IDK.


>+		ops->get_caps(ctx->dev, &ctx->caps);
>+		break;
>+	case ULP_DDP_CMD_STATS_GET:
>+		ops->get_stats(ctx->dev, &ctx->stats);
>+		break;
>+	}
>+
>+	return 0;
>+}
>+
>+static int ulp_ddp_write_reply(struct sk_buff *rsp,
>+			       struct ulp_ddp_reply_context *ctx,
>+			       int cmd,
>+			       const struct genl_info *info)
>+{
>+	ctx->hdr = genlmsg_iput(rsp, info);

Interesting, you use "hdr" just in this fuction. Why isn't it a local
variable?


>+	if (!ctx->hdr)
>+		return -EMSGSIZE;
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_CAPS_GET:
>+	case ULP_DDP_CMD_CAPS_SET:
>+	case ULP_DDP_CMD_CAPS_SET_NTF:
>+		if (nla_put_u32(rsp, ULP_DDP_A_CAPS_IFINDEX, ctx->ifindex) ||
>+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_HW, ctx->caps.hw[0]) ||
>+		    nla_put_uint(rsp, ULP_DDP_A_CAPS_ACTIVE,
>+				 ctx->caps.active[0]))
>+			goto err_cancel_msg;
>+		break;
>+	case ULP_DDP_CMD_STATS_GET:
>+		if (nla_put_u32(rsp, ULP_DDP_A_STATS_IFINDEX, ctx->ifindex) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD,
>+				 ctx->stats.rx_nvmeotcp_sk_add) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_ADD_FAIL,
>+				 ctx->stats.rx_nvmeotcp_sk_add_fail) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_SK_DEL,
>+				 ctx->stats.rx_nvmeotcp_sk_del) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP,
>+				 ctx->stats.rx_nvmeotcp_ddp_setup) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_SETUP_FAIL,
>+				 ctx->stats.rx_nvmeotcp_ddp_setup_fail) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_TEARDOWN,
>+				 ctx->stats.rx_nvmeotcp_ddp_teardown) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_DROP,
>+				 ctx->stats.rx_nvmeotcp_drop) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_RESYNC,
>+				 ctx->stats.rx_nvmeotcp_resync) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_PACKETS,
>+				 ctx->stats.rx_nvmeotcp_packets) ||
>+		    nla_put_uint(rsp,
>+				 ULP_DDP_A_STATS_RX_NVME_TCP_BYTES,
>+				 ctx->stats.rx_nvmeotcp_bytes))
>+			goto err_cancel_msg;
>+	}
>+	genlmsg_end(rsp, ctx->hdr);
>+
>+	return 0;
>+
>+err_cancel_msg:
>+	genlmsg_cancel(rsp, ctx->hdr);
>+
>+	return -EMSGSIZE;
>+}
>+
>+int ulp_ddp_nl_caps_get_doit(struct sk_buff *req, struct genl_info *info)
>+{
>+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
>+	struct sk_buff *rsp;
>+	int ret = 0;
>+
>+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_GET);
>+	if (ret)
>+		return ret;
>+
>+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
>+	if (ret < 0)

You mix "if (ret)" and "if (ret < 0)" in this code, I don't see any of
the functions return positive value on success, so you can make it
consistent to "if (ret)".


>+		goto err_rsp;
>+
>+	return genlmsg_reply(rsp, info);
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+	return ret;
>+}
>+
>+static void ulp_ddp_nl_notify_dev(struct ulp_ddp_reply_context *ctx)
>+{
>+	struct genl_info info;
>+	struct sk_buff *ntf;
>+
>+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(ctx->dev),
>+				ULP_DDP_NLGRP_MGMT))
>+		return;
>+
>+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_CAPS_SET_NTF);
>+	ntf = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_CAPS_GET), GFP_KERNEL);
>+	if (!ntf)
>+		return;
>+
>+	if (ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info)) {

Always use "ret" variable to store return value before you check it.


>+		nlmsg_free(ntf);
>+		return;
>+	}
>+
>+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(ctx->dev), ntf,
>+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
>+}
>+
>+static int ulp_ddp_apply_bits(struct ulp_ddp_reply_context *ctx,
>+			      unsigned long *req_wanted,
>+			      unsigned long *req_mask,
>+			      struct genl_info *info)
>+{
>+	DECLARE_BITMAP(old_active, ULP_DDP_CAP_COUNT);
>+	DECLARE_BITMAP(new_active, ULP_DDP_CAP_COUNT);
>+	const struct ulp_ddp_dev_ops *ops;
>+	struct ulp_ddp_dev_caps caps;
>+	int ret;
>+
>+	ops = ctx->dev->netdev_ops->ulp_ddp_ops;
>+	ops->get_caps(ctx->dev, &caps);
>+
>+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
>+	 * new_active &= caps_hw
>+	 */
>+	bitmap_copy(old_active, caps.active, ULP_DDP_CAP_COUNT);
>+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_CAP_COUNT);
>+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_CAP_COUNT);
>+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_CAP_COUNT);
>+	bitmap_and(new_active, new_active, caps.hw, ULP_DDP_CAP_COUNT);
>+	if (!bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT)) {
>+		ret = ops->set_caps(ctx->dev, new_active, info->extack);
>+		if (ret < 0)
>+			return ret;
>+		ops->get_caps(ctx->dev, &caps);
>+		bitmap_copy(new_active, caps.active, ULP_DDP_CAP_COUNT);
>+	}
>+
>+	/* return 1 to notify */
>+	return !bitmap_equal(old_active, new_active, ULP_DDP_CAP_COUNT);
>+}
>+
>+int ulp_ddp_nl_caps_set_doit(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
>+	unsigned long wanted, wanted_mask;
>+	struct sk_buff *rsp;
>+	bool notify;
>+	int ret;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED) ||
>+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_CAPS_WANTED_MASK))
>+		return -EINVAL;
>+
>+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	wanted = nla_get_u64(info->attrs[ULP_DDP_A_CAPS_WANTED]);

nla_get_uint()


>+	wanted_mask = nla_get_u64(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);

nla_get_uint()


>+
>+	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info);

	ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info,
				 &notify);

Would be a bit cleaner to read perhaps.


>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	notify = !!ret;
>+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_CAPS_SET);
>+	if (ret)
>+		goto err_rsp;
>+
>+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_SET, info);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	ret = genlmsg_reply(rsp, info);
>+	if (notify)
>+		ulp_ddp_nl_notify_dev(ctx);
>+
>+	return ret;
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+
>+	return ret;
>+}
>+
>+int ulp_ddp_nl_stats_get_doit(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct ulp_ddp_reply_context *ctx = info->user_ptr[0];
>+	struct sk_buff *rsp;
>+	int ret = 0;
>+
>+	ret = ulp_ddp_prepare_context(ctx, ULP_DDP_CMD_STATS_GET);
>+	if (ret)
>+		return ret;
>+
>+	rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_STATS_GET, info);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	return genlmsg_reply(rsp, info);
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+	return ret;
>+}
>+
>+static int __init ulp_ddp_init(void)
>+{
>+	return genl_register_family(&ulp_ddp_nl_family);
>+}
>+
>+subsys_initcall(ulp_ddp_init);
>-- 
>2.34.1
>
>

