Return-Path: <netdev+bounces-288704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzOELd9CWqVcQQAu9opvQ
	(envelope-from <netdev+bounces-288704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:35:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5255FFE2
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CF5300A119
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC3346795;
	Sun, 17 May 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cytnjjUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCE346784
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006863; cv=none; b=KeGiZZO7gTKX3XG8J9vSdImo7uxqItuRvZd3xvVqfnHNaRvK6TF0/1P11g2aNxpQGAuX8ctpUXfrwPSvdlIjhOdnC3DXqkYJORjzvgOtwiAROhcCFX/aTej3VzOT0XC2YCPtirNZ+HUDvqgVSu6SyWLX63pqTJf5N3LjqMCKlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006863; c=relaxed/simple;
	bh=feLLfQFvpoIClWFfZ2Qy7Vj9jKgNx4+zS4dEVQfjxm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvelTknAZkVV+DvK/N9HIu4REu/H8t4xT9cZco/GD36U1q6AcwinDJ4m3EVRtXGhBxat5OSunpXAivHtSB5/jOcEmGyW3dxb2IAhsHdIK6BqOn64ahsq78HylRWeKNMmFC7+ebNttBrm0gslYvsx1WlBQn9GbwJKMQefaYGwlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cytnjjUS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47c6f914617so585749b6e.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779006861; x=1779611661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeQkqDrAPMYn0zYuhzYdu377fHXEuEM6zjwZuagDHgQ=;
        b=cytnjjUSyuvVimvJfns9Vm9BOHOOdLMU7BAQ2VPWiQhlVatdZVbfO7y+9KVaefuykJ
         Wg1xGjeUvazdQiEmNUohd/i3mUwxLkPYTtUcZuTK0I1oUqoBMOjEm6GD5n0Tjymm7IC6
         rMpH5DuLTd4Q49TVZKNWzR6o7hlucv1nzc+Be6KdIQoUvnTDt2Fah5Om00vnFd3fE0j0
         eS7JjVLmsNMU9lvItA2ffVXmHwrrWn6zmn7hC0E+78TUhxIdVnOEgf8polOXCGue1NxR
         Z9BP4hsNw+ZQgfSqZsdXJg6vvYaEfuHXiQ4T/Tx0uigA3IdBzhPB79gtpgipKscyv0HL
         30Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779006861; x=1779611661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SeQkqDrAPMYn0zYuhzYdu377fHXEuEM6zjwZuagDHgQ=;
        b=ftrdJehaXfr1KTJD/+0Pwn/wHckszZqm78C0z8Ilplqv2GOkh75pA2cNyrIjgY8Awy
         NRxd3D9VPjuJ98iDETIcITKBRdzal+sGsuDLC6wEtm30K2nprMTt/0KahhI0Yl9LZ3ni
         Xy18lW30yPgCnnBJ41ys9yHZm02iTT0c3jSqtgPj/WRh1+qk9Ly0fkBMLRPRsdaA4rLH
         aYWJ1/fCmQDCKkgnOwg5V1l9WPcKeuVKSTx9uCLVQu4uM6z1goeoLqcKn1FJjsAjarOj
         Pl/XXhuyeT6UJQ0tnaSIziRAuAp8bcwLXzE77CO7T94pwbdLFR28Yp8cY043JjASrGEL
         6fBA==
X-Gm-Message-State: AOJu0YzZW6oxd7dZ8feMYyr2fN4lmShJ7IRhGTvk2shvMP1JSPltYZER
	Lgu1frCeMTUcvNSqV2+7meG102QvELobRRgyCFqyFwLEI37ySBzjD11kapJK9DW+RZQ=
X-Gm-Gg: Acq92OEj1dZTpiGX8YHKyr4NIDeHP79LC1C2JmzRrwFxf3tmMRewq2ENYPkkqCFgdKV
	HhzhegjEzQajqgwLPe0ltufZo2svMN8WQq/OLbcRV+blOFBiAbwtvrQOo8gm4VFkKKZHKVaaZZY
	rh/XfnVEwnHb6S5iFz1zextjbalZM6ZjkgAqbm910N+TWSudLORisoyY673X+/wDMf6iP7Je63b
	sfjz9HHOapNYPV5tVhnoTDvpzel8NrxlL1Jq0AQK/8JLRQ8nKsZqVtJYc3kcFvFghqQxTfdsbTt
	kI5DdtwrNRCR9cy9Pw2TTK+UWeU8qVpsfAxqpQqB1PQwI1Rb5+NS3lwN3AtpWJp5+f93NRrFtpp
	7/MRfOwOA4xFVCnGWwaqAcEF7hXfyyRmkiBX0Ay+uo3d8a9F/2WnuNjvHmyz4+doV1p7ZRnciie
	Bak8aMDG/fRMKYPvM=
X-Received: by 2002:a05:6808:e412:b0:467:ee:7a2f with SMTP id 5614622812f47-482e577d4f5mr5216362b6e.28.1779006860619;
        Sun, 17 May 2026 01:34:20 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd0bd6sm5345191a34.13.2026.05.17.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:34:19 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH 1/2] netlink: specs: add OVS packet family specification
Date: Sun, 17 May 2026 16:33:57 +0800
Message-ID: <20260517083358.2088599-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517083358.2088599-1-houminxi@gmail.com>
References: <20260517083358.2088599-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9AB5255FFE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288704-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 Documentation/netlink/specs/ovs_packet.yaml | 138 ++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

diff --git a/Documentation/netlink/specs/ovs_packet.yaml b/Documentation/netlink/specs/ovs_packet.yaml
new file mode 100644
index 000000000000..7ef14b68df4e
--- /dev/null
+++ b/Documentation/netlink/specs/ovs_packet.yaml
@@ -0,0 +1,138 @@
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
+    enum-name: ovs-packet-attrs
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
+        attributes:
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
+        attributes:
+          - packet
+          - key
+          - userdata
+          - actions
+          - egress-tun-key
+          - mru
+          - len
+          - hash
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
2.53.0


