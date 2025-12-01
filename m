Return-Path: <netdev+bounces-242872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FDC9595E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3B5C4E10A9
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60F1A9F94;
	Mon,  1 Dec 2025 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mHKJSNKO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E91A3179
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556149; cv=none; b=W5jsV/eRHSkb2N6VRMSBFCQPW49Pvu62v4L9AwCm0BET6/cG5WVf0SbSkmQnDUdUr3q1u6u/l8IzJ4HrPwKl6kKo7d1gcFyET5JFloMwrzxd08F2+aPbiL5yNYDIHPfv2cy/NotNWW2+EGDnZQ+jCKTuhQ6rpgO68NG2rkzwfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556149; c=relaxed/simple;
	bh=tWcVg+n4q/FKXYVeeRO6JpCRzf/7qpqjScrOGuaUhCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARVXKHJWor0sxBZNAI4m9+wPME5G6gba1HUwyY/ddJdVWYjU4mGPfR7HUpi7eKPIun1ioqyqJS6MT0gRwlL2r7m+TZlJCZs5TaYav8lK0tiOoPMi3dE7mktjaD6lQhIJRVj1NhF3YGLubPKcaPAKrRI5H+WhkqGcAVHPBepCMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mHKJSNKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07815C4CEFB;
	Mon,  1 Dec 2025 02:29:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mHKJSNKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcA5FavEUQ874xnz+KpIEwk4pzJ7ioh+eFYu7HwZFkM=;
	b=mHKJSNKO+htJsRWeLVMrdr1PSloBTC2j2SScEdVQgcbQBvuNOJJG7+b3wfvWVoEwn58PpA
	fmYd7rCqcF3qs5rGateF73tt8LzN/N3V2Qsx+lGQu5hkz1eKwvKh12jfMvDjcIsO8L7HVo
	vzRal0TgQ1P26Cy1bUe2McGDIz0UlnU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6279d036 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:05 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 06/11] netlink: specs: add specification for wireguard
Date: Mon,  1 Dec 2025 03:28:44 +0100
Message-ID: <20251201022849.418666-7-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

This patch adds a near[1] complete YNL specification for WireGuard,
documenting the protocol in a machine-readable format, rather than
comments in wireguard.h, and eases usage from C and non-C programming
languages alike.

The generated C library will be featured in a later patch, so in
this patch I will use the in-kernel python client for examples.

This makes the documentation in the UAPI header redundant, it is
therefore removed. The in-line documentation in the spec is based
on the existing comment in wireguard.h, and once released it will
be available in the kernel documentation at:
  https://docs.kernel.org/netlink/specs/wireguard.html
  (until then run: make htmldocs)

Generate wireguard.rst from this spec:
$ make -C tools/net/ynl/generated/ wireguard.rst

Query wireguard interface through pyynl:
$ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
                                    --dump get-device \
                                    --json '{"ifindex":3}'
[{'fwmark': 0,
  'ifindex': 3,
  'ifname': 'wg-test',
  'listen-port': 54318,
  'peers': [{0: {'allowedips': [{0: {'cidr-mask': 0,
                                     'family': 2,
                                     'ipaddr': '0.0.0.0'}},
                                {0: {'cidr-mask': 0,
                                     'family': 10,
                                     'ipaddr': '::'}}],
                 'endpoint': b'[...]',
                 'last-handshake-time': {'nsec': 42, 'sec': 42},
                 'persistent-keepalive-interval': 42,
                 'preshared-key': '[...]',
                 'protocol-version': 1,
                 'public-key': '[...]',
                 'rx-bytes': 42,
                 'tx-bytes': 42}}],
  'private-key': '[...]',
  'public-key': '[...]'}]

Add another allowed IP prefix:
$ sudo ./tools/net/ynl/pyynl/cli.py --family wireguard \
  --do set-device --json '{"ifindex":3,"peers":[
    {"public-key":"6a df b1 83 a4 ..","allowedips":[
      {"cidr-mask":0,"family":10,"ipaddr":"::"}]}]}'

