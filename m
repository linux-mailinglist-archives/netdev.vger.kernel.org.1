Return-Path: <netdev+bounces-290902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDMiKJuVEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929C5B8715
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD7CA3016414
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1336683D;
	Fri, 22 May 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx+HjXPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171543655F3
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471738; cv=none; b=VAr6ieeDH1n6snE6YuKTAqclRz96AL/3HSMXggq1tCQsnhAilHXjVI7+YhnPCoy/Ac4pFAdJjCpGiGh6NjmdoCNa+yfpkGjOCbM7StOH8dDi7Lj8Du2JVl+7KrHd3qCVCHNww6IklWdx7NIIbR16uvla0/2F5DC/9IsXIE7O5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471738; c=relaxed/simple;
	bh=7pMSZzV/jTSFnIX340yNJSYzNFJz2VQlwCR0R9Wtz38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG8gVFwMuu2XmDm67Qfy0CusHK1hXq1GVE84Lk6URnEb+35FeoF6M+v+iM0Y7JRkVQTdM8CMWcprgFkYIbxtk7KmqhSRjsrRjrcMgKk6Uvpe1+3/jCcAxANc0qJlXazAyYO+JbCG49NvLcyGUbQZPE7oEKIw7IVw1gmSYI7u7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx+HjXPc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dca00c1591so2224510a34.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471736; x=1780076536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=Jx+HjXPcNA0UsQR2FyVgTCEUDVFOFh1QdTUtu3KbtYYStgDEUcP+6uZxMUIRrfv/5k
         IMpMclVKH/CN7SYkhRLSYLrH1xtCFGPnKK/t6W6wZO0MIo2v2nxpMQbcTt7vjxM0njc+
         k+Q8DHl+cKg/PQInr6jRGwNlfchmlMqkxB5CzrvswvZHDkR1FUrqQx71hfAXWchu63dg
         gkB9ESUMPunTPtlPNE9xKQQxYCYuSo2wBds0Y25yYT3e22saiBC5/tP9ssVuKNY8E0wQ
         94QyYDkdMYz/xLH2YadXteeejStJqjjANZSRrcI0UO8MyJEyo054bcAndWQ/8hC+Q2tW
         EijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471736; x=1780076536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cbDegg0JqhGywTNxkPjolkEASCiwR9fy2G9O6JnL4M=;
        b=n2lTFeXRnnqv/a0ouzJbUWuIHrijW7KuycxeXuxarp95k7N8B8L1MMjQwV1pGScmDt
         wsU+DRJztCNzA3FZVAYfj58Z+etIg83LfZhoE0ogS4HOn8+aVck7sQtNNeqsm9JLNENO
         5HnSIr5pcaVCUh6k5dJDjMAfQMRqun9nIpH1SKrZoAg2nYXONrnf/1VMTvFYXDkloLEa
         s3cG/dfOeY1Jyqmv2oQE4hCDpPE1J9/04ovWKGpRP1qxpHCaJPkZIj4xPpAQMI7rlCge
         YsKynGIGPucDZvw2RlN+j9+4lhC+9N8MjLdxWtdvB1KByRqUgMsAqMxFiidW5Tn9qwLR
         vulw==
X-Gm-Message-State: AOJu0Yyrqr099+7oT/fE8mRTduNZaVhM/HdluRaP9LsdcGcfhTwPl1oh
	hqAkjpxr9oSdFTtA2Ma2oe9S9WeP2NtPJRaK/cP9TNsAfKpGWeV53dO0Vw6fMpsn
X-Gm-Gg: Acq92OFiUphkXZAMDkONlSJ+G3pYDsXzkNtkYX9nEeu4O/03xbuPlG+fjgjbHokNkvh
	6BnhUX3jLYjXgrQk+r8OszAdHgcBNvEwFVufnchyUEexOOuNmxw8fWIfplPFUQ5uAEo9km946my
	ofs0TBrlZWXRfSxWKHadvk5tvb+fzkGqzxgGy38NELlrTYqaICVa+0kG3oxm41o3H3kDgHIioYf
	hxMqhopkiZWCLg2S0pcfpJeonqv8rfZSuHF+dkj4JF57H49EuWgHpbbmX1ksOnckhtpgHQd/6Mp
	XaSvjf1l76ln3v8bZnfu0UXTNXAI5b3g9IXpJJLn+ExMljQeS0lpsXZO0zG6ecCFCY8VRKF/qRu
	99aZK8hTA+DaSfjrfaNVb3F5oahkNEG6pJEyvXY4UcOhl5NA3OuxXz/yj4hecuXl1Os83feFeJ8
	6OMA+qJwFRzSUVZg0=
X-Received: by 2002:a05:6820:222a:b0:696:233b:20ef with SMTP id 006d021491bc7-69d7ead8123mr2277780eaf.1.1779471735900;
        Fri, 22 May 2026 10:42:15 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm2287249fac.6.2026.05.22.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:42:14 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/2] netlink: specs: add OVS packet family specification
Date: Sat, 23 May 2026 01:41:53 +0800
Message-ID: <20260522174154.720293-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522174154.720293-1-houminxi@gmail.com>
References: <20260522174154.720293-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290902-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7929C5B8715
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


