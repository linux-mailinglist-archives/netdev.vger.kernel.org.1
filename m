Return-Path: <netdev+bounces-125119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAB96BF5F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872C11F22CE2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFD1DB54A;
	Wed,  4 Sep 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF37WinF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DA1D47D1
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458281; cv=none; b=ik6ffZ8CVw/VUqxzAQcqOtI2kSH3rZU+DdP3lyJ6bPjElsTFsCLgoXxW+l7BQGVAgY8j2W4CJIsPljLwPkrE+a9nw3DcN+OsNw1Fbt2Qv4JHAiO9oBKG+PShSfXyUq8Lt6LlcxDBRGRka2PkkNFoQRbOUvSlqDNsmMwiTvqrzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458281; c=relaxed/simple;
	bh=4zIM+yX/a7k2724Syk7w5vFBgpJJGfOZcvd3JkALan8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0NKgUMXUnOn53YerX3QaNFpOnkG0CNWK6xYTnM0cg2zDy0lw3Itcc7laJ9Eqcf5J458poNnKkInBjPuLF3xYyucn7nFu9BOD3do4PuUVcbdNdT9qxyGkSu+wLpLB7el0fvhTJPALLh51a0tO4GX2krWRxGXe7dTFExj27u21C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF37WinF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXi4dOV6ChYRI8GsyYmwS+97qrgIkUunEuYdJUbvUf0=;
	b=EF37WinFXVD4y5kuyA2eFBvT54+aC/VMeyunfM7S36/0pFJzZk0sM37AE9q5/vFcbYeH1e
	4O63M/oAXfLqOemy+Mbo7fx+4+I+2ApPd1ESvoq4cU+clwY7fqm/2aNayOIFhiPGP1RaxC
	xgM1iCnnizOdQDX1KtwYC8yIAWbK4ZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-0x7hV071OnWoqCd7MLSpyg-1; Wed,
 04 Sep 2024 09:57:55 -0400
X-MC-Unique: 0x7hV071OnWoqCd7MLSpyg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7922197702D;
	Wed,  4 Sep 2024 13:57:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA0691955D8D;
	Wed,  4 Sep 2024 13:57:40 +0000 (UTC)
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
Subject: [PATCH v6 net-next 11/15] testing: net-drv: add basic shaper test
Date: Wed,  4 Sep 2024 15:53:43 +0200
Message-ID: <3dab32b3ad0d061fa4bbd6c04a3489a44e6d4dd9.1725457317.git.pabeni@redhat.com>
In-Reply-To: <cover.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Leverage a basic/dummy netdevsim implementation to do functional
coverage for NL interface.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
  - additional test-cases for delegation and queue reconf

v4 -> v5:
  - updated to new driver API
  - more consistent indentation

rfc v1 -> v2:
  - added more test-cases WRT nesting and grouping
---
 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/netdev.c                |  39 ++
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 458 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 6 files changed, 505 insertions(+)
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
index 017a6102be0a..cad85bb0cf54 100644
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
@@ -475,6 +476,43 @@ static int nsim_stop(struct net_device *dev)
 	return 0;
 }
 
