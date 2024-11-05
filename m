Return-Path: <netdev+bounces-141966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6F9BCCB6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52149B23350
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B491D5CE3;
	Tue,  5 Nov 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXIqHU4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A341C3025
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809721; cv=none; b=HXXkfeTTAA5Qjb3fWNnzHM7Rf099kUsQ9W6RZcDvzXE1HfF5WvxvHyn5G8UGVuVg/bwuzUc0mvB4kZLPifHmanHvN3ZL6KJJ1aawOZle6rOSHQ0+bXCFCyi5H9Q37VvpG1A8I6r9cziJYnoSH+JXkhkLXzIErbTAhBwXCJSykiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809721; c=relaxed/simple;
	bh=6ea4YInVNGHCYIgZzf1srSJn6ndPBtFrTnr0u+hwW+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul0x0tHpWJJfw5HWFBrHH3PJCtp7jrjt1q9JVooW9KT5LTD3NMMHgpNAPFRfRXB5ybWdz4t0VcbhleTNqNDvCRGceBXIOD5Th7lck9N3PjvaIGriX8qe7fQTR+1GvHhkMhpF3ipFH5n8FfataKddrdPUGRIK660BKHczKd4dZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXIqHU4g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431616c23b5so33693125e9.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730809718; x=1731414518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUFBKFOLzJe5iOwKSy8aC1/GxXnXDck/TO4mpGwgOUM=;
        b=VXIqHU4gwSvw/v+j4298PQAPSDKirZIRo4cfkPsweMk9FPbSSBLkwM3I8XlFzazaA6
         g6XRKO5WatjL2XaNvZm2GbFZSwvukqilCNsaxhdsQgu9T3rwAPrTbLbwqTLAn9wZyLhf
         fsL1IrU0yLYngzV10onnjpM6HB79n+XaLNGYqJbFfNyQEHdCxfxGpU7q+ZQTyGOdrN0s
         uKqevZUHSgpeJo1X4H6AoIO1GZGIDlmAqAI+lO7rT642B5yeq8zWWtLZ38xvl1ZUki7H
         QOUQ/U73smfQEszzNNwuvWLwa4a+Kd3BnkZx/DQITCv3hyqxuyEAUnIWtVppIHngbNpu
         EgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809718; x=1731414518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUFBKFOLzJe5iOwKSy8aC1/GxXnXDck/TO4mpGwgOUM=;
        b=h/rU2Tn6uDwW48d+62aZAi/tSUIwLe97lqcMpOB8CKWFRiugeoUk7KdcM+MtkE9pGa
         t4FrpAbfLiJk2iBHUJWSQaQnbQvmLQIgfX23BMZOclPNlhmcT1LuIStYKSNPbWhc17pc
         TAkfswBSPcFwOYlBrghERgH1Gg8ANZ1YmuRzuG7Oa44Iva9xBKAGv5voJ4dDuKWaSbAC
         aP18yW4M3353FwngmWCGWrHXG2sOTMfPBrNcASxFqaYwwPIm59Z0O2y+nvBwdn2yiZjY
         /l5DfxLrrXoFEvNAn07qKSGKKjsaHJs0a2waPAwNpRltPON4M4NMTU9/X394V//2qTIl
         akwA==
X-Gm-Message-State: AOJu0YynXDeFPwDhNkWLmPq1LS8a2p6JfIry8FeL7ShDdHROLPsbtMum
	sD0uyGthDJRaSEA4ZwRlyjSvE4mHezZcCQze0yQVQuzE0xLRZV7EOUqrztif
X-Google-Smtp-Source: AGHT+IEOnSUiebbQH0Ni4e5uhkBAafUHtcQM8BgN5Lxe8VdhiT3Vc7vsXtniomYsSuwz5ImK4mIROg==
X-Received: by 2002:a05:600c:4449:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-4327dac7732mr153277065e9.16.1730809717385;
        Tue, 05 Nov 2024 04:28:37 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49c9sm16137029f8f.37.2024.11.05.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:28:36 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 1/2] netlink: specs: Add a spec for neighbor tables in rtnetlink
