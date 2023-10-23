Return-Path: <netdev+bounces-43572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BB7D3EE3
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F92A1C20B2C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEA219E9;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNdM6PSN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699AE219E2;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1678FC433CB;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698085046;
	bh=8yVtlg9JD75iQuT86CmHSy5GLAWQTwgZYezbL887lg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YNdM6PSNDQDHooVVH3ieAqYZNdscXoBHuC8H9IpT0q+GYr2z8ZJGLvwr07Okdcqmr
	 vPFlsFwicNghd7q2vNbYDd19RuzHatQFXi0sXdREzzOw2qh8woUvjad5imB4jhQo6x
	 vagyWI8W9zfWjAw/IVhZ6z9FioYe/nNyXxogwU4UTN98DlmN0PhVm+VBMryLses1Ix
	 qxn2urQySUpHT5pGHuQHUvWpqjFL1RoFU3pRRY93ODCgB4r4CfvF7qstdvl9R4C9f1
	 SCOTwFRetu14OEaBnwmD7gjNtPOxmjqCjcf4WQsJ/hAeJd9STPkyt+yZYAsAhOTo47
	 LLKDGCEzr4tpA==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 11:17:08 -0700
Subject: [PATCH net-next v2 4/7] Documentation: netlink: add a YAML spec
 for mptcp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-1-v2-4-16b1f701f900@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.12.4

From: Davide Caratti <dcaratti@redhat.com>

it describes most of the current netlink interface (uAPI definitions,
doit/dumpit operations and attributes)

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 Documentation/netlink/specs/mptcp.yaml | 391 +++++++++++++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 2 files changed, 392 insertions(+)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
new file mode 100644
index 000000000000..ec5c454a87ea
--- /dev/null
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -0,0 +1,391 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: mptcp_pm
+protocol: genetlink-legacy
+doc: Multipath TCP.
+
+c-family-name: mptcp-pm-name
+c-version-name: mptcp-pm-ver
+max-by-define: true
+kernel-policy: per-op
+
+definitions:
+  -
+    type: enum
+    name: event-type
+    enum-name: mptcp-event-type
+    name-prefix: mptcp-event-
+    entries:
+     -
+      name: unspec
+      doc: unused event
+     -
+      name: created
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A new MPTCP connection has been created. It is the good time to
+        allocate memory and send ADD_ADDR if needed. Depending on the
+        traffic-patterns it can take a long time until the
+        MPTCP_EVENT_ESTABLISHED is sent.
+     -
+      name: established
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A MPTCP connection is established (can start new subflows).
+     -
+      name: closed
+      doc:
+        token
+        A MPTCP connection has stopped.
+     -
+      name: announced
+      value: 6
+      doc:
+        token, rem_id, family, daddr4 | daddr6 [, dport]
+        A new address has been announced by the peer.
+     -
+      name: removed
+      doc:
+        token, rem_id
+        An address has been lost by the peer.
+     -
+      name: sub-established
+      value: 10
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A new subflow has been established. 'error' should not be set.
+     -
+      name: sub-closed
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A subflow has been closed. An error (copy of sk_err) could be set if an
+        error has been detected for this subflow.
+     -
+      name: sub-priority
+      value: 13
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        The priority of a subflow has changed. 'error' should not be set.
+     -
+      name: listener-created
+      value: 15
+      doc:
+        family, sport, saddr4 | saddr6
+        A new PM listener is created.
+     -
+      name: listener-closed
+      doc:
+        family, sport, saddr4 | saddr6
+        A PM listener is closed.
+
+attribute-sets:
+  -
+    name: address
+    name-prefix: mptcp-pm-addr-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: family
+        type: u16
+      -
+        name: id
+        type: u8
+      -
+        name: addr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: addr6
+        type: binary
+        checks:
+          exact-len: 16
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: if-idx
+        type: s32
+  -
+    name: subflow-attribute
+    name-prefix: mptcp-subflow-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token-rem
+        type: u32
+      -
+        name: token-loc
+        type: u32
+      -
+        name: relwrite-seq
+        type: u32
+      -
+        name: map-seq
+        type: u64
+      -
+        name: map-sfseq
+        type: u32
+      -
+        name: ssn-offset
+        type: u32
+      -
+        name: map-datalen
+        type: u16
+      -
+        name: flags
+        type: u32
+      -
+        name: id-rem
+        type: u8
+      -
+        name: id-loc
+        type: u8
+      -
+        name: pad
+        type: pad
+  -
+    name: endpoint
+    name-prefix: mptcp-pm-endpoint-
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+  -
+    name: attr
+    name-prefix: mptcp-pm-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+      -
+        name: rcv-add-addrs
+        type: u32
+      -
+        name: subflows
+        type: u32
+      -
+        name: token
+        type: u32
+      -
+        name: loc-id
+        type: u8
+      -
+        name: addr-remote
+        type: nest
+        nested-attributes: address
+  -
+    name: event-attr
+    enum-name: mptcp-event-attr
+    name-prefix: mptcp-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token
+        type: u32
+      -
+        name: family
+        type: u16
+      -
+        name: loc-id
+        type: u8
+      -
+        name: rem-id
+        type: u8
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: saddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: daddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: backup
+        type: u8
+      -
+        name: error
+        type: u8
+      -
+        name: flags
+        type: u16
+      -
+        name: timeout
+        type: u32
+      -
+        name: if_idx
+        type: u32
+      -
+        name: reset-reason
+        type: u32
+      -
+        name: reset-flags
+        type: u32
+      -
+        name: server-side
+        type: u8
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: add-addr
+      doc: Add endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &add-addr-attrs
+        request:
+          attributes:
+            - addr
+    -
+      name: del-addr
+      doc: Delete endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add-addr-attrs
+    -
+      name: get-addr
+      doc: Get endpoint information
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &get-addr-attrs
+        request:
+          attributes:
+           - addr
+        reply:
+          attributes:
+           - addr
+      dump:
+        reply:
+         attributes:
+           - addr
+    -
+      name:  flush-addrs
+      doc: flush addresses
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add-addr-attrs
+    -
+      name: set-limits
+      doc: Set protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp-limits
+        request:
+          attributes:
+            - rcv-add-addrs
+            - subflows
+    -
+      name: get-limits
+      doc: Get protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      do: &mptcp-get-limits
+        request:
+           attributes:
+            - rcv-add-addrs
+            - subflows
+        reply:
+          attributes:
+            - rcv-add-addrs
+            - subflows
+    -
+      name: set-flags
+      doc: Change endpoint flags
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp-set-flags
+        request:
+          attributes:
+            - addr
+            - token
+            - addr-remote
+    -
+      name: announce
+      doc: announce new sf
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &announce-add
+        request:
+          attributes:
+            - addr
+            - token
+    -
+      name: remove
+      doc: announce removal
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do:
+        request:
+         attributes:
+           - token
+           - loc-id
+    -
+      name: subflow-create
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &sf-create
+        request:
+          attributes:
+            - addr
+            - token
+            - addr-remote
+    -
+      name: subflow-destroy
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *sf-create
diff --git a/MAINTAINERS b/MAINTAINERS
index 36815d2feb33..977de4624fe0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14960,6 +14960,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
+F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h

-- 
2.41.0