+static int nsim_shaper_set(struct net_shaper_binding *binding,
+			   const struct net_shaper *shaper,
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
+			     const struct net_shaper *leaves,
+			     const struct net_shaper *root,
+			     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void nsim_shaper_cap(struct net_shaper_binding *binding,
+			    enum net_shaper_scope scope,
+			    unsigned long *flags)
+{
+	*flags = ULONG_MAX;
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
@@ -496,6 +534,7 @@ static const struct net_device_ops nsim_netdev_ops = {
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
index 000000000000..7bb83f8a2583
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -0,0 +1,458 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true, KsftSkipEx
+from lib.py import EthtoolFamily, NetshaperFamily
+from lib.py import NetDrvEnv
+from lib.py import NlError
+from lib.py import cmd
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
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                 'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+        raise KsftSkipEx("device does not support queue scope shapers with bw_max and metric bps")
+
+    cfg.queues = True;
+    netnl = EthtoolFamily()
+    channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    if channels['combined-count'] == 0:
+        cfg.rx_type = 'rx'
+        cfg.nr_queues = channels['rx-count']
+    else:
+        cfg.rx_type = 'combined'
+        cfg.nr_queues = channels['combined-count']
+    if cfg.nr_queues < 3:
+        raise KsftSkipEx("device does not support enough queues min 3 found {cfg.nr_queues}")
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
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
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
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def set_nshapers(cfg, nl_shaper) -> None:
+    # Check required features.
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'netdev'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+        raise KsftSkipEx("device does not support nested netdev scope shapers with weight")
+
+    cfg.netdev = True;
+    nl_shaper.set({'ifindex': cfg.ifindex,
+                   'shaper': {
+                        'handle': {'scope': 'netdev', 'id': 0},
+                        'bw-max': 100000}})
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
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
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def basic_groups(cfg, nl_shaper) -> None:
+    if not cfg.netdev:
+        raise KsftSkipEx("netdev shaper not supported by the device")
+    if cfg.nr_queues < 3:
+        raise KsftSkipEx("netdev does not have enough queues min 3 reported {cfg.nr_queues}")
+
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'queue'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-weight' in caps:
+        raise KsftSkipEx("device does not support queue scope shapers with weight")
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
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 1)
+
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'netdev'}})
+
+def qgroups(cfg, nl_shaper) -> None:
+    if cfg.nr_queues < 4:
+        raise KsftSkipEx("netdev does not have enough queues min 4 reported {cfg.nr_queues}")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'node'})
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-bw-max' in caps or not 'support-metric-bps' in caps:
+        raise KsftSkipEx("device does not support node scope shapers with bw_max and metric bps")
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
+    cfg.group = True;
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 3},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 2}],
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
+    shaper = nl_shaper.get({'ifindex': cfg.ifindex,
+                            'handle': {'scope': 'node', 'id': node_id}})
+    ksft_eq(shaper, {'ifindex': cfg.ifindex,
+                     'handle': {'scope': 'node', 'id': node_id},
+                     'parent': {'scope': 'netdev'},
+                     'metric': 'bps',
+                     'bw-max': 10000})
+
+    # Grouping to a specified, not existing node scope shaper must fail
+    raised = False
+    try:
+        nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 3}],
+                   'node': {'handle': {'scope':'node', 'id': node_id + 1},
+                            'metric': 'bps',
+                            'bw-max': 10000}})
+
+    except (NlError):
+        raised = True
+    ksft_eq(raised, True)
+
+    # Add to an existing node
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 3},
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
+    # Deleting a non empty node will move the leaves downstream.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'node', 'id': node_id}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 3},
+                       'weight': 4}])
+
+    # Finish and verify the complete cleanup.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'queue', 'id': 3}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def delegation(cfg, nl_shaper) -> None:
+    if not cfg.group:
+        raise KsftSkipEx("device does not support node scope")
+    try:
+        caps = nl_shaper.cap_get({'ifindex': cfg.ifindex,
+                                  'scope':'node'})
+    except NlError as e:
+        if e.error == 95:
+            cfg.group = False;
+            raise KsftSkipEx("shapers not supported by the device")
+        raise
+    if not 'support-nesting' in caps:
+        raise KsftSkipEx("device does not support node scope shapers nesting")
+
+    node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 3},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 2},
+                             {'handle': {'scope': 'queue', 'id': 3},
+                              'weight': 1}],
+                   'node': {'handle': {'scope':'node'},
+                            'metric': 'bps',
+                            'bw-max': 10000}})
+    node_id = node_handle['handle']['id']
+
+    # Create the nested node and validate the hiearchy
+    nested_node_handle = nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 1},
+                              'weight': 3},
+                             {'handle': {'scope': 'queue', 'id': 2},
+                              'weight': 2}],
+                   'node': {'handle': {'scope':'node'},
+                            'metric': 'bps',
+                            'bw-max': 5000}})
+    nested_node_id = nested_node_handle['handle']['id']
+    ksft_true(nested_node_id != node_id)
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': nested_node_id},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'weight': 3},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': nested_node_id},
+                       'handle': {'scope': 'queue', 'id': 2},
+                       'weight': 2},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': node_id},
+                       'handle': {'scope': 'queue', 'id': 3},
+                       'weight': 1},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'node', 'id': node_id},
+                       'metric': 'bps',
+                       'bw-max': 10000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': node_id},
+                       'handle': {'scope': 'node', 'id': nested_node_id},
+                       'metric': 'bps',
+                       'bw-max': 5000}])
+
+    # Deleting a non empty node will move the leaves downstream.
+    nl_shaper.delete({'ifindex': cfg.ifindex,
+                      'handle': {'scope': 'node', 'id': nested_node_id}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': node_id},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'weight': 3},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': node_id},
+                       'handle': {'scope': 'queue', 'id': 2},
+                       'weight': 2},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'node', 'id': node_id},
+                       'handle': {'scope': 'queue', 'id': 3},
+                       'weight': 1},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'node', 'id': node_id},
+                       'metric': 'bps',
+                       'bw-max': 10000}])
+
+    # Final cleanup.
+    for i in range(1, 4):
+        nl_shaper.delete({'ifindex': cfg.ifindex,
+                          'handle': {'scope': 'queue', 'id': i}})
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(len(shapers), 0)
+
+def queue_update(cfg, nl_shaper) -> None:
+    if cfg.nr_queues < 4:
+        raise KsftSkipEx("netdev does not have enough queues min 4 reported {cfg.nr_queues}")
+    if not cfg.queues:
+        raise KsftSkipEx("device does not support queue scope")
+
+    for i in range(3):
+        nl_shaper.set({'ifindex': cfg.ifindex,
+                       'shaper': {'handle': {'scope': 'queue', 'id': i},
+                                  'metric': 'bps',
+                                  'bw-max': (i + 1) * 1000}})
+    # Delete a channel, with no shapers configured on top of the related
+    # queue: no changes expected
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 3", timeout=10)
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 0},
+                       'metric': 'bps',
+                       'bw-max': 1000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'metric': 'bps',
+                       'bw-max': 2000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 2},
+                       'metric': 'bps',
+                       'bw-max': 3000}])
+
+    # Delete a channel, with a shaper configured on top of the related
+    # queue: the shaper must be deleted, too
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} 2", timeout=10)
+
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 0},
+                       'metric': 'bps',
+                       'bw-max': 1000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'metric': 'bps',
+                       'bw-max': 2000}])
+
+    # Restore the original channels number, no expected changes
+    cmd(f"ethtool -L {cfg.dev['ifname']} {cfg.rx_type} {cfg.nr_queues}", timeout=10)
+    shapers = nl_shaper.get({'ifindex': cfg.ifindex}, dump=True)
+    ksft_eq(shapers, [{'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 0},
+                       'metric': 'bps',
+                       'bw-max': 1000},
+                      {'ifindex': cfg.ifindex,
+                       'parent': {'scope': 'netdev'},
+                       'handle': {'scope': 'queue', 'id': 1},
+                       'metric': 'bps',
+                       'bw-max': 2000}])
+
+def main() -> None:
+    with NetDrvEnv(__file__, queue_count=4) as cfg:
+        cfg.queues = False
+        cfg.netdev = False
+        cfg.groups = False
+        cfg.nr_queues = 0
+        ksft_run([get_shapers,
+                  get_caps,
+                  set_qshapers,
+                  del_qshapers,
+                  set_nshapers,
+                  del_nshapers,
+                  basic_groups,
+                  qgroups,
+                  delegation,
+                  queue_update], args=(cfg, NetshaperFamily()))
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


