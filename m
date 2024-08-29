Return-Path: <netdev+bounces-123359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5569649CE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E101B262FC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32AA1B29AD;
	Thu, 29 Aug 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avhq8ChT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F61B3B0D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944699; cv=none; b=F3rJOQ5Fdoi+OQKwvEc+/4+D+9CpBM0kCaFT2epjZEBTkf5MMvoz2ZdSJaFYFKlEuPHFUm/gqXhwDsvSTMV028dcjM4tjoyb3yo34N3brP65fqEJjfXbJ6MOGRb92f5zFIlIKcKhDhIFVssDBDH3jn/NW1TeSClKj3O1B3X1GBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944699; c=relaxed/simple;
	bh=xoC1Vgt1yGdhpfJd0x0Fokdpts65JvXRIl4VhtlFP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usKBo4iQLZJo429TNXjdC5HTsLJb7/dbRraNAqM0yUp50sjYdV3PxASGz0aRoDOUeRZM/wOciESNOJlYKOBDSdtj1LTiICBTtRkcpzjTANu4r8onKZ7I2YzAu70BYnsv6+UWC8uYlDFP7WTw8qR5e0KSjUm6Tj9FyPk/WID8cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Avhq8ChT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTGuuzlXD3iCOvOdCTNLyK5gprM/SES7Ucqw69P1mPw=;
	b=Avhq8ChT6MgagkLTWFjrgaVNTt2tFbNviWm0+fQTXohUZ6JsIt52Vho1yrKENdDoZ/beCu
	bhC4e+v5+9DgE6DIkDMKfAuj8DAf5WdMKGpNNkpF0kUrlgcQlKoFVaOavQdFmqpJwCzaqJ
	lvuedXNBEHTRuhyCH37CT0dSkuniSBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-UqI7-FxEOxSI-yUfAMgtCQ-1; Thu,
 29 Aug 2024 11:18:11 -0400
X-MC-Unique: UqI7-FxEOxSI-yUfAMgtCQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AE121955BF2;
	Thu, 29 Aug 2024 15:18:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C38563002249;
	Thu, 29 Aug 2024 15:18:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: [PATCH v5 net-next 08/12] testing: net-drv: add basic shaper test
Date: Thu, 29 Aug 2024 17:17:01 +0200
Message-ID: <d1fe533039fe636f0fe905ebe90bcfa8226352a2.1724944117.git.pabeni@redhat.com>
In-Reply-To: <cover.1724944116.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
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
v4 -> v5:
  - updated to new driver API
  - more consistent indentation

rfc v1 -> v2:
  - added more test-cases WRT nesting and grouping
---
 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/netdev.c                |  43 +++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 290 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 6 files changed, 341 insertions(+)
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
index 017a6102be0a..3c18191c7448 100644
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
@@ -475,6 +476,47 @@ static int nsim_stop(struct net_device *dev)
 	return 0;
 }
 
