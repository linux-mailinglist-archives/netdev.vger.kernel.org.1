Return-Path: <netdev+bounces-289396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJwqAlJADGqqawUAu9opvQ
	(envelope-from <netdev+bounces-289396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104057CD02
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 035D53195D27
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B426342CBD;
	Tue, 19 May 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJIjxeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CF345CBE
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186739; cv=none; b=fEUPVqtvrsdej24pM9rqmChwgaHScG8lgmTzzlmuRCtsoFGddo/w14ZnHhVLbQ84UTi9TdOyOr+ePeUO1hrTkL4XlSfgj/XmwBIHi4zWyZyBw1jsh3kkX7wCtbdtBCRGVIM07frFycWHuuwmnB/KKw9w4uadalaSn/G5ocovvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186739; c=relaxed/simple;
	bh=7pMSZzV/jTSFnIX340yNJSYzNFJz2VQlwCR0R9Wtz38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb5u0RE+Ep1V3MEfp9LXYvexu6CyZKbUMRb9btPpiWbkXGEWps1GI099NW9xrDZ/SHRRMnprPhUUIbfdBJfYm8NEe/UA6kktrFG96wT3yVEgewc8DGBDndsoxm7Gwr9+HvXGcC03L2lx6Kl63MpxaYcIbGwl84p+YifDaunM7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyJIjxeD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479d9b155deso975570b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186736; x=1779791536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=fyJIjxeDaDZjbbKhvVXaK6gtL7/SRgOpfYCIrQU8ogfz8tAgHtY+AUVaMWYi8Ym4nK
         5lFl/rvFZDIcs0Uliy+jH+n+pRN+3LAqrXyC68AHbBun50fP6mmcC+k4OfIyLSSxZcRx
         fXeqp7bB45xcDoDR60qvGX6m1H58zO9v5IaBwqZCP7/ZqPIJ6MviPxyIe1NU48Hi8byS
         cFtsN709wva86j7rFTvPNCpaKfRUAJg7Wn6fOxYi0AxtFoWZoxsxjXLIYy9LJUnApd/Q
         5f+8UVJkTczkYaB5E+JC37qX8XyG8nwwwXZT988rsNdooVea98NIMvdCGax/qxjpXvCq
         XMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186736; x=1779791536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=h2xTHnt1M5vLzypTBlm/iBxzRI+V0Nup/Uga+vBlFnr/+5/oVM329yUc/Fh28QpiN0
         bwhfpZwsBDDAV8PmhTvHuN2u3mTJYqGKaseh/A3GlBRhr7rsZVlDKatgfxumgpm4Q3Nx
         HI6mPKm4porDE+vHWFjmYKv4/teuYwWmGXpiLXeTqHBkpsReovI6FouBNF0zremjRFME
         dqIYzBFQMcX3oKxwOBkrpU5Csu1XGcR41qzaOjES1Z4S9X1CXxuORDZVmYcyUxUvSR+c
         3y8/4XL6PybPUIJXJE36quo44uaJM71d8wQIwiGlt7e77aqtiHKcJ+deT4gTiE5dJy9v
         TOGQ==
X-Gm-Message-State: AOJu0YzBfGur0z8QOX9euCfQY4Zo9Qsvf25AjtTbfNstQUz2//Bl/OWd
	ZKtc+S7EdQcHgpvb+Ns4dEa3+js20du8PA4gDDbCJvloCof8w60vKbalVCptB10k
X-Gm-Gg: Acq92OHQt1FJjeuzkkMFSIheGZfdA3lbjYX0otlJMro9MEgaR+U6ttB2r7y/0MPJKwK
	Sm1RUtCINxHi+V+NDhaWWRh2H8I9HIgG1Py5eYBWRJIJDzENQNfgVm/CS6OPuGTVOBXM422kSbM
	0+tcf+iA0b655UDy73cRga5KFkhtChc4b0SYAEQMDnCVV3oD60sJKuhHJ8QI/iVBDMUrw5ldiGm
	SExygTYRZDoEZN8T9HY7S7513+StjdrRlThwHyHUR57vzFHzxJrwmdpBfzlwAo90tt/S2CrBGQr
	IhjgLSIsVcjuClAq8JLBFHy4vlk6ZckkdqXCOdc9XgX2jpQ/Gx3K/VPDPpJp+p0vPC9hPaows2x
	0KPW5NTUGSXCofmFBFegE4xJSdQURZzJtI9iJZGuSazOtDCkNiMfUEpDmm5nggfjPtdFlsu6ZOM
	akX/5DSD6jrDksEpI=
X-Received: by 2002:a05:6808:1705:b0:468:6a2:897 with SMTP id 5614622812f47-482e55c9d18mr10749014b6e.6.1779186736433;
        Tue, 19 May 2026 03:32:16 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee389243sm6360969b6e.6.2026.05.19.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:32:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] netlink: specs: add OVS packet family specification
Date: Tue, 19 May 2026 18:31:52 +0800
Message-ID: <20260519103153.968549-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103153.968549-1-houminxi@gmail.com>
References: <20260519103153.968549-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9104057CD02
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


