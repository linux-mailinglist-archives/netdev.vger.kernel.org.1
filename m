Return-Path: <netdev+bounces-114320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6E9421C5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312061C24025
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068718DF8B;
	Tue, 30 Jul 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReeLUVB9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB518E035
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372118; cv=none; b=u4Ks9vBsq1sqvY9HkhhrpvmyW0JXFlesyfMUbfhpXIaPWGtr2B9j9LNqdp7D0mz9uviW/WGcH51Dg0q+El7RCakoKV2VIa1xQII5vu1rX3Q874NaI9cGDVay9OvFIcGyecVz+edtt9q1OMOseULlHrZou+EjkyaLfI4rA2aYPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372118; c=relaxed/simple;
	bh=wo2XybSwfOuRBtj48Iiyon3dWVwt43ye1cpqbNXI584=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/xDeMYEFpnkDNiZQJhzu1NOCQnj3Gq0bGA4D9SY5dLzvBVU8GTDxV0HW8IMEhcdAB4Qpdwd8PprjvMi3f7jl5kqYqj9tUiZh2bE1NV4h98ruHERZAYNptrIFKrP1hiecKJAGwZR/zbFtFKElgURT02SZgsbmvHppCZ1BLoL6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReeLUVB9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYIL3PTWwjgy1/7TEh1EqIF6hn9WeR9cfns21foBlXA=;
	b=ReeLUVB9Jqm/hlokeEDXlGESt5u5O6UP+65qbpu7dkILiTBpuCEFjVkqFqklDkL3l7cuhk
	z+upZ4HmUC95n+bCfDahcwikQV3U2qCanaRpYz5P3LwB9sKqkYgakLHktQZSSgm/Ru8XjZ
	nuZxolf8l0VSCO5nKiUTC3HxgisDT98=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-XlEq5I4gP82UToSao2iGqQ-1; Tue,
 30 Jul 2024 16:41:49 -0400
X-MC-Unique: XlEq5I4gP82UToSao2iGqQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7947B1955D44;
	Tue, 30 Jul 2024 20:41:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9E0B3000197;
	Tue, 30 Jul 2024 20:41:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Date: Tue, 30 Jul 2024 22:39:51 +0200
Message-ID: <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Leverage a basic/dummy netdevsim implementation to do functional
coverage for NL interface.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
rfc v1 -> v2:
  - added more test-cases WRT nesting and grouping
---
 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/netdev.c                |  37 +++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 267 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 6 files changed, 312 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/shaper.py

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..1fd5acdc73c6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -641,6 +641,7 @@ config NETDEVSIM
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
 	select PAGE_POOL
+	select NET_SHAPER
 	help
 	  This driver is a developer testing tool and software model that can
 	  be used to test various control path networking APIs, especially
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 017a6102be0a..ab9c3d5055e7 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -22,6 +22,7 @@
 #include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 #include <net/netlink.h>
+#include <net/net_shaper.h>
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
@@ -475,6 +476,41 @@ static int nsim_stop(struct net_device *dev)
 	return 0;
 }
 
