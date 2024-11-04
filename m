Return-Path: <netdev+bounces-141595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4829BBA9F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB95B21FD4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE51C4A1D;
	Mon,  4 Nov 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Xq/H1s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9F1C4A0D
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739248; cv=none; b=UbMAUi/cQX/TLoF9gEU5muSxSastD89PW31WKl6SfXhYAIJgbYQJbjoUfXfNHa6UGcA8TBl8Vxe+/XPxnYQg/V8K+wpbeY4M+Rcwio7m7eMF9+k4c3GdELHIXxSnB38gfXhNuazAfPnkx0aWcYzzx8qZSEcWX4jsLA04FxvWEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739248; c=relaxed/simple;
	bh=w5f6FWfvgAOLuQ20AaIaPIWUVrkMs2KNy1sgC+jDG8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU6VBzsFlwdFyY9ufJLIgpT0JXYQhaUK7vs40Q5p1644W7cSs4fC91S+6pHzPLGuOhjZkJprJy2Ln2uKQ/ACY7X4ifXwXE630VogFSmN9aDVospPD3+vxyytw7c9RVFVG8WOrCMKhahnsgB9AvgZibPtaa6kwvxwa673rD77j88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Xq/H1s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so36451915e9.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739244; x=1731344044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO6j/x/kWI8zBc/XwdjMsZ+ZtqceNlS5HOmV6KlCPzE=;
        b=i2Xq/H1sp/WZ3KrJnC7FS6UJ9u76O1rpLEKbZZ0Aac38S/xPaCL/TIZO+m/4jC2vQP
         bCNqmoFBc+geRNcKCqmv9VhK8DNPBuFZSHoMvz0Zlfg36MGVgX/AoSAtN2khAR11tSk1
         raP8vUP8ay94VGxr0Jcyo0y42yz5BLpOrTGbxlyoZZ3VDqNK9IxlB5X1b6XrtcESBKEy
         qhTDqNg+nAm2Wp6VwRh2Z/YEPQ7tRdMNtV6cqerrNmtE6PANmz/EUsN4lo1ALSPTI/+h
         KZlLF8SdIFaccZOmIMFOezBN0AZoLnSJajmWkRsdCa884zkQA8BeN0eqklc6UdoYJn5G
         /BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739244; x=1731344044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO6j/x/kWI8zBc/XwdjMsZ+ZtqceNlS5HOmV6KlCPzE=;
        b=N5Pf8j+1uROHGB8hMRUSrBh/xNMiIBo0y24d/jIPNKJ5u5iZZCsCzXG/S7IC6K0PlH
         D/qm9PAy49Bb+Cvxf8hzPjQW8mbn7Tjh2HJbXkDW+b/M3hXWMeNjqV7EAAu8grXAYxoN
         UAbtAGtZHnxXhAGDRL6FtcYKrAWGYGaUiYZauBmmgR+5EEDs/QCc+30f5QqYJG66Assi
         PxdbF55L0RxgyQ1jQ2BelO33uVucrTgYLrM6rUWs8BYYZ+CfxPkXSV083uxZbgYuiKKY
         G9NBWXvbaY5VP4X9Y2Ew7dBx91rH+H7PzUZ2+9IiJ3DRThovLnopBOx7KMufCq5DQRUK
         ehVw==
X-Gm-Message-State: AOJu0YwIfWqjq04/Z0FtIyxHWUiOeNhhcrVvFzQn8aBqh43IFfhEVXJD
	AbZexFIDJz+oas2nEa9e7bvlXy285PFCij/kaA3+9zakw+sNKW+aHZPh8Q==
X-Google-Smtp-Source: AGHT+IEinUugruS8XTGXev/x5dLn3A+H68cXuTSUX/Gz4JVs9e2xdHv0+2/Upo/okXcndnQFlLTZiw==
X-Received: by 2002:a05:600c:5618:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-431a01782c6mr276372605e9.22.1730739243965;
        Mon, 04 Nov 2024 08:54:03 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:71af:4a7:35c:6d53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852e4sm156878085e9.29.2024.11.04.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:54:03 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/2] netlink: specs: Add a spec for FIB rule management
Date: Mon,  4 Nov 2024 16:53:52 +0000
Message-ID: <20241104165352.19696-3-donald.hunter@gmail.com>
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

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_rule.yaml | 240 +++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
new file mode 100644
index 000000000000..736bcdb25738
--- /dev/null
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -0,0 +1,240 @@
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
+        type: u16
+      -
+        name: end
+        type: u16
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
+          attributes:
+            - nsid
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


