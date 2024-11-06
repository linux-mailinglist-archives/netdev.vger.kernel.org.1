Return-Path: <netdev+bounces-142286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD299BE1FA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47DBB20B1E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C151DA634;
	Wed,  6 Nov 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/+GcJEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08041D90D7
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884049; cv=none; b=d/Jhg2fOHCAAMCYJTnSqZ2ZRNgRoRPSHLlKyVmwu+DINUZWDQQRQnRfr5n7HjplRDGufyt3q45hz4MVF/UTuol8puzrFRyFmyyo/ModJSDS7UOHd2Y3fuoWygrAPhuK72FrF49GfnRd0qB8DPfi/aZ15wm9Nkj+FMFp/W1p9UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884049; c=relaxed/simple;
	bh=8hZu6ohNjp15EWFWQ5dBsnlwHJ0z/7QDQngEEAGKaKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwzXX3qlaOHAGuhCdTED3paoNVXOpmDnrxwU1Frv9binB1V/C0u3vR4yqZHgbPwlVElU2YiHFSfkxiv+JZ8A1XEVkXmekxkW7iMJyS38mjFSTkOkWP3VPbOGUtANBebEgyF8w8C/ZgQhiq00g4mL0Q9Qtxsl0zg+R7RtkRoVQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/+GcJEB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so3844873f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730884046; x=1731488846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZqcrXAZVfPDJx0zkaQw5Dqabv4/SxTySXjrEtQ1hHI=;
        b=W/+GcJEBlH9i0MFmUh0DtuUdKlYGX+8GEP2p0AXZ0uD5kGWtmZzqhfOXX13Qe+EDRD
         fKmpqqlRMFoXabycEkjy7eyreunM/EE2UeNdoZy/luQAJDBUA1VXfnrQ1tfZfJHtumN3
         4kdF/jEVj/2zlTx6/UUKkWU/EHkEMQvDfWGKUnrlMERQMXPpOqgUJ1F2A51ZHzMVdrgs
         EayilR9vYPaf3RIO/rbmLnF669HT7o/i4lLnyORf6DebR5jTMW/JPW4UZ9IdW05zc4SE
         kz6AuZDqztHbbtwaqHeZBLM9+GvC9kZ5n9OCP9LFiXFO1m/7WrwmDBgJmbIHptG7HWJo
         j6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884046; x=1731488846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZqcrXAZVfPDJx0zkaQw5Dqabv4/SxTySXjrEtQ1hHI=;
        b=vry+C9wEoRWC74ai3kyB90E9n5O5eRCwEtPLz6h5aKMrOG/Uxy85ctCzPrlGpJnnnS
         0/u02Ov1oOrff2tzfOACv02Y9ZTaH+gRTwobIb4vwTNuR8lH1zXNYVen4YL+YExCToHJ
         +VweLIYYf0BEtd0oi4jKd+hYK4bW98+MVYT9/XsK0L4LrxTeHxZr/tsawgzDqVi+B2WR
         ia8UXy4Yyd5iPEJ6GlwlUAnG8smyQzd3KOqNHlgGYQwD8W3g3UndSZNzNPuHgRIFueNv
         uFwUmtBxAOFTA1nIr0rOS2nE4t74cBM5SjwZ1k9R0k8vtacvaCbr9IJjQ7ozdpGfMz+O
         +KNA==
X-Gm-Message-State: AOJu0YwPaltbbnKKPGXxrVQOnwynyuqbehqF5sW+hr6KrDnBEsxgnOQ7
	zO4Z2wqbvAj+/NThHdJUO9H852UZyxpWS84SJl9jSwUwDTqKcyKZJRovNReI
X-Google-Smtp-Source: AGHT+IGAl4smlnp+PCuxTOvr06VTxaz0xy9rsnboaImWAnAyA9+sroqPRM/zpxgSBEc8v1SEwkszmQ==
X-Received: by 2002:a5d:5c01:0:b0:37d:461d:b1ea with SMTP id ffacd0b85a97d-381c7ab30b1mr16425247f8f.48.1730884045816;
        Wed, 06 Nov 2024 01:07:25 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c7530sm14933795e9.25.2024.11.06.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:07:25 -0800 (PST)
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
Subject: [PATCH net-next v3 2/2] netlink: specs: Add a spec for FIB rule management
Date: Wed,  6 Nov 2024 09:07:18 +0000
Message-ID: <20241106090718.64713-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241106090718.64713-1-donald.hunter@gmail.com>
References: <20241106090718.64713-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YNL spec for FIB rules:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_rule.yaml \
    --dump getrule --json '{"family": 2}'

