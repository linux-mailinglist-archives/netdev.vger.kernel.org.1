Return-Path: <netdev+bounces-106074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041379148AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41164B26307
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBC13B580;
	Mon, 24 Jun 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ALgDhMzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACA13A252
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228593; cv=none; b=UdHEDTh0RWWeea4GvIIEiMjiFjXRCb25MZEKocvGVLP/u3CR4PjJMjK/DMKfz1DnwJUli1e5Cu9/q4EqGxcH+eju/zazQtsuOmfHVJOxXT3Pp43cw3FepkZSbSrcXQ5cPkha9hGJqn82mCi5h6IyzvboFdgcffQ4fCe6hLF4ntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228593; c=relaxed/simple;
	bh=nTcz/lRW+hnaUwe0GFdrPUGxa4Fpb/F2hUbuCKBQ9Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlQ0KqMOYYOM7VmENBl21nM61yyQ1I/h1kKGegkYbDJJtsotOXxilEHrG95AvZ6VZdsUKgCtQPOI39T2fdbEy/th5fyDqa5sNrHS4xwLaYmipcoEq1E3L2owu+0geJGW2ClsVTmMKtzs4N6iN/5SOy/rzZhH6+doj/0L6lVhwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ALgDhMzU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so34985505e9.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228588; x=1719833388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI1rOYiG3eu+GrvhqUjGDn4yuUonWX819/sh1iEOTZ0=;
        b=ALgDhMzU9YLhSNX7G6umSphyOqQEhOKgtQ027BEG6+5ELB+//bkzZ28ndj1V7aZCzk
         VIxEoaTjo0LKrDlB8GVEBZnzM6C+fSBq4PgNo3hhaFwzZqND6MGZp26a6IsM5XMMYE+w
         n/pUK9/yhDghu3tJvL2cOzidOWmAwDwzzXVdYqSbm1hWkwb4Za5LBv6KGG8tPzedjwLv
         nbD+SSz5laebpeZoP6kVH09pVviYqB/06TnCFAj5E3tAwwdPGHMxxOukSiloSNjo3SHj
         mlVe5Y1YfCw1D1h1n1Eh599kVjL2FnSwSzvRflAj0/Rkr2Bb7OoZLcX3/Of8mbH/ApAC
         x6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228588; x=1719833388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI1rOYiG3eu+GrvhqUjGDn4yuUonWX819/sh1iEOTZ0=;
        b=MLU2DLiD2lrlY6bB5fgLiJI1P1RrVkkdShH1M+I7OaPS/rb7sW8967TWsiqNhnZPpj
         qL5VW24jD5Mr+vVQj5H9eQlbW2jUmdGXSP6RZAARcVLCG3CieT+C+RU2Iebjc2cP9Ib7
         4Gh0F7omzReMZMT0R7eaONCrP5LnDz5j3XEGNcWmDuittvQi7h1EboxEfKeJjXP7UeE4
         vLXyS1l0jPas7MpA8/mBtfxF682wqClVZd/lfo8pynn/dSFlY07iC4s633milFyk/7iG
         NaviHibobDzHb/r/NnUvD7IDg5+hufhZGSobQNp8DdC9xdt8lK+HIvpt3TjNcO4hu89Q
         IxrA==
X-Gm-Message-State: AOJu0YzTUHsPprtFwYniL9SYdtnZVeXkHL2Vz83AaQ/xgf9TS/XV3Ine
	C2hSb7UhqTWPts1fb1gmqGqZfxnMdqgQOOXKWyGluHUQMppB0k5UuMsWjsmVSa7xfRY+o8cyH7I
	B
X-Google-Smtp-Source: AGHT+IF0ZqP/lxv5PdRW3b1HbS5bCNaghPB+9GwBjNfweFpuDCJ7BJ3YTCGUmzwwx4vkEFORBums/g==
X-Received: by 2002:a05:600c:56cf:b0:423:6b7:55eb with SMTP id 5b1f17b1804b1-4248cc2b65cmr25620605e9.14.1719228587948;
        Mon, 24 Jun 2024 04:29:47 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 04/25] ovpn: add basic netlink support
Date: Mon, 24 Jun 2024 13:31:01 +0200
Message-ID: <20240624113122.12732-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces basic netlink support with family
registration/unregistration functionalities and stub pre/post-doit.