[1] As can be seen above, the "endpoint" is only dumped as binary data,
    as it can't be fully described in YNL. It's either a struct
    sockaddr_in or struct sockaddr_in6 depending on the attribute length.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/netlink/specs/wireguard.yaml | 298 +++++++++++++++++++++
 MAINTAINERS                                |   1 +
 include/uapi/linux/wireguard.h             | 129 ---------
 3 files changed, 299 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml

diff --git a/Documentation/netlink/specs/wireguard.yaml b/Documentation/netlink/specs/wireguard.yaml
new file mode 100644
index 000000000000..30479fc6bb69
--- /dev/null
+++ b/Documentation/netlink/specs/wireguard.yaml
@@ -0,0 +1,298 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: wireguard
+protocol: genetlink-legacy
+
+doc: |
+  **Netlink protocol to control WireGuard network devices.**
+
+  The below enums and macros are for interfacing with WireGuard, using generic
+  netlink, with family ``WG_GENL_NAME`` and version ``WG_GENL_VERSION``. It
+  defines two commands: get and set. Note that while they share many common
+  attributes, these two commands actually accept a slightly different set of
+  inputs and outputs. These differences are noted under the individual
+  attributes.
+c-family-name: wg-genl-name
+c-version-name: wg-genl-version
+max-by-define: true
+
+definitions:
+  -
+    name-prefix: wg-
+    name: key-len
+    type: const
+    value: 32
+  -
+    name: --kernel-timespec
+    type: struct
+    header: linux/time_types.h
+    members:
+      -
+        name: sec
+        type: u64
+        doc: Number of seconds, since UNIX epoch.
+      -
+        name: nsec
+        type: u64
+        doc: Number of nanoseconds, after the second began.
+  -
+    name: wgdevice-flags
+    name-prefix: wgdevice-f-
+    enum-name: wgdevice-flag
+    type: flags
+    entries:
+      - replace-peers
+  -
+    name: wgpeer-flags
+    name-prefix: wgpeer-f-
+    enum-name: wgpeer-flag
+    type: flags
+    entries:
+      - remove-me
+      - replace-allowedips
+      - update-only
+  -
+    name: wgallowedip-flags
+    name-prefix: wgallowedip-f-
+    enum-name: wgallowedip-flag
+    type: flags
+    entries:
+      - remove-me
+
+attribute-sets:
+  -
+    name: wgdevice
+    enum-name: wgdevice-attribute
+    name-prefix: wgdevice-a-
+    attr-cnt-name: --wgdevice-a-last
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: ifindex
+        type: u32
+      -
+        name: ifname
+        type: string
+        checks:
+          max-len: 15
+      -
+        name: private-key
+        type: binary
+        doc: Set to all zeros to remove.
+        display-hint: hex
+        checks:
+          exact-len: wg-key-len
+      -
+        name: public-key
+        type: binary
+        display-hint: hex
+        checks:
+          exact-len: wg-key-len
+      -
+        name: flags
+        type: u32
+        doc: |
+          ``0`` or ``WGDEVICE_F_REPLACE_PEERS`` if all current peers should be
+          removed prior to adding the list below.
+        enum: wgdevice-flags
+      -
+        name: listen-port
+        type: u16
+        doc: Set as ``0`` to choose randomly.
+      -
+        name: fwmark
+        type: u32
+        doc: Set as ``0`` to disable.
+      -
+        name: peers
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: wgpeer
+        doc: |
+          The index/type parameter is unused on ``SET_DEVICE`` operations and is
+          zero on ``GET_DEVICE`` operations.
+  -
+    name: wgpeer
+    enum-name: wgpeer-attribute
+    name-prefix: wgpeer-a-
+    attr-cnt-name: --wgpeer-a-last
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: public-key
+        type: binary
+        display-hint: hex
+        checks:
+          exact-len: wg-key-len
+      -
+        name: preshared-key
+        type: binary
+        doc: Set as all zeros to remove.
+        display-hint: hex
+        checks:
+          exact-len: wg-key-len
+      -
+        name: flags
+        type: u32
+        doc: |
+          ``0`` and/or ``WGPEER_F_REMOVE_ME`` if the specified peer should not
+          exist at the end of the operation, rather than added/updated and/or
+          ``WGPEER_F_REPLACE_ALLOWEDIPS`` if all current allowed IPs of this
+          peer should be removed prior to adding the list below and/or
+          ``WGPEER_F_UPDATE_ONLY`` if the peer should only be set if it already
+          exists.
+        enum: wgpeer-flags
+      -
+        name: endpoint
+        type: binary
+        doc: struct sockaddr_in or struct sockaddr_in6
+        checks:
+          min-len: 16
+      -
+        name: persistent-keepalive-interval
+        type: u16
+        doc: Set as ``0`` to disable.
+      -
+        name: last-handshake-time
+        type: binary
+        struct: --kernel-timespec
+        checks:
+          exact-len: 16
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: allowedips
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: wgallowedip
+        doc: |
+          The index/type parameter is unused on ``SET_DEVICE`` operations and is
+          zero on ``GET_DEVICE`` operations.
+      -
+        name: protocol-version
+        type: u32
+        doc: |
+          Should not be set or used at all by most users of this API, as the
+          most recent protocol will be used when this is unset. Otherwise,
+          must be set to ``1``.
+  -
+    name: wgallowedip
+    enum-name: wgallowedip-attribute
+    name-prefix: wgallowedip-a-
+    attr-cnt-name: --wgallowedip-a-last
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: family
+        type: u16
+        doc: IP family, either ``AF_INET`` or ``AF_INET6``.
+      -
+        name: ipaddr
+        type: binary
+        doc: Either ``struct in_addr`` or ``struct in6_addr``.
+        display-hint: ipv4-or-v6
+        checks:
+          min-len: 4
+      -
+        name: cidr-mask
+        type: u8
+      -
+        name: flags
+        type: u32
+        doc: |
+          ``WGALLOWEDIP_F_REMOVE_ME`` if the specified IP should be removed;
+          otherwise, this IP will be added if it is not already present.
+        enum: wgallowedip-flags
+
+operations:
+  enum-name: wg-cmd
+  name-prefix: wg-cmd-
+  list:
+    -
+      name: get-device
+      value: 0
+      doc: |
+        Retrieve WireGuard device
+        ~~~~~~~~~~~~~~~~~~~~~~~~~
+
+        The command should be called with one but not both of:
+
+        - ``WGDEVICE_A_IFINDEX``
+        - ``WGDEVICE_A_IFNAME``
+
+        The kernel will then return several messages (``NLM_F_MULTI``). It is
+        possible that all of the allowed IPs of a single peer will not fit
+        within a single netlink message. In that case, the same peer will be
+        written in the following message, except it will only contain
+        ``WGPEER_A_PUBLIC_KEY`` and ``WGPEER_A_ALLOWEDIPS``. This may occur
+        several times in a row for the same peer. It is then up to the receiver
+        to coalesce adjacent peers. Likewise, it is possible that all peers will
+        not fit within a single message. So, subsequent peers will be sent in
+        following messages, except those will only contain ``WGDEVICE_A_IFNAME``
+        and ``WGDEVICE_A_PEERS``. It is then up to the receiver to coalesce
+        these messages to form the complete list of peers.
+
+        Since this is an ``NLA_F_DUMP`` command, the final message will always
+        be ``NLMSG_DONE``, even if an error occurs. However, this ``NLMSG_DONE``
+        message contains an integer error code. It is either zero or a negative
+        error code corresponding to the errno.
+      attribute-set: wgdevice
+      flags: [uns-admin-perm]
+
+      dump:
+        pre: wg-get-device-start
+        post: wg-get-device-done
+        request:
+          attributes:
+            - ifindex
+            - ifname
+        reply: &all-attrs
+          attributes:
+            - ifindex
+            - ifname
+            - private-key
+            - public-key
+            - flags
+            - listen-port
+            - fwmark
+            - peers
+    -
+      name: set-device
+      value: 1
+      doc: |
+        Set WireGuard device
+        ~~~~~~~~~~~~~~~~~~~~
+
+        This command should be called with a wgdevice set, containing one but
+        not both of ``WGDEVICE_A_IFINDEX`` and ``WGDEVICE_A_IFNAME``.
+
+        It is possible that the amount of configuration data exceeds that of the
+        maximum message length accepted by the kernel. In that case, several
+        messages should be sent one after another, with each successive one
+        filling in information not contained in the prior. Note that if
+        ``WGDEVICE_F_REPLACE_PEERS`` is specified in the first message, it
+        probably should not be specified in fragments that come after, so that
+        the list of peers is only cleared the first time but appended after.
+        Likewise for peers, if ``WGPEER_F_REPLACE_ALLOWEDIPS`` is specified in
+        the first message of a peer, it likely should not be specified in
+        subsequent fragments.
+
+        If an error occurs, ``NLMSG_ERROR`` will reply containing an errno.
+      attribute-set: wgdevice
+      flags: [uns-admin-perm]
+
+      do:
+        request: *all-attrs
diff --git a/MAINTAINERS b/MAINTAINERS
index 09932ab7e0e8..8b44a380642c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27673,6 +27673,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 L:	wireguard@lists.zx2c4.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
 F:	tools/testing/selftests/wireguard/
 
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index 8c26391196d5..dee4401e0b5d 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -1,135 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- *
- * Documentation
- * =============
- *
- * The below enums and macros are for interfacing with WireGuard, using generic
- * netlink, with family WG_GENL_NAME and version WG_GENL_VERSION. It defines two
- * methods: get and set. Note that while they share many common attributes,
- * these two functions actually accept a slightly different set of inputs and
- * outputs.
- *
- * WG_CMD_GET_DEVICE
- * -----------------
- *
- * May only be called via NLM_F_REQUEST | NLM_F_DUMP. The command should contain
- * one but not both of:
- *
- *    WGDEVICE_A_IFINDEX: NLA_U32
- *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMSIZ - 1
- *
- * The kernel will then return several messages (NLM_F_MULTI) containing the
- * following tree of nested items:
- *
- *    WGDEVICE_A_IFINDEX: NLA_U32
- *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMSIZ - 1
- *    WGDEVICE_A_PRIVATE_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
- *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
- *    WGDEVICE_A_LISTEN_PORT: NLA_U16
- *    WGDEVICE_A_FWMARK: NLA_U32
- *    WGDEVICE_A_PEERS: NLA_NESTED
- *        0: NLA_NESTED
- *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
- *            WGPEER_A_PRESHARED_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
- *            WGPEER_A_ENDPOINT: NLA_MIN_LEN(struct sockaddr), struct sockaddr_in or struct sockaddr_in6
- *            WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL: NLA_U16
- *            WGPEER_A_LAST_HANDSHAKE_TIME: NLA_EXACT_LEN, struct __kernel_timespec
- *            WGPEER_A_RX_BYTES: NLA_U64
- *            WGPEER_A_TX_BYTES: NLA_U64
- *            WGPEER_A_ALLOWEDIPS: NLA_NESTED
- *                0: NLA_NESTED
- *                    WGALLOWEDIP_A_FAMILY: NLA_U16
- *                    WGALLOWEDIP_A_IPADDR: NLA_MIN_LEN(struct in_addr), struct in_addr or struct in6_addr
- *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
- *                0: NLA_NESTED
- *                    ...
- *                0: NLA_NESTED
- *                    ...
- *                ...
- *            WGPEER_A_PROTOCOL_VERSION: NLA_U32
- *        0: NLA_NESTED
- *            ...
- *        ...
- *
- * It is possible that all of the allowed IPs of a single peer will not
- * fit within a single netlink message. In that case, the same peer will
- * be written in the following message, except it will only contain
- * WGPEER_A_PUBLIC_KEY and WGPEER_A_ALLOWEDIPS. This may occur several
- * times in a row for the same peer. It is then up to the receiver to
- * coalesce adjacent peers. Likewise, it is possible that all peers will
- * not fit within a single message. So, subsequent peers will be sent
- * in following messages, except those will only contain WGDEVICE_A_IFNAME
- * and WGDEVICE_A_PEERS. It is then up to the receiver to coalesce these
- * messages to form the complete list of peers.
- *
- * Since this is an NLA_F_DUMP command, the final message will always be
- * NLMSG_DONE, even if an error occurs. However, this NLMSG_DONE message
- * contains an integer error code. It is either zero or a negative error
- * code corresponding to the errno.
- *
- * WG_CMD_SET_DEVICE
- * -----------------
- *
- * May only be called via NLM_F_REQUEST. The command should contain the
- * following tree of nested items, containing one but not both of
- * WGDEVICE_A_IFINDEX and WGDEVICE_A_IFNAME:
- *
- *    WGDEVICE_A_IFINDEX: NLA_U32
- *    WGDEVICE_A_IFNAME: NLA_NUL_STRING, maxlen IFNAMSIZ - 1
- *    WGDEVICE_A_FLAGS: NLA_U32, 0 or WGDEVICE_F_REPLACE_PEERS if all current
- *                      peers should be removed prior to adding the list below.
- *    WGDEVICE_A_PRIVATE_KEY: len WG_KEY_LEN, all zeros to remove
- *    WGDEVICE_A_LISTEN_PORT: NLA_U16, 0 to choose randomly
- *    WGDEVICE_A_FWMARK: NLA_U32, 0 to disable
- *    WGDEVICE_A_PEERS: NLA_NESTED
- *        0: NLA_NESTED
- *            WGPEER_A_PUBLIC_KEY: len WG_KEY_LEN
- *            WGPEER_A_FLAGS: NLA_U32, 0 and/or WGPEER_F_REMOVE_ME if the
- *                            specified peer should not exist at the end of the
- *                            operation, rather than added/updated and/or
- *                            WGPEER_F_REPLACE_ALLOWEDIPS if all current allowed
- *                            IPs of this peer should be removed prior to adding
- *                            the list below and/or WGPEER_F_UPDATE_ONLY if the
- *                            peer should only be set if it already exists.
- *            WGPEER_A_PRESHARED_KEY: len WG_KEY_LEN, all zeros to remove
- *            WGPEER_A_ENDPOINT: struct sockaddr_in or struct sockaddr_in6
- *            WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL: NLA_U16, 0 to disable
- *            WGPEER_A_ALLOWEDIPS: NLA_NESTED
- *                0: NLA_NESTED
- *                    WGALLOWEDIP_A_FAMILY: NLA_U16
- *                    WGALLOWEDIP_A_IPADDR: struct in_addr or struct in6_addr
- *                    WGALLOWEDIP_A_CIDR_MASK: NLA_U8
- *                    WGALLOWEDIP_A_FLAGS: NLA_U32, WGALLOWEDIP_F_REMOVE_ME if
- *                                         the specified IP should be removed;
- *                                         otherwise, this IP will be added if
- *                                         it is not already present.
- *                0: NLA_NESTED
- *                    ...
- *                0: NLA_NESTED
- *                    ...
- *                ...
- *            WGPEER_A_PROTOCOL_VERSION: NLA_U32, should not be set or used at
- *                                       all by most users of this API, as the
- *                                       most recent protocol will be used when
- *                                       this is unset. Otherwise, must be set
- *                                       to 1.
- *        0: NLA_NESTED
- *            ...
- *        ...
- *
- * It is possible that the amount of configuration data exceeds that of
- * the maximum message length accepted by the kernel. In that case, several
- * messages should be sent one after another, with each successive one
- * filling in information not contained in the prior. Note that if
- * WGDEVICE_F_REPLACE_PEERS is specified in the first message, it probably
- * should not be specified in fragments that come after, so that the list
- * of peers is only cleared the first time but appended after. Likewise for
- * peers, if WGPEER_F_REPLACE_ALLOWEDIPS is specified in the first message
- * of a peer, it likely should not be specified in subsequent fragments.
- *
- * If an error occurs, NLMSG_ERROR will reply containing an errno.
  */
 
 #ifndef _WG_UAPI_WIREGUARD_H
-- 
2.52.0