[{'action': 'to-tbl',
  'dst-len': 0,
  'family': 2,
  'flags': 0,
  'protocol': 2,
  'src-len': 0,
  'suppress-prefixlen': '0xffffffff',
  'table': 255,
  'tos': 0},
  ... ]

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_rule.yaml | 242 +++++++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
new file mode 100644
index 000000000000..03a8eef7952e
--- /dev/null
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -0,0 +1,242 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: rt-rule
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  FIB rule management over rtnetlink.
+
+definitions:
+  -
+    name: rtgenmsg
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
+    name: fib-rule-hdr
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: dst-len
+        type: u8
+      -
+        name: src-len
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: table
+        type: u8
+      -
+        name: res1
+        type: pad
+        len: 1
+      -
+        name: res2
+        type: pad
+        len: 1
+      -
+        name: action
+        type: u8
+        enum: fr-act
+      -
+        name: flags
+        type: u32
+  -
+    name: fr-act
+    type: enum
+    entries:
+      - unspec
+      - to-tbl
+      - goto
+      - nop
+      - res3
+      - res4
+      - blackhole
+      - unreachable
+      - prohibit
+  -
+    name: fib-rule-port-range
+    type: struct
+    members:
+      -
+        name: start
+        type: u16
+      -
+        name: end
+        type: u16
+  -
+    name: fib-rule-uid-range
+    type: struct
+    members:
+      -
+        name: start
+        type: u32
+      -
+        name: end
+        type: u32
+
+attribute-sets:
+  -
+    name: fib-rule-attrs
+    attributes:
+      -
+        name: dst
+        type: u32
+      -
+        name: src
+        type: u32
+      -
+        name: iifname
+        type: string
+      -
+        name: goto
+        type: u32
+      -
+        name: unused2
+        type: pad
+      -
+        name: priority
+        type: u32
+      -
+        name: unused3
+        type: pad
+      -
+        name: unused4
+        type: pad
+      -
+        name: unused5
+        type: pad
+      -
+        name: fwmark
+        type: u32
+        display-hint: hex
+      -
+        name: flow
+        type: u32
+      -
+        name: tun-id
+        type: u64
+      -
+        name: suppress-ifgroup
+        type: u32
+      -
+        name: suppress-prefixlen
+        type: u32
+        display-hint: hex
+      -
+        name: table
+        type: u32
+      -
+        name: fwmask
+        type: u32
+        display-hint: hex
+      -
+        name: oifname
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: l3mdev
+        type: u8
+      -
+        name: uid-range
+        type: binary
+        struct: fib-rule-uid-range
+      -
+        name: protocol
+        type: u8
+      -
+        name: ip-proto
+        type: u8
+      -
+        name: sport-range
+        type: binary
+        struct: fib-rule-port-range
+      -
+        name: dport-range
+        type: binary
+        struct: fib-rule-port-range
+      -
+        name: dscp
+        type: u8
+
+operations:
+  enum-model: directional
+  fixed-header: fib-rule-hdr
+  list:
+    -
+      name: newrule
+      doc: Add new FIB rule
+      attribute-set: fib-rule-attrs
+      do:
+        request:
+          value: 32
+          attributes: &fib-rule-all
+            - iifname
+            - oifname
+            - priority
+            - fwmark
+            - flow
+            - tun-id
+            - fwmask
+            - table
+            - suppress-prefixlen
+            - suppress-ifgroup
+            - goto
+            - l3mdev
+            - uid-range
+            - protocol
+            - ip-proto
+            - sport-range
+            - dport-range
+            - dscp
+    -
+      name: newrule-ntf
+      doc: Notify a rule creation
+      value: 32
+      notify: newrule
+    -
+      name: delrule
+      doc: Remove an existing FIB rule
+      attribute-set: fib-rule-attrs
+      do:
+        request:
+          value: 33
+          attributes: *fib-rule-all
+    -
+      name: delrule-ntf
+      doc: Notify a rule deletion
+      value: 33
+      notify: delrule
+    -
+      name: getrule
+      doc: Dump all FIB rules
+      attribute-set: fib-rule-attrs
+      dump:
+        request:
+          value: 34
+        reply:
+          value: 32
+          attributes: *fib-rule-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-rule
+      value: 8
+    -
+      name: rtnlgrp-ipv6-rule
+      value: 19
-- 
2.47.0