+static int nsim_shaper_set(struct net_shaper_binding *binding,
+			   const struct net_shaper_handle *handle,
+			   const struct net_shaper_info *shaper,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_del(struct net_shaper_binding *binding,
+			   const struct net_shaper_handle *handle,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_group(struct net_shaper_binding *binding,
+			     int leaves_count,
+			     const struct net_shaper_handle *leaves_handles,
+			     const struct net_shaper_info *leaves,
+			     const struct net_shaper_handle *root_handle,
+			     const struct net_shaper_info *root,
+			     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_cap(struct net_shaper_binding *binding,
+			   enum net_shaper_scope scope,
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
@@ -496,6 +538,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_bpf		= nsim_bpf,
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
+	.net_shaper_ops		= &nsim_shaper_ops,
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 39fb97a8c1df..25aec5c081df 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -9,6 +9,7 @@ TEST_PROGS := \
 	ping.py \
 	queues.py \
 	stats.py \
+	shaper.py
 # end of TEST_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
new file mode 100755
index 000000000000..ed1ceba13915
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -0,0 +1,290 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true, KsftSkipEx
+from lib.py import NetshaperFamily
+from lib.py import NetDrvEnv
+from lib.py import NlError
+from lib.py import cmd
+import glob
+import sys
+
+def get_shapers(cfg, nl_shaper) -> None:
+    try:
+        shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                                dump=True)
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+
+    # Default configuration: no shapers configured.
+    ksft_eq(len(shapers), 0)
+
+def get_caps(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex},
+                                 dump=True)
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+
+    # Each device implementing shaper support must support some
+    # features in at least a scope.
+    ksft_true(len(caps)> 0)
+
+def set_qshapers(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.queues = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support queue scope shapers with bw_max and metric bps")
+
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': {'handle': {'scope': 'queue', 'id': 1},
+                              'metric': 'bps',
+                              'bw-max': 10000}})
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': {'handle': {'scope': 'queue', 'id': 2},
+                              'metric': 'bps',
+                              'bw-max': 20000}})
+
+    # Querying a specific shaper not yet configured must fail.
+    raised = False
+    try:
+        shaper_q0 = nl_shaper.get({'ifindex': cfg.ifindex,
+                                   'handle': {'scope': 'queue', 'id': 0}})
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex,
+                              'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper_q1, {'ifindex': cfg.ifindex,
+                        'parent': {'scope': 'netdev'},
+                        'handle': {'scope': 'queue', 'id': 1},
+                        'metric': 'bps',
+                        'bw-max': 10000})
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'metric': 'bps',
+                       'bw-max': 10000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 2},
+                       'metric': 'bps',
+                       'bw-max': 20000}])
+
+def del_qshapers(cfg, nl_shaper) -> None:
+    if not cfg.queues:
+        raise KsftSkipEx("queue shapers not supported by device, skipping delete")
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 1}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(len(shapers), 0)
+
+def set_nshapers(cfg, nl_shaper) -> None:
+    # Check required features.
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'netdev'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.netdev = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support nested netdev scope shapers with weight")
+
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': {
+                        'handle': {'scope': 'netdev', 'id': 0},
+                        'bw-max': 100000}})
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'handle': {'scope': 'netdev'},
+                       'metric': 'bps',
+                       'bw-max': 100000}])
+
+def del_nshapers(cfg, nl_shaper) -> None:
+    if not cfg.netdev:
+        raise KsftSkipEx("netdev shaper not supported by device, skipping delete")
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'netdev'}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(len(shapers), 0)
+
+def basic_groups(cfg, nl_shaper) -> None:
+    if not cfg.netdev:
+        raise KsftSkipEx("netdev shaper not supported by the device")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.queues = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-weight' in caps:
+            raise KsftSkipEx("device does not support queue scope shapers with weight")
+
+    node_handle = nl_shaper.group({
+                        'ifindex': cfg.ifindex,
+                        'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                                   'weight': 1},
+                                  {'handle': {'scope': 'queue', 'id': 2},
+                                   'weight': 2}],
+                         'node': {'handle': {'scope':'netdev'},
+                                  'metric': 'bps',
+                                  'bw-max': 10000}})
+    ksft_eq(node_handle, {'ifindex': cfg.ifindex,
+                          'handle': {'scope': 'netdev'}})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'netdev'},
+                     'handle': {'scope': 'queue', 'id': 1},
+                     'weight': 1 })
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 1}})
+
+    # Deleting all the leaves shaper does not affect the node one
+    # when the latter has 'netdev' scope.
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(len(shapers), 1)
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'netdev'}})
+
+def qgroups(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'node'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support node scope shapers with bw_max and metric bps")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-nesting' in caps or not 'support-weight' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support nested queue scope shapers with weight")
+
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'metric': 'bps', 'weight': 3},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'metric': 'bps', 'weight': 2}],
+                   'node': {'handle': {'scope':'node'},
+                            'metric': 'bps',
+                            'bw-max': 10000}})
+    node_id = node_handle['handle']['id']
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 1}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'node', 'id': node_id},
+                     'handle': {'scope': 'queue', 'id': 1},
+                     'weight': 3})
+
+    # Grouping to a specified, not existing node scope shaper must fail
+    raised = False
+    try:
+        nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'metric': 'bps',
+                              'weight': 3}],
+                   'node': {'handle': {'scope':'node', 'id': node_id + 1},
+                            'metric': 'bps',
+                            'bw-max': 10000}})
+
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'metric': 'bps',
+                              'weight': 4}],
+                   'node': {'handle': {'scope':'node', 'id': node_id}}})
+    ksft_eq(node_handle, {'ifindex': cfg.ifindex,
+                          'handle': {'scope': 'node', 'id': node_id}})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'queue', 'id': 3}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'parent': {'scope': 'node', 'id': node_id},
+                     'handle': {'scope': 'queue', 'id': 3},
+                     'weight': 4})
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 1}})
+
+    # Deleting a non empty group will move the leaves downstream.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'node', 'id': node_id}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 3},
+                       'weight': 4}])
+
+    # Finish and verify the complete cleanup.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 3}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex},
+                            dump=True)
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
+                  qgroups], args=(cfg, NetshaperFamily()))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index b6d498d125fe..54d8f5eba810 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -6,3 +6,4 @@ from .netns import NetNS
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
+from .ynl import NetshaperFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 1ace58370c06..a0d689d58c57 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -47,3 +47,8 @@ class NetdevFamily(YnlFamily):
     def __init__(self):
         super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
                          schema='')
+
+class NetshaperFamily(YnlFamily):
+    def __init__(self):
+        super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
+                         schema='')
-- 
2.45.2