Date: Tue,  5 Nov 2024 12:28:30 +0000
Message-ID: <20241105122831.85882-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241105122831.85882-1-donald.hunter@gmail.com>
References: <20241105122831.85882-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YNL spec for neighbour tables and neighbour entries in rtnetlink.

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_neigh.yaml \
    --dump getneigh
[{'cacheinfo': {'confirmed': 122664055,
                'refcnt': 0,
                'updated': 122658055,
                'used': 122658055},
  'dst': '0.0.0.0',
  'family': 2,
  'flags': set(),
  'ifindex': 5,
  'lladr': '',
  'probes': 0,
  'state': {'noarp'},
  'type': 'broadcast'},
  ...]

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_neigh.yaml | 442 ++++++++++++++++++++++
 1 file changed, 442 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_neigh.yaml

diff --git a/Documentation/netlink/specs/rt_neigh.yaml b/Documentation/netlink/specs/rt_neigh.yaml
new file mode 100644
index 000000000000..e670b6dc07be
--- /dev/null
+++ b/Documentation/netlink/specs/rt_neigh.yaml
@@ -0,0 +1,442 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-neigh
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  IP neighbour management over rtnetlink.
+
+definitions:
+  -
+    name: ndmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+      -
+        name: ifindex
+        type: s32
+      -
+        name: state
+        type: u16
+        enum: nud-state
+      -
+        name: flags
+        type: u8
+        enum: ntf-flags
+      -
+        name: type
+        type: u8
+        enum: rtm-type
+  -
+    name: ndtmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+  -
+    name: nud-state
+    type: flags
+    entries:
+      - incomplete
+      - reachable
+      - stale
+      - delay
+      - probe
+      - failed
+      - noarp
+      - permanent
+  -
+    name: ntf-flags
+    type: flags
+    entries:
+      - use
+      - self
+      - master
+      - proxy
+      - ext-learned
+      - offloaded
+      - sticky
+      - router
+  -
+    name: ntf-ext-flags
+    type: flags
+    entries:
+      - managed
+      - locked
+  -
+    name: rtm-type
+    type: enum
+    entries:
+      - unspec
+      - unicast
+      - local
+      - broadcast
+      - anycast
+      - multicast
+      - blackhole
+      - unreachable
+      - prohibit
+      - throw
+      - nat
+      - xresolve
+  -
+    name: nda-cacheinfo
+    type: struct
+    members:
+      -
+        name: confirmed
+        type: u32
+      -
+        name: used
+        type: u32
+      -
+        name: updated
+        type: u32
+      -
+        name: refcnt
+        type: u32
+  -
+    name: ndt-config
+    type: struct
+    members:
+      -
+        name: key-len
+        type: u16
+      -
+        name: entry-size
+        type: u16
+      -
+        name: entries
+        type: u32
+      -
+        name: last-flush
+        type: u32
+      -
+        name: last-rand
+        type: u32
+      -
+        name: hash-rnd
+        type: u32
+      -
+        name: hash-mask
+        type: u32
+      -
+        name: hash-chain-gc
+        type: u32
+      -
+        name: proxy-qlen
+        type: u32
+  -
+    name: ndt-stats
+    type: struct
+    members:
+      -
+        name: allocs
+        type: u64
+      -
+        name: destroys
+        type: u64
+      -
+        name: hash-grows
+        type: u64
+      -
+        name: res-failed
+        type: u64
+      -
+        name: lookups
+        type: u64
+      -
+        name: hits
+        type: u64
+      -
+        name: rcv-probes-mcast
+        type: u64
+      -
+        name: rcv-probes-ucast
+        type: u64
+      -
+        name: periodic-gc-runs
+        type: u64
+      -
+        name: forced-gc-runs
+        type: u64
+      -
+        name: table-fulls
+        type: u64
+
+attribute-sets:
+  -
+    name: neighbour-attrs
+    attributes:
+      -
+        name: unspec
+        type: binary
+        value: 0
+      -
+        name: dst
+        type: binary
+        display-hint: ipv4
+      -
+        name: lladr
+        type: binary
+        display-hint: mac
+      -
+        name: cacheinfo
+        type: binary
+        struct: nda-cacheinfo
+      -
+        name: probes
+        type: u32
+      -
+        name: vlan
+        type: u16
+      -
+        name: port
+        type: u16
+      -
+        name: vni
+        type: u32
+      -
+        name: ifindex
+        type: u32
+      -
+        name: master
+        type: u32
+      -
+        name: link-netnsid
+        type: s32
+      -
+        name: src-vni
+        type: u32
+      -
+        name: protocol
+        type: u8
+      -
+        name: nh-id
+        type: u32
+      -
+        name: fdb-ext-attrs
+        type: binary
+      -
+        name: flags-ext
+        type: u32
+        enum: ntf-ext-flags
+      -
+        name: ndm-state-mask
+        type: u16
+      -
+        name: ndm-flags-mask
+        type: u8
+  -
+    name: ndt-attrs
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: thresh1
+        type: u32
+      -
+        name: thresh2
+        type: u32
+      -
+        name: thresh3
+        type: u32
+      -
+        name: config
+        type: binary
+        struct: ndt-config
+      -
+        name: parms
+        type: nest
+        nested-attributes: ndtpa-attrs
+      -
+        name: stats
+        type: binary
+        struct: ndt-stats
+      -
+        name: gc-interval
+        type: u64
+      -
+        name: pad
+        type: pad
+  -
+    name: ndtpa-attrs
+    attributes:
+      -
+        name: ifindex
+        type: u32
+      -
+        name: refcnt
+        type: u32
+      -
+        name: reachable-time
+        type: u64
+      -
+        name: base-reachable-time
+        type: u64
+      -
+        name: retrans-time
+        type: u64
+      -
+        name: gc-staletime
+        type: u64
+      -
+        name: delay-probe-time
+        type: u64
+      -
+        name: queue-len
+        type: u32
+      -
+        name: app-probes
+        type: u32
+      -
+        name: ucast-probes
+        type: u32
+      -
+        name: mcast-probes
+        type: u32
+      -
+        name: anycast-delay
+        type: u64
+      -
+        name: proxy-delay
+        type: u64
+      -
+        name: proxy-qlen
+        type: u32
+      -
+        name: locktime
+        type: u64
+      -
+        name: queue-lenbytes
+        type: u32
+      -
+        name: mcast-reprobes
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: interval-probe-time-ms
+        type: u64
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newneigh
+      doc: Add new neighbour entry
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 28
+          attributes: &neighbour-all
+            - dst
+            - lladdr
+            - probes
+            - vlan
+            - port
+            - vni
+            - ifindex
+            - master
+            - protocol
+            - nh-id
+            - flags-ext
+            - fdb-ext-attrs
+    -
+      name: delneigh
+      doc: Remove an existing neighbour entry
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 29
+          attributes:
+            - dst
+            - ifindex
+    -
+      name: delneigh-ntf
+      doc: Notify a neighbour deletion
+      value: 29
+      notify: delneigh
+      fixed-header: ndmsg
+    -
+      name: getneigh
+      doc: Get or dump neighbour entries
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 30
+          attributes:
+            - dst
+        reply:
+          value: 28
+          attributes: *neighbour-all
+      dump:
+        request:
+          attributes:
+            - ifindex
+            - master
+        reply:
+          attributes: *neighbour-all
+    -
+      name: newneigh-ntf
+      doc: Notify a neighbour creation
+      value: 28
+      notify: getneigh
+      fixed-header: ndmsg
+    -
+      name: getneightbl
+      doc: Get or dump neighbour tables
+      fixed-header: ndtmsg
+      attribute-set: ndt-attrs
+      dump:
+        request:
+          value: 66
+        reply:
+          value: 64
+          attributes:
+            - name
+            - thresh1
+            - thresh2
+            - thresh3
+            - config
+            - parms
+            - stats
+            - gc-interval
+    -
+      name: setneightbl
+      doc: Set neighbour tables
+      fixed-header: ndtmsg
+      attribute-set: ndt-attrs
+      do:
+        request:
+          value: 67
+          attributes:
+            - name
+            - thresh1
+            - thresh2
+            - thresh3
+            - parms
+            - gc-interval
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-neigh
+      value: 3
-- 
2.47.0


