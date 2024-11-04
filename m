Return-Path: <netdev+bounces-141594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF799BBA9C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9F4B21F74
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AC1C4A15;
	Mon,  4 Nov 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drv5R7ov"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EA1C4A03
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739247; cv=none; b=VGOJS+RNMVEsSO5cQEn86HlLq4qf8aQ2t5OikpdzuOPLgsWPVEWDY4cU0q/W9SjQqThzBqGtn69g3r47rPdjX4wi82wblkr8YwgatR9XlfOVdDdf2OB9HrEn09JFHDoaQh0MICqdvqufJxb9RONGzfZsqqQmB8P75wQFxL0sXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739247; c=relaxed/simple;
	bh=/kz6zYS1coR8IXTeKtlnrDgIJK2lk5J/upf+uXtIZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDipfcc4gJX2av+iakMRLkc6CcyWhY2/17I9UX5ztA0Pj9qDPXZqAdfmbe1R/bKCFDS1pX1cTBwGL9RiCygokuVH6InbVPdPiZ7IJaOrXnhcsYyS+YneVpv723R7EXEtxNz4PIpEm9nFZhH71Aw2PuC1piLS6DfTY734/Mv1qD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drv5R7ov; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so38870035e9.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739243; x=1731344043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAZDj9vqx/oXtwM7TizqrlISXvRC0yAqIYkxx21t5WU=;
        b=drv5R7ovrB6CD/LzN/Ez5vq2az12QqWK3xynRXTSCZSBrDu+p3DZxzbAH41A196MM+
         ATPEqujNZExGm90Vj+XRkBn84kphjzmDLzHNmvFGPuBmkyTj+vvwwHkfN1xKk8ipheAo
         xEWLawnCkq3cO5JAcD2N5RUzrnODZe+MLE5muRioGnSAnSe0iMLlCXtSMSLLMUkfUcKw
         LTiTKQJI4d5rOYW9jPwHlMzZWiec0Tz2dSo+4KVplJnNjiUxymR5jfo1Pm6IuHl50fza
         +AZ1/dSg9bXOW1fsmkIvGeLI/sA7+KTObzzI5ssUQFOo+BHzloHkWSyyhl3Z+LqNEPTW
         INuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739243; x=1731344043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAZDj9vqx/oXtwM7TizqrlISXvRC0yAqIYkxx21t5WU=;
        b=sErUn74Ne4JgnwmdZXydERTZijORATm5Pv3f9DcSjxQgOZyMwu8/RAOG2JRgkRePbn
         yza6m2Q9LEJ7BElm+4VNr24oM5tVbzy3NM1PMOS2s48NPacenLeQS0uYde1YXgNCKXO+
         b+u9rzyj/oZtCY/lYPxEiBh5eGjw/Bumy9LfCAPGlLX4+CFrLYWn8NryHnqLvhTQiI67
         yycCuHSIpsrCLvRjf9rbhyaI5qN9vvTSWeciJUZXN0vnb80NiZC2yzlN4PeCkNkBHTpz
         aQpQ2rA38dX4FDSbge4TwvE54omE+1RVwPJRWSKmgLeFj/RoiLSlhTfkLE95MzqsNLan
         1LZw==
X-Gm-Message-State: AOJu0YwXXbJy4nVN9odif9Hl4RwQmMrj5SDzR6H7ARmIbt89bNQeiKN7
	VuehtMgijzuB04GwKGjOAmFkFXlKpEubgJsFs9UKj7PrtGTr0H0GRRN/SA==
X-Google-Smtp-Source: AGHT+IHUrX9/pP46GgV0is9wzbSJbKrffpjk+3+X11P8ee8lkbYMSiYDqr3juhndEeOrmAFRAZn10Q==
X-Received: by 2002:a05:600c:4510:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-4319ac70767mr292396995e9.2.1730739242797;
        Mon, 04 Nov 2024 08:54:02 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:71af:4a7:35c:6d53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852e4sm156878085e9.29.2024.11.04.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:54:02 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/2] netlink: specs: Add a spec for neighbor tables in rtnetlink
Date: Mon,  4 Nov 2024 16:53:51 +0000
Message-ID: <20241104165352.19696-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241104165352.19696-1-donald.hunter@gmail.com>
References: <20241104165352.19696-1-donald.hunter@gmail.com>
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


