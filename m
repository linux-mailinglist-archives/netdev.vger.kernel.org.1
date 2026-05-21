Return-Path: <netdev+bounces-290213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI5kLttsDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D559E0AC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E9A30A74B6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B236BCCC;
	Thu, 21 May 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxfjOqHh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF136920F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330037; cv=none; b=EKaTykdh5Jq+emjARpHkndSZ6jZ1Z65kQ2SW7tWYByFy0g9YTjlz4RWJNDWd/eHf6coT/8ZSOm90qhYD2M2gE/UeRFroMNkez4uAwtJFMX0LkBnYP25KRUN142Hu0v5vO9tIRn5D8VdcSL0w1RivR9AlN7xJerXNyzm01XR6z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330037; c=relaxed/simple;
	bh=7pMSZzV/jTSFnIX340yNJSYzNFJz2VQlwCR0R9Wtz38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE6xR6HkIUdmI8cokXlSJFL+yvqW4cMdxu8l7kQY3x68HB+KlvZDaxiTGqwFsBcd0QPy+Cl1SZrZikfG/F0/xILDhuXhNYzpMfsg7oP1JPbEtBnvy8PVyPbOzB5X4k6UhVZzg0+2qeILXenrnK9lW5XUGP5TmFQ6cc1w641q3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxfjOqHh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e568ab0bc5so6295030a34.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779330025; x=1779934825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=qxfjOqHhX076VmM3QRuZd9U7v1aaOmZJfhavZO65KYnuv+gQQjdLKf3DgPLYaUYFe/
         Sw/9jCVJOIJ6UrpJyjVja+5saKyxaFVjWoWI8HuHCGiusm0xQt/1YeNEhyZhw19hBWAF
         DDAvRSYV7wQc8LrmZFanFhLPezGnvRZHDXy1ZvAmWv1CB6ilylM3Z0BSBXunlIVkIEZi
         ky7o3JtSXVrZk82f51YWif9ZZ2WoFp82R4n0jp944whJieAGMGdJr+jqMmwLYIHbkQgY
         bFUVoGZy7srYrYdkprQkpJ3hazkHltLIxriGjVbhqqLj8En/sXZcCVorLbDYdhao7A9a
         MSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779330025; x=1779934825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=CsLb9lzhs1dZsUTmlgyqLD9bfeFkqTxlwp/SHrB+vxpLPSiSTvjaylgzpu3ksCFSGW
         wrfr4L6jCK3lfLNiyO3K9i/PlzEpJXleJie2b7U34la2+3ERXHKISt7o7p7F3xU/wIUn
         YS32vG+aezhDMRogEOtX8QY1PhCIqVhx0ugGwdwbtPpVbFLmZMqDeULgY+gxdHTVRk4j
         J/IjlPDCah4Ycre3MyEiBXUetUA/jcyMhdHCCldl2BgCOkkc5rW8oQ63vVnEI72jws4E
         yNxYJSoSIhA5x6FyZGHzNY88DkMkJPL5Jxhwnck3jHY2uylAtNbGpD+x35ADeTivkLfI
         ySRw==
X-Gm-Message-State: AOJu0Yy7t6pWsFEyUWx6kBMp1QpM0M5ZW9poLkiwCLdXgBJ4zYbAM0Cc
	YG6F55d9toUlvlYWD6fhs1SA3eVs3IuPMSSA2YHBDzoqPoMN7geZA84vzK2B6Mcfya8=
X-Gm-Gg: Acq92OHuycd4biDjuyMt6EFmDu0/mGhC1oAfLeZJEUUDWxutkn9/GxkMsucGCdaWW6B
	IrYpvfvH38czCal+aG+gbYFDLvz4Tr0RXlbi054j3rN2QIUhABj0qVXDa+bGJCvIndrK1SextpQ
	8Txhb+AllksMEWDDUyuG/EMln/xyYZ/4WcJMaxRTislMNXOlT2ty14Trh5gxHNitskt1tEwZXKO
	0yAbQGfAv2kO30OaLGcA4AbQ65Y7XNpw60Q0WblMGazKnHqUPgUi//Lb25PGIMvcfjA9Z7hP3X3
	YCJsY1P9gXnWpQ1W/liV0y8qkbE+ArXtEjKPLPIIJldjmexnW3HE/shg5wXSf4Ng807DUhmJSlF
	YQRxz7q3kiW38NAlFD/QCYFxAt04EB93WDWKDTaldXGyx8aPWqdHgNr+nJsaiZ1mFaH6h+ea2jZ
	3fvOQkd/Sh17cMspc=
X-Received: by 2002:a9d:6a50:0:b0:7de:cf3f:1b3d with SMTP id 46e09a7af769-7e5ea37d7c9mr441931a34.7.1779330025298;
        Wed, 20 May 2026 19:20:25 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b38sm13791720a34.2.2026.05.20.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:20:24 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 1/2] netlink: specs: add OVS packet family specification