More importantly it introduces the YAML uAPI description along
with its auto-generated files:
- include/uapi/linux/ovpn.h
- drivers/net/ovpn/netlink-gen.c
- drivers/net/ovpn/netlink-gen.h

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml | 327 ++++++++++++++++++++++++++
 drivers/net/ovpn/Makefile             |   2 +
 drivers/net/ovpn/main.c               |  14 ++
 drivers/net/ovpn/netlink-gen.c        | 206 ++++++++++++++++
 drivers/net/ovpn/netlink-gen.h        |  41 ++++
 drivers/net/ovpn/netlink.c            | 151 ++++++++++++
 drivers/net/ovpn/netlink.h            |  15 ++
 drivers/net/ovpn/ovpnstruct.h         |  21 ++
 include/uapi/linux/ovpn.h             | 108 +++++++++
 9 files changed, 885 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovpn.yaml
 create mode 100644 drivers/net/ovpn/netlink-gen.c
 create mode 100644 drivers/net/ovpn/netlink-gen.h
 create mode 100644 drivers/net/ovpn/netlink.c
 create mode 100644 drivers/net/ovpn/netlink.h
 create mode 100644 drivers/net/ovpn/ovpnstruct.h
 create mode 100644 include/uapi/linux/ovpn.h

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
new file mode 100644
index 000000000000..68ed88d03732
--- /dev/null
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -0,0 +1,327 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Author: Antonio Quartulli <antonio@openvpn.net>
+#
+# Copyright (c) 2024, OpenVPN Inc.
+#
+
+name: ovpn
+
+protocol: genetlink
+
+doc: Netlink protocol to control OpenVPN network devices
+
+definitions:
+  -
+    type: const
+    name: nonce-tail-size
+    value: 8
+  -
+    type: enum
+    name: cipher-alg
+    value-start: 0
+    entries: [ none, aes-gcm, chacha20_poly1305 ]
+  -
+    type: enum
+    name: del-peer_reason
+    value-start: 0
+    entries: [ teardown, userspace, expired, transport-error, transport_disconnect ]
+  -
+    type: enum
+    name: key-slot
+    value-start: 0
+    entries: [ primary, secondary ]
+  -
+    type: enum
+    name: mode
+    value-start: 0
+    entries: [ p2p, mp ]
+
+attribute-sets:
+  -
+    name: peer
+    attributes:
+      -
+        name: id
+        type: u32
+        doc: |
+          The unique Id of the peer. To be used to identify peers during
+          operations
+        checks:
+          max: 0xFFFFFF
+      -
+        name: sockaddr-remote
+        type: binary
+        doc: |
+          The sockaddr_in/in6 object identifying the remote address/port of the
+          peer
+      -
+        name: socket
+        type: u32
+        doc: The socket to be used to communicate with the peer
+      -
+        name: vpn-ipv4
+        type: u32
+        doc: The IPv4 assigned to the peer by the server
+        display-hint: ipv4
+      -
+        name: vpn-ipv6
+        type: binary
+        doc: The IPv6 assigned to the peer by the server
+        display-hint: ipv6
+        checks:
+          exact-len: 16
+      -
+        name: local-ip
+        type: binary
+        doc: The local IP to be used to send packets to the peer (UDP only)
+        checks:
+          max-len: 16
+      -
+        name: local-port
+        type: u32
+        doc: The local port to be used to send packets to the peer (UDP only)
+        checks:
+          min: 1
+          max: u16-max
+      -
+        name: keepalive-interval
+        type: u32
+        doc: |
+          The number of seconds after which a keep alive message is sent to the
+          peer
+      -
+        name: keepalive-timeout
+        type: u32
+        doc: |
+          The number of seconds from the last activity after which the peer is
+          assumed dead
+      -
+        name: del-reason
+        type: u32
+        doc: The reason why a peer was deleted
+        enum: del-peer_reason
+      -
+        name: keyconf
+        type: nest
+        doc: Peer specific cipher configuration
+        nested-attributes: keyconf
+      -
+        name: vpn-rx_bytes
+        type: uint
+        doc: Number of bytes received over the tunnel
+      -
+        name: vpn-tx_bytes
+        type: uint
+        doc: Number of bytes transmitted over the tunnel
+      -
+        name: vpn-rx_packets
+        type: uint
+        doc: Number of packets received over the tunnel
+      -
+        name: vpn-tx_packets
+        type: uint
+        doc: Number of packets transmitted over the tunnel
+      -
+        name: link-rx_bytes
+        type: uint
+        doc: Number of bytes received at the transport level
+      -
+        name: link-tx_bytes
+        type: uint
+        doc: Number of bytes transmitted at the transport level
+      -
+        name: link-rx_packets
+        type: u32
+        doc: Number of packets received at the transport level
+      -
+        name: link-tx_packets
+        type: u32
+        doc: Number of packets transmitted at the transport level
+  -
+    name: keyconf
+    attributes:
+      -
+        name: slot
+        type: u32
+        doc: The slot where the key should be stored
+        enum: key-slot
+      -
+        name: key-id
+        doc: |
+          The unique ID for the key. Used to fetch the correct key upon
+          decryption
+        type: u32
+        checks:
+          max: 2
+      -
+        name: cipher-alg
+        type: u32
+        doc: The cipher to be used when communicating with the peer
+        enum: cipher-alg
+      -
+        name: encrypt-dir
+        type: nest
+        doc: Key material for encrypt direction
+        nested-attributes: keydir
+      -
+        name: decrypt-dir
+        type: nest
+        doc: Key material for decrypt direction
+        nested-attributes: keydir
+  -
+    name: keydir
+    attributes:
+      -
+        name: cipher-key
+        type: binary
+        doc: The actual key to be used by the cipher
+        checks:
+         max-len: 256
+      -
+        name: nonce-tail
+        type: binary
+        doc: |
+          Random nonce to be concatenated to the packet ID, in order to
+          obtain the actua cipher IV
+        checks:
+         exact-len: nonce-tail-size
+  -
+    name: ovpn
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Index of the ovpn interface to operate on
+      -
+        name: ifname
+        type: string
+        doc: Name of the ovpn interface that is being created
+      -
+        name: mode
+        type: u32
+        enum: mode
+        doc: |
+          Oper mode instructing an interface to act as Point2Point or
+          MultiPoint
+      -
+        name: peer
+        type: nest
+        doc: |
+          The peer object containing the attributed of interest for the specific
+          operation
+        nested-attributes: peer
+
+operations:
+  list:
+    -
+      name: new-iface
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Create a new interface
+      do:
+        request:
+          attributes:
+            - ifname
+            - mode
+        reply:
+          attributes:
+            - ifname
+    -
+      name: del-iface
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Delete existing interface
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+    -
+      name: set-peer
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Add or modify a remote peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: get-peer
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Retrieve data about existing remote peers (or a specific one)
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+        reply:
+          attributes:
+            - peer
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes:
+            - peer
+    -
+      name: del-peer
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Delete existing remote peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: set-key
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Add or modify a cipher key for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: swap-keys
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Swap primary and secondary session keys for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+    -
+      name: del-key
+      attribute-set: ovpn
+      flags: [ admin-perm ]
+      doc: Delete cipher key for a specific peer
+      do:
+        pre: ovpn-nl-pre-doit
+        post: ovpn-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - peer
+
+mcast-groups:
+  list:
+    -
+      name: peers
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 53fb197027d7..201dc001419f 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -9,3 +9,5 @@
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
 ovpn-y += io.o
