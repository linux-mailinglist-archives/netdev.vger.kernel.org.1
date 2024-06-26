Return-Path: <netdev+bounces-107057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BE9198C6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C5C2814D2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF91922C6;
	Wed, 26 Jun 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNaHfM6d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435414D6E0
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432697; cv=none; b=Sz4xNUNx+3R2mazoK2jYFWjjfhJIGs62s1IeNBD5fA1e3Vlfd8n6BPRxHxBFnlzBNy7qvAeE7EG5qgCn65cU7AGLCIDb46AnkI1ggrjbjOCg0R8KW0euycWUS7el/SnbAMimW0urb/kgote8az/OFXlGYuva2ozA/2dSwjqF3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432697; c=relaxed/simple;
	bh=RcxUgjIDRZXvRHWolDfZIGatTN48Gcot/+SfvfHJzBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdObn3fWy/UB3o4kbwV8IT1XLsnm5bsCljEKbYsYAIwDeI2DNlkTguiJgM4zp1bjfMSFqkmGnajD2HQdprx61M1dQGbf6J5jR8O5/KeGeYDXRLsQeQj8iaA4ODgETNHA7YQBGYOhj32W6aOoPt+jZzNVg9bqKnUEbY8TaTF8iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNaHfM6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12165C116B1;
	Wed, 26 Jun 2024 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432697;
	bh=RcxUgjIDRZXvRHWolDfZIGatTN48Gcot/+SfvfHJzBE=;
	h=From:To:Cc:Subject:Date:From;
	b=GNaHfM6d3prisNj65bj3nwr0Hn6p9Z9/O6Ht+mf8RUub9FDbMfXv9WTdbkmFiQ/Yw
	 cKwn5oYRj/ePIZ2vc3W13ZKzMl9oRHIJ0RYREYKtAB+hR6ksdV15ia4MBf84EKxPUV
	 67Sjj0AbP+XlrVsEpDmndqGReutx2BUcofncTERGZznfcFc8O+Shcexg+ZWnFNPqG4
	 2Zch/DMNyn+xSZn+yWvfFB5XuVltPNATWOOJ+8B/jPW59Y9RVqu9jB6YAY0EVytmOi
	 PJLnquP36DFGgl9C3bIatcNjEd5aUuorxLsFgNXZFQCeSLtsYbp0zU6mNECs2LIvR+
	 qiV3OkPc3Xd1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tcp_metrics: add netlink protocol spec in YAML
Date: Wed, 26 Jun 2024 13:11:33 -0700
Message-ID: <20240626201133.2572487-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a protocol spec for tcp_metrics, so that it's accessible via YNL.
Useful at the very least for testing fixes.

In this episode of "10,000 ways to complicate netlink" the metric
nest has defines which are off by 1. iproute2 does:

        struct rtattr *m[TCP_METRIC_MAX + 1 + 1];

        parse_rtattr_nested(m, TCP_METRIC_MAX + 1, a);

        for (i = 0; i < TCP_METRIC_MAX + 1; i++) {
                // ...
                attr = m[i + 1];

This is too weird to support in YNL, add a new set of defines
with _correct_ values to the official kernel header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 Documentation/netlink/specs/tcp_metrics.yaml | 178 +++++++++++++++++++
 include/uapi/linux/tcp_metrics.h             |  16 ++
 2 files changed, 194 insertions(+)
 create mode 100644 Documentation/netlink/specs/tcp_metrics.yaml

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
new file mode 100644
index 000000000000..cc3aa66f915a
--- /dev/null
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: tcp_metrics
+
+protocol: genetlink-legacy
+
+doc: |
+  Management interface for TCP metrics.
+
+c-family-name: tcp-metrics-genl-name
+c-version-name: tcp-metrics-genl-version
+max-by-define: true
+kernel-policy: global
+
+definitions:
+  -
+    name: tcp-fastopen-cookie-max
+    type: const
+    value: 16
+
+attribute-sets:
+  -
+    name: tcp-metrics
+    name-prefix: tcp-metrics-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: addr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: addr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: age
+        type: u64
+      -
+        name: tw-tsval
+        type: u32
+        doc: unused
+      -
+        name: tw-ts-stamp
+        type: s32
+        doc: unused
+      -
+        name: vals
+        type: nest
+        nested-attributes: metrics
+      -
+        name: fopen-mss
+        type: u16
+      -
+        name: fopen-syn-drops
+        type: u16
+      -
+        name: fopen-syn-drop-ts
+        type: u64
+      -
+        name: fopen-cookie
+        type: binary
+        checks:
+          min-len: tcp-fastopen-cookie-max
+      -
+        name: saddr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: pad
+        type: pad
+
+  -
+    name: metrics
+    # Intentially don't define the name-prefix to match the kernel, see below.
+    doc: |
+      Attributes with metrics. Note that the values here do not match
+      the TCP_METRIC_* defines in the kernel, because kernel defines
+      are off-by one (e.g. rtt is defined as enum 0, while netlink carries
+      attribute type 1).
+    attributes:
+      -
+        name: rtt
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in msecs with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar
+        type: u32
+        doc: |
+          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
+          (left-shift by 2 to get the msec value).
+      -
+        name: ssthresh
+        type: u32
+        doc: Slow Start THRESHold.
+      -
+        name: cwnd
+        type: u32
+        doc: Congestion Window.
+      -
+        name: reodering
+        type: u32
+        doc: Reodering metric.
+      -
+        name: rtt_us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar_us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+
+    -
+      name: get
+      doc: Retrieve metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+
+      do:
+        request: &sel_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+        reply: &all_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+            - age
+            - vals
+            - fopen-mss
+            - fopen-syn-drops
+            - fopen-syn-drop-ts
+            - fopen-cookie
+      dump:
+        reply: *all_attrs
+
+    -
+      name: del
+      doc: Delete metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: *sel_attrs
diff --git a/include/uapi/linux/tcp_metrics.h b/include/uapi/linux/tcp_metrics.h
index 7cb4a172feed..d93d32f163f0 100644
--- a/include/uapi/linux/tcp_metrics.h
+++ b/include/uapi/linux/tcp_metrics.h
@@ -27,6 +27,22 @@ enum tcp_metric_index {
 
 #define TCP_METRIC_MAX	(__TCP_METRIC_MAX - 1)
 
+/* Re-define enum tcp_metric_index, again, using the values carried
+ * as netlink attribute types.
+ */
+enum {
+	TCP_METRICS_A_METRICS_RTT = 1,
+	TCP_METRICS_A_METRICS_RTTVAR,
+	TCP_METRICS_A_METRICS_SSTHRESH,
+	TCP_METRICS_A_METRICS_CWND,
+	TCP_METRICS_A_METRICS_REODERING,
+	TCP_METRICS_A_METRICS_RTT_US,
+	TCP_METRICS_A_METRICS_RTTVAR_US,
+
+	__TCP_METRICS_A_METRICS_MAX
+};
+#define TCP_METRICS_A_METRICS_MAX (__TCP_METRICS_A_METRICS_MAX - 1)
+
 enum {
 	TCP_METRICS_ATTR_UNSPEC,
 	TCP_METRICS_ATTR_ADDR_IPV4,		/* u32 */
-- 
2.45.2