+static int nsim_shaper_set(struct net_device *dev,
+			   const struct net_shaper_info *shaper,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_del(struct net_device *dev, u32 handles,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_group(struct net_device *dev, int nr_inputs,
+			     const struct net_shaper_info *inputs,
+			     const struct net_shaper_info *output,
+			     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_cap(struct net_device *dev, enum net_shaper_scope scope,
+			   unsigned long *flags)
+{
+	*flags = ULONG_MAX;
+	return 0;
+}
+
+static const struct net_shaper_ops nsim_shaper_ops = {
+	.set			= nsim_shaper_set,
+	.delete			= nsim_shaper_del,
+	.group			= nsim_shaper_group,
+	.capabilities		= nsim_shaper_cap,
+};
+
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
 	.ndo_set_rx_mode	= nsim_set_rx_mode,
@@ -496,6 +532,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_bpf		= nsim_bpf,
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
+	.net_shaper_ops		= &nsim_shaper_ops,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index e54f382bcb02..432306f11664 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS := \
 	ping.py \
 	queues.py \
 	stats.py \
+	shaper.py
 # end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
new file mode 100755
index 000000000000..ed34573bb4f6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -0,0 +1,267 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true, KsftSkipEx
+from lib.py import ShaperFamily
+from lib.py import NetDrvEnv
+from lib.py import NlError
+from lib.py import cmd
+import glob
+import sys
+
+def get_shapers(cfg, nl_shaper) -> None:
+    try:
+        shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+
+    # default configuration, no shapers configured
+    ksft_eq(len(shapers), 0)
+
+def get_caps(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex}, dump=True)
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+
+    # each device implementing shaper support must support some
+    # features in at least a scope
+    ksft_true(len(caps)> 0)
+
+def set_qshapers(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.queues = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support queue scope shapers with bw_max and metric bps")
+
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': { 'handle': { 'scope': 'queue', 'id': 1 }, 'metric': 'bps', 'bw-max': 10000 }})
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': { 'handle': { 'scope': 'queue', 'id': 2 }, 'metric': 'bps', 'bw-max': 20000 }})
+
+    # querying a specific shaper not yet configured must fail
+    raised = False
+    try:
+        shaper_q0 = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 0}})
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper_q1, { 'parent': { 'scope': 'netdev', 'id': 0 },
+                         'handle': { 'scope': 'queue', 'id': 1 },
+                         'metric': 'bps',
+                         'bw-min': 0,
+                         'bw-max': 10000,
+                         'burst': 0,
+                         'priority': 0,
+                         'weight': 0 })
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'parent': { 'scope': 'netdev', 'id': 0 },
+                       'handle': { 'scope': 'queue', 'id': 1 },
+                       'metric': 'bps',
+                       'bw-min': 0,
+                       'bw-max': 10000,
+                       'burst': 0,
+                       'priority': 0,
+                       'weight': 0 },
+                      {'parent': { 'scope': 'netdev', 'id': 0 },
+                       'handle': { 'scope': 'queue', 'id': 2 },
+                       'metric': 'bps',
+                       'bw-min': 0,
+                       'bw-max': 20000,
+                       'burst': 0,
+                       'priority': 0,
+                       'weight': 0 }])
+
+def del_qshapers(cfg, nl_shaper) -> None:
+    if not cfg.queues:
+        raise KsftSkipEx("queue shapers not supported by device, skipping delete")
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 1}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def set_nshapers(cfg, nl_shaper) -> None:
+    # check required features
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'netdev'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.netdev = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support nested netdev scope shapers with weight")
+
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': { 'handle': { 'scope': 'netdev', 'id': 0 }, 'bw-max': 100000 }})
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'parent': { 'scope': 'port', 'id': 0 },
+                       'handle': { 'scope': 'netdev', 'id': 0 },
+                       'metric': 'bps',
+                       'bw-min': 0,
+                       'bw-max': 100000,
+                       'burst': 0,
+                       'priority': 0,
+                       'weight': 0 }])
+
+def del_nshapers(cfg, nl_shaper) -> None:
+    if not cfg.netdev:
+        raise KsftSkipEx("netdev shaper not supported by device, skipping delete")
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'netdev'}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def basic_groups(cfg, nl_shaper) -> None:
+    if not cfg.netdev:
+        raise KsftSkipEx("netdev shaper not supported by the device")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.queues = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-weight' in caps:
+            raise KsftSkipEx("device does not support queue scope shapers with weight")
+
+    output_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'inputs':[{ 'handle': { 'scope': 'queue', 'id': 1 },'weight': 1 },
+                             { 'handle': { 'scope': 'queue', 'id': 2 }, 'weight': 2 }],
+                   'output': { 'handle': {'scope':'netdev'}, 'metric': 'bps', 'bw-max': 10000}})
+    output_id = output_handle['handle']['id']
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'netdev', 'id': 0 },
+                     'handle': { 'scope': 'queue', 'id': 1 },
+                     'metric': 'bps',
+                     'bw-min': 0,
+                     'bw-max': 0,
+                     'burst': 0,
+                     'priority': 0,
+                     'weight': 1 })
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 1}})
+
+    # deleting all the inputs shaper does not affect the output one
+    # when the latter has 'netdev' scope
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 1)
+
+    nl_shaper.delete({'ifindex': cfg.ifindex, 'handle': { 'scope': 'netdev'}})
+
+def qgroups(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'detached'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support detached scope shapers with bw_max and metric bps")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-nesting' in caps or not 'support-weight' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support nested queue scope shapers with weight")
+
+    output_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'inputs':[{ 'handle': { 'scope': 'queue', 'id': 1 }, 'metric': 'bps', 'weight': 3 },
+                             { 'handle': { 'scope': 'queue', 'id': 2 }, 'metric': 'bps', 'weight': 2 }],
+                   'output': { 'handle': {'scope':'detached'}, 'metric': 'bps', 'bw-max': 10000}})
+    output_id = output_handle['handle']['id']
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'detached', 'id': output_id },
+                     'handle': { 'scope': 'queue', 'id': 1 },
+                     'metric': 'bps',
+                     'bw-min': 0,
+                     'bw-max': 0,
+                     'burst': 0,
+                     'priority': 0,
+                     'weight': 3 })
+
+    # grouping to a specified, not existing detached scope shaper must fail
+    raised = False
+    try:
+        nl_shaper.group({'ifindex': cfg.ifindex,
+                   'inputs':[ { 'handle': { 'scope': 'queue', 'id': 3 }, 'metric': 'bps', 'weight': 3 }],
+                   'output': { 'handle': {'scope':'detached', 'id': output_id + 1 }, 'metric': 'bps', 'bw-max': 10000}})
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    output_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'inputs':[ { 'handle': { 'scope': 'queue', 'id': 3 }, 'metric': 'bps', 'weight': 4 }],
+                   'output': { 'handle': {'scope':'detached', 'id': output_id} }})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 3 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'detached', 'id': 0 },
+                     'handle': { 'scope': 'queue', 'id': 3 },
+                     'metric': 'bps',
+                     'bw-min': 0,
+                     'bw-max': 0,
+                     'burst': 0,
+                     'priority': 0,
+                     'weight': 4 })
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 1}})
+
+    # deleting a non empty group mast fail
+    raised = False
+    try:
+        nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'detached', 'id': output_id }})
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 3}})
+
+    # the detached scope shaper deletion is implicit
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=4) as cfg:
+        cfg.queues = True
+        cfg.netdev = True
+        ksft_run([get_shapers,
+                  get_caps,
+                  set_qshapers,
+                  del_qshapers,
+                  set_nshapers,
+                  del_nshapers,
+                  basic_groups,
+                  qgroups], args=(cfg, ShaperFamily()))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index b6d498d125fe..ef1aa52f4761 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -6,3 +6,4 @@ from .netns import NetNS
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
+from .ynl import ShaperFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 1ace58370c06..42e825905ade 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -47,3 +47,8 @@ class NetdevFamily(YnlFamily):
     def __init__(self):
         super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
                          schema='')
+
+class ShaperFamily(YnlFamily):
+    def __init__(self):
+        super().__init__((SPEC_PATH / Path('shaper.yaml')).as_posix(),
+                         schema='')
-- 
2.45.2


