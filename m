Return-Path: <netdev+bounces-120247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB99958AD8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB31C21E37
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955A1922DD;
	Tue, 20 Aug 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2X362rD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FF191F6C
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166820; cv=none; b=KRhVjJQG4sEN4OP9+MpXhp6PQ+MGT/MHgkEbjIXG+phwhUcbnANcEivoN8/81jLT/vdtbRh2BUQiIOrH1oUilm/7hA6gTjXzZZVTtpGON9/KqVOr5pKmgsXplEw1IVbZncMmBqg8CQGxBl8OOYYgNkol7kEn+RXEYVH9t5w7uBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166820; c=relaxed/simple;
	bh=W8PPpjtXJyue55kupf0rAA/6Q8BZgL1iIyYVCeYf1RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WySAbnctJWAvC5ZVG1vlK6uc3JAgW6KcCm4uTgYf4owGQzETV3axy5wsfuTxrJEsmLxten13evpO7mfFCMtDgsQZ5/Oz3YeFYc6AUyrU5mulpHHJfLuFuwH2AC4bvzr/i5E1/Og6pMJ2kDF6+WeYwc6CvCtx5o8EQHJWJ22DRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2X362rD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDU7zShwu1GjeqtL3e7Qs5aRikFihN2L9LISjhw016Y=;
	b=K2X362rDTGBM5Bh03sJUD9WkNTDjnS/vA6nTxDKi9R7nb+ZHXFuhlw7nvKsYE2mlQeaufa
	qqgNyta6VsY7Z36wxwtk0/OKc2R8ssrxy/uTJest2hshce5QZSfINb6Sr30A9rB5MH1e0n
	cZ6y0YsHDaPDkPQdJJ/7AVyowbRE4Mc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-e_JW73ZlOAyNIzhCP4MN_g-1; Tue,
 20 Aug 2024 11:13:33 -0400
X-MC-Unique: e_JW73ZlOAyNIzhCP4MN_g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A68ED1955F2F;
	Tue, 20 Aug 2024 15:13:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 255BB19560AA;
	Tue, 20 Aug 2024 15:13:27 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
Date: Tue, 20 Aug 2024 17:12:30 +0200
Message-ID: <4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Leverage a basic/dummy netdevsim implementation to do functional
coverage for NL interface.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
rfc v1 -> v2:
  - added more test-cases WRT nesting and grouping
---
 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/netdev.c                |  41 +++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 236 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 6 files changed, 285 insertions(+)
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
index 017a6102be0a..5a2442bba156 100644
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
@@ -475,6 +476,45 @@ static int nsim_stop(struct net_device *dev)
 	return 0;
 }
 
+static int nsim_shaper_set(struct net_device *dev,
+			   const struct net_shaper_handle *handle,
+			   const struct net_shaper_info *shaper,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_del(struct net_device *dev,
+			   const struct net_shaper_handle *handle,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_shaper_group(struct net_device *dev, int leaves_count,
+			     const struct net_shaper_handle *leaves_handles,
+			     const struct net_shaper_info *leaves,
+			     const struct net_shaper_handle *root_handle,
+			     const struct net_shaper_info *root,
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
@@ -496,6 +536,7 @@ static const struct net_device_ops nsim_netdev_ops = {
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
index 000000000000..4b3bcdfc5358
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -0,0 +1,236 @@
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
+        shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
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
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex}, dump=True)
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
+    # Querying a specific shaper not yet configured must fail.
+    raised = False
+    try:
+        shaper_q0 = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 0}})
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    shaper_q1 = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper_q1, { 'parent': { 'scope': 'netdev' },
+                         'handle': { 'scope': 'queue', 'id': 1 },
+                         'metric': 'bps',
+                         'bw-max': 10000 })
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'parent': { 'scope': 'netdev' },
+                       'handle': { 'scope': 'queue', 'id': 1 },
+                       'metric': 'bps',
+                       'bw-max': 10000 },
+                      {'parent': { 'scope': 'netdev' },
+                       'handle': { 'scope': 'queue', 'id': 2 },
+                       'metric': 'bps',
+                       'bw-max': 20000 }])
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
+    # Check required features.
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
+    ksft_eq(shapers, [{'handle': { 'scope': 'netdev' },
+                       'metric': 'bps',
+                       'bw-max': 100000 }])
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
+    root_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'leaves':[{ 'handle': { 'scope': 'queue', 'id': 1 },'weight': 1 },
+                             { 'handle': { 'scope': 'queue', 'id': 2 }, 'weight': 2 }],
+                   'root': { 'handle': {'scope':'netdev'}, 'metric': 'bps', 'bw-max': 10000}})
+    ksft_eq(root_handle, {'ifindex': cfg.ifindex, 'handle': {'scope': 'netdev', 'id': 0}})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'netdev' },
+                     'handle': { 'scope': 'queue', 'id': 1 },
+                     'weight': 1 })
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 1}})
+
+    # Deleting all the leaves shaper does not affect the root one
+    # when the latter has 'netdev' scope.
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 1)
+
+    nl_shaper.delete({'ifindex': cfg.ifindex, 'handle': { 'scope': 'netdev'}})
+
+def qgroups(cfg, nl_shaper) -> None:
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'node'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support node scope shapers with bw_max and metric bps")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex, 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-nesting' in caps or not 'support-weight' in caps or not 'support-metric-bps' in caps:
+            raise KsftSkipEx("device does not support nested queue scope shapers with weight")
+
+    root_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'leaves':[{ 'handle': { 'scope': 'queue', 'id': 1 }, 'metric': 'bps', 'weight': 3 },
+                             { 'handle': { 'scope': 'queue', 'id': 2 }, 'metric': 'bps', 'weight': 2 }],
+                   'root': { 'handle': {'scope':'node'}, 'metric': 'bps', 'bw-max': 10000}})
+    root_id = root_handle['handle']['id']
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 1 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'node', 'id': root_id },
+                     'handle': { 'scope': 'queue', 'id': 1 },
+                     'weight': 3 })
+
+    # Grouping to a specified, not existing node scope shaper must fail
+    raised = False
+    try:
+        nl_shaper.group({'ifindex': cfg.ifindex,
+                   'leaves':[ { 'handle': { 'scope': 'queue', 'id': 3 }, 'metric': 'bps', 'weight': 3 }],
+                   'root': { 'handle': {'scope':'node', 'id': root_id + 1 }, 'metric': 'bps', 'bw-max': 10000}})
+
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    root_handle = nl_shaper.group({'ifindex': cfg.ifindex,
+                   'leaves':[ { 'handle': { 'scope': 'queue', 'id': 3 }, 'metric': 'bps', 'weight': 4 }],
+                   'root': { 'handle': {'scope':'node', 'id': root_id} }})
+    ksft_eq(root_handle, {'ifindex': cfg.ifindex, 'handle': {'scope': 'node', 'id': root_id}})
+
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex, 'handle': { 'scope': 'queue', 'id': 3 }})
+    ksft_eq(shaper, {'parent': { 'scope': 'node', 'id': 0 },
+                     'handle': { 'scope': 'queue', 'id': 3 },
+                     'weight': 4 })
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 2}})
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 1}})
+
+    # Deleting a non empty group will move the leaves downstream.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'node', 'id': root_id }})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'parent': { 'scope': 'netdev' },
+                      'handle': { 'scope': 'queue', 'id': 3 },
+                      'weight': 4 }])
+
+    # Finish and verify the complete cleanup.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': { 'scope': 'queue', 'id': 3}})
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