+ovpn-y += netlink.o
+ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 8a90319e4600..7c35697cb596 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,12 +7,16 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/version.h>
 #include <net/rtnetlink.h>
+#include <uapi/linux/ovpn.h>
 
+#include "ovpnstruct.h"
 #include "main.h"
+#include "netlink.h"
 #include "io.h"
 
 /* Driver info */
@@ -34,6 +38,7 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
  * therefore ifaces should be destroyed when exiting a netns
  */
 static struct rtnl_link_ops ovpn_link_ops = {
+	.kind = OVPN_FAMILY_NAME,
 };
 
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
@@ -86,8 +91,16 @@ static int __init ovpn_init(void)
 		goto unreg_netdev;
 	}
 
+	err = ovpn_nl_register();
+	if (err) {
+		pr_err("ovpn: can't register netlink family: %d\n", err);
+		goto unreg_rtnl;
+	}
+
 	return 0;
 
+unreg_rtnl:
+	rtnl_link_unregister(&ovpn_link_ops);
 unreg_netdev:
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 	return err;
@@ -95,6 +108,7 @@ static int __init ovpn_init(void)
 
 static __exit void ovpn_cleanup(void)
 {
+	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
new file mode 100644
index 000000000000..594eb2c50eb5
--- /dev/null
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink-gen.h"
+
+#include <uapi/linux/ovpn.h>
+
+/* Integer value ranges */
+static const struct netlink_range_validation ovpn_a_peer_id_range = {
+	.max	= 16777215ULL,
+};
+
+static const struct netlink_range_validation ovpn_a_peer_local_port_range = {
+	.min	= 1ULL,
+	.max	= 65535ULL,
+};
+
+/* Common nested types */
+const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
+	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
+	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 2),
+	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
+	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
+	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
+};
+
+const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1] = {
+	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(256),
+	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(OVPN_NONCE_TAIL_SIZE),
+};
+
+const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1] = {
+	[OVPN_A_PEER_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_id_range),
+	[OVPN_A_PEER_SOCKADDR_REMOTE] = { .type = NLA_BINARY, },
+	[OVPN_A_PEER_SOCKET] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_U32, },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(16),
+	[OVPN_A_PEER_LOCAL_IP] = NLA_POLICY_MAX_LEN(16),
+	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_FULL_RANGE(NLA_U32, &ovpn_a_peer_local_port_range),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32, },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32, },
+	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_MAX(NLA_U32, 4),
+	[OVPN_A_PEER_KEYCONF] = NLA_POLICY_NESTED(ovpn_keyconf_nl_policy),
+	[OVPN_A_PEER_VPN_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_RX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_VPN_TX_PACKETS] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_TX_BYTES] = { .type = NLA_UINT, },
+	[OVPN_A_PEER_LINK_RX_PACKETS] = { .type = NLA_U32, },
+	[OVPN_A_PEER_LINK_TX_PACKETS] = { .type = NLA_U32, },
+};
+
+/* OVPN_CMD_NEW_IFACE - do */
+static const struct nla_policy ovpn_new_iface_nl_policy[OVPN_A_MODE + 1] = {
+	[OVPN_A_IFNAME] = { .type = NLA_NUL_STRING, },
+	[OVPN_A_MODE] = NLA_POLICY_MAX(NLA_U32, 1),
+};
+
+/* OVPN_CMD_DEL_IFACE - do */
+static const struct nla_policy ovpn_del_iface_nl_policy[OVPN_A_IFINDEX + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* OVPN_CMD_SET_PEER - do */
+static const struct nla_policy ovpn_set_peer_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_GET_PEER - do */
+static const struct nla_policy ovpn_get_peer_do_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_GET_PEER - dump */
+static const struct nla_policy ovpn_get_peer_dump_nl_policy[OVPN_A_IFINDEX + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+};
+
+/* OVPN_CMD_DEL_PEER - do */
+static const struct nla_policy ovpn_del_peer_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_SET_KEY - do */
+static const struct nla_policy ovpn_set_key_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_SWAP_KEYS - do */
+static const struct nla_policy ovpn_swap_keys_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* OVPN_CMD_DEL_KEY - do */
+static const struct nla_policy ovpn_del_key_nl_policy[OVPN_A_PEER + 1] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32, },
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_peer_nl_policy),
+};
+
+/* Ops table for ovpn */
+static const struct genl_split_ops ovpn_nl_ops[] = {
+	{
+		.cmd		= OVPN_CMD_NEW_IFACE,
+		.doit		= ovpn_nl_new_iface_doit,
+		.policy		= ovpn_new_iface_nl_policy,
+		.maxattr	= OVPN_A_MODE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_DEL_IFACE,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_del_iface_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_del_iface_nl_policy,
+		.maxattr	= OVPN_A_IFINDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_SET_PEER,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_set_peer_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_set_peer_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_GET_PEER,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_get_peer_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_get_peer_do_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_GET_PEER,
+		.dumpit		= ovpn_nl_get_peer_dumpit,
+		.policy		= ovpn_get_peer_dump_nl_policy,
+		.maxattr	= OVPN_A_IFINDEX,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= OVPN_CMD_DEL_PEER,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_del_peer_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_del_peer_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_SET_KEY,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_set_key_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_set_key_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_SWAP_KEYS,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_swap_keys_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_swap_keys_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= OVPN_CMD_DEL_KEY,
+		.pre_doit	= ovpn_nl_pre_doit,
+		.doit		= ovpn_nl_del_key_doit,
+		.post_doit	= ovpn_nl_post_doit,
+		.policy		= ovpn_del_key_nl_policy,
+		.maxattr	= OVPN_A_PEER,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
+	[OVPN_NLGRP_PEERS] = { "peers", },
+};
+
+struct genl_family ovpn_nl_family __ro_after_init = {
+	.name		= OVPN_FAMILY_NAME,
+	.version	= OVPN_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= ovpn_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(ovpn_nl_ops),
+	.mcgrps		= ovpn_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ovpn_nl_mcgrps),
+};
diff --git a/drivers/net/ovpn/netlink-gen.h b/drivers/net/ovpn/netlink-gen.h
new file mode 100644
index 000000000000..ce11f74e1b56
--- /dev/null
+++ b/drivers/net/ovpn/netlink-gen.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_OVPN_GEN_H
+#define _LINUX_OVPN_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ovpn.h>
+
+/* Common nested types */
+extern const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1];
+extern const struct nla_policy ovpn_keydir_nl_policy[OVPN_A_KEYDIR_NONCE_TAIL + 1];
+extern const struct nla_policy ovpn_peer_nl_policy[OVPN_A_PEER_LINK_TX_PACKETS + 1];
+
+int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info);
+void
+ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info);
+
+int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_get_peer_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_set_key_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_swap_keys_doit(struct sk_buff *skb, struct genl_info *info);
+int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	OVPN_NLGRP_PEERS,
+};
+
+extern struct genl_family ovpn_nl_family;
+
+#endif /* _LINUX_OVPN_GEN_H */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
new file mode 100644
index 000000000000..5f2c1eacc463
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/ovpn.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "netlink.h"
+#include "netlink-gen.h"
+
+MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
+
+/**
+ * ovpn_get_dev_from_attrs - retrieve the netdevice a netlink message is
+ *                           targeting
+ * @net: network namespace where to look for the interface
+ * @info: generic netlink info from the user request
+ *
+ * Return: the netdevice, if found, or an error otherwise
+ */
+static struct net_device *
+ovpn_get_dev_from_attrs(struct net *net, struct genl_info *info)
+{
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_IFINDEX))
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[OVPN_A_IFINDEX]);
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "ifindex does not match any interface");
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (!ovpn_dev_is_valid(dev))
+		goto err_put_dev;
+
+	return dev;
+
+err_put_dev:
+	netdev_put(dev, NULL);
+
+	NL_SET_ERR_MSG_MOD(info->extack, "specified interface is not ovpn");
+	NL_SET_BAD_ATTR(info->extack, info->attrs[OVPN_A_IFINDEX]);
+
+	return ERR_PTR(-EINVAL);
+}
+
+int ovpn_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct net_device *dev = ovpn_get_dev_from_attrs(net, info);
+
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	info->user_ptr[0] = netdev_priv(dev);
+
+	return 0;
+}
+
+void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		       struct genl_info *info)
+{
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+
+	if (ovpn)
+		netdev_put(ovpn->dev, NULL);
+}
+
+int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_get_peer_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_set_key_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_swap_keys_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_nl_register - perform any needed registration in the NL subsustem
+ */
+int __init ovpn_nl_register(void)
+{
+	int ret = genl_register_family(&ovpn_nl_family);
+
+	if (ret) {
+		pr_err("ovpn: genl_register_family failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ovpn_nl_unregister - undo any module wide netlink registration
+ */
+void ovpn_nl_unregister(void)
+{
+	genl_unregister_family(&ovpn_nl_family);
+}
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
new file mode 100644
index 000000000000..9e87cf11d1e9
--- /dev/null
+++ b/drivers/net/ovpn/netlink.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_NETLINK_H_
+#define _NET_OVPN_NETLINK_H_
+
+int ovpn_nl_register(void);
+void ovpn_nl_unregister(void);
+
+#endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
new file mode 100644
index 000000000000..ff248cad1401
--- /dev/null
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTRUCT_H_
+#define _NET_OVPN_OVPNSTRUCT_H_
+
+/**
+ * struct ovpn_struct - per ovpn interface state
+ * @dev: the actual netdev representing the tunnel
+ */
+struct ovpn_struct {
+	struct net_device *dev;
+};
+
+#endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
new file mode 100644
index 000000000000..677a8105b61b
--- /dev/null
+++ b/include/uapi/linux/ovpn.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/ovpn.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_OVPN_H
+#define _UAPI_LINUX_OVPN_H
+
+#define OVPN_FAMILY_NAME	"ovpn"
+#define OVPN_FAMILY_VERSION	1
+
+#define OVPN_NONCE_TAIL_SIZE	8
+
+enum ovpn_cipher_alg {
+	OVPN_CIPHER_ALG_NONE,
+	OVPN_CIPHER_ALG_AES_GCM,
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+};
+
+enum ovpn_del_peer_reason {
+	OVPN_DEL_PEER_REASON_TEARDOWN,
+	OVPN_DEL_PEER_REASON_USERSPACE,
+	OVPN_DEL_PEER_REASON_EXPIRED,
+	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+};
+
+enum ovpn_key_slot {
+	OVPN_KEY_SLOT_PRIMARY,
+	OVPN_KEY_SLOT_SECONDARY,
+};
+
+enum ovpn_mode {
+	OVPN_MODE_P2P,
+	OVPN_MODE_MP,
+};
+
+enum {
+	OVPN_A_PEER_ID = 1,
+	OVPN_A_PEER_SOCKADDR_REMOTE,
+	OVPN_A_PEER_SOCKET,
+	OVPN_A_PEER_VPN_IPV4,
+	OVPN_A_PEER_VPN_IPV6,
+	OVPN_A_PEER_LOCAL_IP,
+	OVPN_A_PEER_LOCAL_PORT,
+	OVPN_A_PEER_KEEPALIVE_INTERVAL,
+	OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+	OVPN_A_PEER_DEL_REASON,
+	OVPN_A_PEER_KEYCONF,
+	OVPN_A_PEER_VPN_RX_BYTES,
+	OVPN_A_PEER_VPN_TX_BYTES,
+	OVPN_A_PEER_VPN_RX_PACKETS,
+	OVPN_A_PEER_VPN_TX_PACKETS,
+	OVPN_A_PEER_LINK_RX_BYTES,
+	OVPN_A_PEER_LINK_TX_BYTES,
+	OVPN_A_PEER_LINK_RX_PACKETS,
+	OVPN_A_PEER_LINK_TX_PACKETS,
+
+	__OVPN_A_PEER_MAX,
+	OVPN_A_PEER_MAX = (__OVPN_A_PEER_MAX - 1)
+};
+
+enum {
+	OVPN_A_KEYCONF_SLOT = 1,
+	OVPN_A_KEYCONF_KEY_ID,
+	OVPN_A_KEYCONF_CIPHER_ALG,
+	OVPN_A_KEYCONF_ENCRYPT_DIR,
+	OVPN_A_KEYCONF_DECRYPT_DIR,
+
+	__OVPN_A_KEYCONF_MAX,
+	OVPN_A_KEYCONF_MAX = (__OVPN_A_KEYCONF_MAX - 1)
+};
+
+enum {
+	OVPN_A_KEYDIR_CIPHER_KEY = 1,
+	OVPN_A_KEYDIR_NONCE_TAIL,
+
+	__OVPN_A_KEYDIR_MAX,
+	OVPN_A_KEYDIR_MAX = (__OVPN_A_KEYDIR_MAX - 1)
+};
+
+enum {
+	OVPN_A_IFINDEX = 1,
+	OVPN_A_IFNAME,
+	OVPN_A_MODE,
+	OVPN_A_PEER,
+
+	__OVPN_A_MAX,
+	OVPN_A_MAX = (__OVPN_A_MAX - 1)
+};
+
+enum {
+	OVPN_CMD_NEW_IFACE = 1,
+	OVPN_CMD_DEL_IFACE,
+	OVPN_CMD_SET_PEER,
+	OVPN_CMD_GET_PEER,
+	OVPN_CMD_DEL_PEER,
+	OVPN_CMD_SET_KEY,
+	OVPN_CMD_SWAP_KEYS,
+	OVPN_CMD_DEL_KEY,
+
+	__OVPN_CMD_MAX,
+	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
+};
+
+#define OVPN_MCGRP_PEERS	"peers"
+
+#endif /* _UAPI_LINUX_OVPN_H */
-- 
2.44.2


