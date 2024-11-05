Return-Path: <netdev+bounces-141967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A19BCCB7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F7F1F22F98
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBA1D5CFF;
	Tue,  5 Nov 2024 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdhQH/Z2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07801D5ADC
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809722; cv=none; b=OirsPA7DRM4gw+1W1eijc+iZj6qVfG8vJ0itlrL1e2q9Ws72lBPR3f41AIvh2WVwD1VlcRrZwR/X9qHn10HdOqn0ZpDndMhCbJAUoe+aXJtC1tSOebkbuo1z2U+2f09wwHgJn4+ilmvN11/pezi4h4AqfC1XiCWncghJn9WkDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809722; c=relaxed/simple;
	bh=qphZJuHPcJm90rJwhWGhuMwXfM2QOZMksrdDwBVN8kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr/Z/cSo7Wh8Zh40/gu5ho8+9hQj8DFC0noYf5SWISYCzopCifm8pNybNCYCDrhfec0qOVbgpTzD/v+OUe4wxfRqjR3LfoRefu235Cy/LnB/GFm+3IVfWAvumFje86FFWyrNAWBMzy8gdWdDw5GOH9FMh74Mdq9cykVObju3acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdhQH/Z2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d47b38336so4022788f8f.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730809719; x=1731414519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoOU7qcfVaUr8fm69VZW2RnEHe2iRt3p0RxYx3orAr8=;
        b=UdhQH/Z2OX9ErCQdSB9Jx8EK2rI/UTmy9Zz5LKuiR6Gbm5nghllJ4VDHMsqc6BKj2a
         Psm3yLe5zZA77p8rcRYfPCdBT3QevDZnuy7ycgsW1eCzE1U2m+kqdnAFCaP0xX01pMd+
         KGeE6mOQbIPfLQlBeRfBapdQVmi+8diDo1VppFHIX0MCfhn/BNe0ZZjzUX+zM/HQ1eKZ
         egOkiiTyyv7+rd866qYJLIKUB+RXRG5ZZlQJ20jYuYWM46bZXllqZbPcKcXNVNnRQDxw
         E1/p93BtRbFUAFE5GttHxHBQog0yBUEZdGZmQQz6rZijpST2oBZ8kHEKslYPAkg5uBmQ
         qdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809719; x=1731414519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoOU7qcfVaUr8fm69VZW2RnEHe2iRt3p0RxYx3orAr8=;
        b=fdADqFi2gWU9VnQ26RG4dWJMvKLl7urtdZwRbruWRXq+OC5vkeleWbb2DOzFMVd9/M
         xL93pe1qsXWzRBrfwQLLWAVOEYNpx2DljJWzrqfsYEn+QBvfmqEa3BbtvYVa+zeb3NpJ
         4TcTli891VouXxv5yMJoA9NVoOP3W1kgnQxOINV04w6KHjfx8FfgV9qgmRwxBVIJxv2m
         4MJNJtAsZnPvYncPkA3wfx2m3E4A+stpZmus1SRi7z39QAV/CY84Ig8L9UwK+zyO1uVg
         lx3pYLo/3bSK6zZQdY1kqFbGjpnpEtHLgmieyXoNKe9MQ5XRheq/RVF3wzBC+/EgKDsM
         Kcdg==
X-Gm-Message-State: AOJu0YzkB+3iYLzTRc128gGDk5yOOgXy226jW/u5QOTjAVdoHyJKGunt
	3aEy5CbpFyhCCJxxoj08BxaFLVRnvlOc2q/5ID3hM+d0hwrnoPG7eFSaoSE3
X-Google-Smtp-Source: AGHT+IH1B/wdx1IBTyFsSWYxX4ypT1dm8zKHtT4IIbr/mLurEmQrZFBTHmuETGyFeISmW8wbqhqLpw==
X-Received: by 2002:a5d:6a51:0:b0:37d:5301:6edb with SMTP id ffacd0b85a97d-38061221e7bmr22985178f8f.57.1730809718660;
        Tue, 05 Nov 2024 04:28:38 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49c9sm16137029f8f.37.2024.11.05.04.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:28:37 -0800 (PST)
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
Subject: [PATCH net-next v2 2/2] netlink: specs: Add a spec for FIB rule management
Date: Tue,  5 Nov 2024 12:28:31 +0000
Message-ID: <20241105122831.85882-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241105122831.85882-1-donald.hunter@gmail.com>
References: <20241105122831.85882-1-donald.hunter@gmail.com>
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
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_rule.yaml | 244 +++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 Documentation/netlink/specs/rt_rule.yaml

diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
new file mode 100644
index 000000000000..504836c9723e
--- /dev/null
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -0,0 +1,244 @@
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