Date: Thu, 21 May 2026 10:20:01 +0800
Message-ID: <20260521022002.879334-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521022002.879334-1-houminxi@gmail.com>
References: <20260521022002.879334-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290213-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 387D559E0AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add YAML netlink spec for the OVS_PACKET_FAMILY (ovs_packet).
This completes the set of OVS genetlink family specs (ovs_datapath,
ovs_flow, ovs_vport already exist).

The spec defines three operations: MISS (event), ACTION (event),
and EXECUTE (do). MISS and ACTION are kernel-to-userspace upcalls
sent via genlmsg_unicast(); EXECUTE is the only registered genl
operation.

Key, actions, and egress-tun-key attributes are typed as binary
rather than nest because the nested attribute definitions belong
to the ovs_flow spec and cross-spec references are not supported
by the YNL framework.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

diff --git a/Documentation/netlink/specs/ovs_packet.yaml b/Documentation/netlink/specs/ovs_packet.yaml
new file mode 100644
index 000000000000..e4c5f24b3b01
--- /dev/null
+++ b/Documentation/netlink/specs/ovs_packet.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: ovs_packet
+version: 1
+protocol: genetlink-legacy
+uapi-header: linux/openvswitch.h
+
+doc: |
+  OVS packet execution over generic netlink.
+
+  Only OVS_PACKET_CMD_EXECUTE is exposed as a genl operation.
+  OVS_PACKET_CMD_MISS and OVS_PACKET_CMD_ACTION are kernel-to-userspace
+  upcalls sent via genlmsg_unicast() to the vport's upcall_pid and have
+  no associated genl_ops or multicast group.
+
+  Several attributes in the attribute set (userdata, egress-tun-key, len)
+  exist for the upcall path and are not used by the EXECUTE operation.
+  For EXECUTE, packet, key, and actions are mandatory (kernel returns
+  -EINVAL without them).
+
+definitions:
+  -
+    name: ovs-header
+    type: struct
+    members:
+      -
+        name: dp-ifindex
+        type: u32
+
+attribute-sets:
+  -
+    name: packet
+    name-prefix: ovs-packet-attr-
+    enum-name: ovs-packet-attr
+    attributes:
+      -
+        name: packet
+        type: binary
+        doc: Packet data, from the start of the Ethernet header.
+        checks:
+          min-len: 14
+      -
+        name: key
+        type: binary
+        doc: |
+          Nested OVS_KEY_ATTR_* attributes, extracted flow key.
+          Defined as binary because the key attribute-set belongs to the
+          ovs_flow family spec; cross-spec references are not supported.
+      -
+        name: actions
+        type: binary
+        doc: |
+          Nested OVS_ACTION_ATTR_* attributes.
+          Defined as binary for the same reason as key.
+      -
+        name: userdata
+        type: binary
+        doc: Opaque userspace cookie from OVS_USERSPACE_ATTR_USERDATA.
+      -
+        name: egress-tun-key
+        type: binary
+        doc: Nested OVS_TUNNEL_KEY_ATTR_* for output tunnel metadata.
+      -
+        name: unused1
+        type: unused
+      -
+        name: unused2
+        type: unused
+      -
+        name: probe
+        type: flag
+        doc: Packet operation is a feature probe, error logging suppressed.
+      -
+        name: mru
+        type: u16
+        doc: Maximum received IP fragment size.
+      -
+        name: len
+        type: u32
+        doc: Packet size before truncation.
+      -
+        name: hash
+        type: u64
+        doc: Packet hash, low 32 bits are skb hash, upper bits are flags.
+      -
+        name: upcall-pid
+        type: u32
+        doc: Netlink PID to use for upcalls during EXECUTE processing.
+
+operations:
+  fixed-header: ovs-header
+  name-prefix: ovs-packet-cmd-
+  list:
+    -
+      name: miss
+      doc: Notify userspace of a flow table miss for a received packet.
+      value: 1
+      attribute-set: packet
+      event:
+        attributes: &event-attrs
+          - packet
+          - key
+          - userdata
+          - actions
+          - egress-tun-key
+          - mru
+          - len
+          - hash
+    -
+      name: action
+      doc: Notify userspace as requested by an OVS_ACTION_ATTR_USERSPACE action.
+      value: 2
+      attribute-set: packet
+      event:
+        attributes: *event-attrs
+    -
+      name: execute
+      doc: Apply actions to a packet.
+      value: 3
+      attribute-set: packet
+      do:
+        request:
+          attributes:
+            - packet
+            - key
+            - actions
+            - probe
+            - mru
+            - hash
+            - upcall-pid
-- 
2.54.0


