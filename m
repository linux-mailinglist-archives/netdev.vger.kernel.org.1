Return-Path: <netdev+bounces-289125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KA3FElBC2p5FAUAu9opvQ
	(envelope-from <netdev+bounces-289125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EB571109
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A3D3028F5C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6748B38A;
	Mon, 18 May 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3SyRPWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D9481FC3
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122450; cv=none; b=WkVZGtalChWHv1p3SnQUvHSjhsI0KL9iB3lF0JHjt8vA0qW1wv6JvrNQJ1IbZF5wE9K7J7QoVxp+kT9Ohndtm5O6ySnxr1uheLH7cOqRsxQzPeZfP7baW611h0ubISTIJaaVgR5jlaMdoDcH2OY1Xiby+vkWg68oTZOrX9k2xIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122450; c=relaxed/simple;
	bh=6YSVS5kkWuXkdYKSZyYUu6RF0k7wNNZX9nmDxqJjj94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joWtMHLL4AzEBIymyf+fq8cmTxZCrWlcqBQIzKXWaRRYNhS/3yhYm/dSMMx81SWf/Sg+qpUV+unSZ2JqieHABIgp6kRQJFeZgKxTHzuCW489YTBirJ1k0viXf2HKPm2VxQtKok5CGm9TzxTUfOSwUgbzcsujVmvOhqCqdklrBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3SyRPWR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4824176bbbeso715967b6e.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122448; x=1779727248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVJKiAuHQ5r89pkL74jN+DOLogpMgUXAIknghHQozjo=;
        b=L3SyRPWRpz8qiQ3BHxX2ObL7W4JKxj7/Lp3QoJnUJISDEAoumACFpe7+EO5/BTIbSy
         TSd4s3LEaSv4K9CkoKutxZK8Gcfr/iOrpyt6aRsh3qOA9qMKRjs+da64QkpjaUWOpCKj
         /A171oeTyWx81rNXPyv2vchphRNDZwKggJushD6H77GqIhX1+XVQ4PPmm6BNH4KpKEGS
         ze3HF4DBzKvInUhmpXRGUIsYhba6gHoqxGVbaxRzK+9ojTS+dT4lKtch6A5K4aI0Ojuw
         VlDgE9ue9WRdDuoFJRVqBG/iGrlGzQkIXwIBrC4iC+Nr4d/U2YtSc24l83khDjM6q6oy
         738g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122448; x=1779727248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVJKiAuHQ5r89pkL74jN+DOLogpMgUXAIknghHQozjo=;
        b=AxJiP9Lm0XcYcq1/Wx2kSOfEWjzS8iaDbqncCq2E+Pa8SlR44mDA8uoRLCYCicpZQt
         URHThEeNuq4a4Vz46FYlE2VvoQQltWwRXJ0SENCom4uiUV1DzUl4WvcfatjGExVWV/t5
         vMNpM8QAU6PPYJhj3890CHF+a7WZ22hJh4+zO3SnDIjePuOtqvtwvDHj/wfhcgz+r+Uv
         DaN4nLuJJKqKNx0HJvejX73yUGqg/f2liZ5pMwNRSPlOmQHVZIGRfCQPLyV2kP++wAgJ
         RDtsL4yG91yD+PAw/UiHu9zwDtioOXgsfX7NKccb8wdgs+QloZ0USpn2+neoTuHaDaHt
         XtZA==
X-Gm-Message-State: AOJu0YxXhjhFHFO1sxoz4ZYemebufRV5sahxsovKwAcceOezdjK0s2La
	P0W+/A4UO2eig/BQc0jqWQ3IwSSYC65GBC9bg4bHwKVOH54MHlE/dY2F+dL3UXrf
X-Gm-Gg: Acq92OEiQLcs488kWwafNATailFs6IdrK5n8ObMQ2Qs2RYWwTaBxhj9S0QXUfA4vXkb
	EzjhdgiYUp/66+BvVxS4M1sOt5Br+j9vy0QocTDrtxznd5nmX0HMT2pmjSL4bAsWvZt7ifNC2q5
	cU58ImWQy1eHeNnFglz1MYk/1wa6tFw7ApkVjGIwN/cYSTw/+De6DyhNHYbKTIk7/ZwyIajQtMO
	5JlABBmIDw7tuYTkWleHI43I4/eLZtIYGe4oPIBidgmeD/Mm8L1FiGI1408M+Tkl65QA5Uomr/u
	FE1q3TR5NxkApTY8G0IkWGH8xNMwQ9/5wg6seH2xFalakXaNNaAQOe2gHowNQnpBRffhpdTUE5y
	VCzIYaQ8u87wC0qB6bmULVVUkgWy76g8An1sV4c+A3EBO/hZMxSsnoWo6bWlg9dPio4JD4oM5Q/
	3EF8Lmn+mm7GHbPeU=
X-Received: by 2002:a05:6808:3383:b0:466:f57b:2ad2 with SMTP id 5614622812f47-482e57396f4mr9766307b6e.31.1779122448079;
        Mon, 18 May 2026 09:40:48 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fc2cdbsm4593877fac.6.2026.05.18.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:40:47 -0700 (PDT)
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
Subject: [PATCH v2 1/2] netlink: specs: add OVS packet family specification
Date: Tue, 19 May 2026 00:40:27 +0800
Message-ID: <20260518164029.439928-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518164029.439928-1-houminxi@gmail.com>
References: <20260518164029.439928-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289125-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: E33EB571109
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
index 000000000000..4c1f06630e4e
--- /dev/null
+++ b/Documentation/netlink/specs/ovs_packet.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
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


