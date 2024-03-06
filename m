Return-Path: <netdev+bounces-78155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A7874383
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181DA284184
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106931CF9B;
	Wed,  6 Mar 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQiP5ajf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302081C686
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766660; cv=none; b=b14WQl/gr97d6UFd9v7yNzrndvzCuRx3qDK7u5l9WySAqAhlK3b7Vq40wTFGboJ953kW1GIDmYvU23ixRyhiC0m/zKOIH3v7hG/k1FfQWwTrhJCScorOIt67zD2DtfYudcsELPAyoCOPlGR3Z/jwzNcdmZrPI6YfoJquHPzooZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766660; c=relaxed/simple;
	bh=29aUZT8E0ju1Siywvpe+Fh9wAAO2Ozhk/7WLxcb5lbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHS5c4VB/qkyVcH4V573U40KMDFzZe+J+Ml2JH4MJ7ZsIwXtDPZjwb+CV6ZvjR5rBvqExz1TUNKEe7z16nYEmMhUaeq47nPAEcrGy7CmCTLkkEyrXc7nCxKCqTdgV4br23F9Vuc8YIOFMTD9u67Y5gJcdY/YYiY45SyJvPVk3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQiP5ajf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d36736d4eso132078f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766657; x=1710371457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2rb8FJpdUlgnKyLunPhnVB+zpD2moOgEHsxFgiazMo=;
        b=gQiP5ajfGoLjrPNmr1nLU1c4XPgeq8R8H/vEziLVvM0BPvHvKJa4u8vgcsAxJAKrJe
         bwFUlNfh6VgwtZyCIQRgQJSCWra6a96x+aWDtyFKDPJDir3d/UfwRxaG8+Pqw7/vIQVn
         MLmMJZ12nHk2rmQyLdCcaAuN1tymO5gdPvlWOaGKOkh6aYbPn5scBnAEtkZB/D0iuSEg
         938giS1wZ5J2L1WaqVk6X3gHKaKgRDNQ/EgHDnOD+mhuRbg+5pNfai8HfcG/42Y+EaDF
         f8VM+9//Del4MS4R/y01ACwJGMG48ydnIAUIcO5DHqMTQ34O9YJWuXHg/lCkIRTx6WSa
         stJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766657; x=1710371457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2rb8FJpdUlgnKyLunPhnVB+zpD2moOgEHsxFgiazMo=;
        b=BFnODI/hRIMVeBd8jZeE6qpVBp3cDmxr018SAyIWl1oVYNpFuDDjrg1OM/PJ7jRf8G
         vf2q4lK5/BvgfZpaPo8rRAqZFX2Ay2y2VvCk54DrsMZkKmgZDAvMek0U5vW0V1gB407b
         sq5a1LRfpGL/EzX1QAPfMAEFK6MQ2f3hQLzxvlJXj/kAY1PvOBBoAUOI8H/fmoGYpIaI
         +5g4txqQvHwizNK2sK/58flNZQO+G0WOpqj+Yc8AA894nl7EmqTmoB6GESHjzN71i920
         9DpLlCqUEREV00Tb3vwYYejafvOPM9hrhgBmuBkqMghEvIeAj6N6wi2o8ufKFeHmg2Nv
         qADA==
X-Gm-Message-State: AOJu0YwHWyOMXajUWv1CmllN/z90tKAiEMmsMPUvQgSh+efq7SRsNvwr
	GQB+Kg5CiijouuBgH6wdL2pqnRUE8E83/A0KHDoSH6ElF3mhI9RbPTpcFQsej/E=
X-Google-Smtp-Source: AGHT+IHmX2COSyabeZFWKrQ5LKpIr0FyW7wg2iYDYhE0YQH8ab9+8voNmHwsf6MoMQ51ee2/vetJ/Q==
X-Received: by 2002:adf:9c8a:0:b0:33d:c5c7:459e with SMTP id d10-20020adf9c8a000000b0033dc5c7459emr12327245wre.12.1709766657146;
        Wed, 06 Mar 2024 15:10:57 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:56 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 6/6] doc/netlink/specs: Add spec for nlctrl netlink family
Date: Wed,  6 Mar 2024 23:10:46 +0000
Message-ID: <20240306231046.97158-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a spec for the nlctrl family.

Example usage:

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nlctrl.yaml \
    --do getfamily --json '{"family-name": "nlctrl"}'

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/nlctrl.yaml \
    --dump getpolicy --json '{"family-name": "nlctrl"}'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/nlctrl.yaml | 207 ++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
new file mode 100644
index 000000000000..08a8d047d52d
--- /dev/null
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nlctrl
+protocol: genetlink-legacy
+uapi-header: linux/genetlink.h
+
+doc: |
+  genetlink meta-family that exposes information about all genetlink
+  families registered in the kernel (including itself).
+
+definitions:
+  -
+    name: op-flags
+    type: flags
+    enum-name:
+    entries:
+      - admin-perm
+      - cmd-cap-do
+      - cmd-cap-dump
+      - cmd-cap-haspol
+      - uns-admin-perm
+  -
+    name: attr-type
+    enum-name: netlink-attribute-type
+    type: enum
+    entries:
+      - invalid
+      - flag
+      - u8
+      - u16
+      - u32
+      - u64
+      - s8
+      - s16
+      - s32
+      - s64
+      - binary
+      - string
+      - nul-string
+      - nested
+      - nested-array
+      - bitfield32
+      - sint
+      - uint
+
+attribute-sets:
+  -
+    name: ctrl-attrs
+    name-prefix: ctrl-attr-
+    attributes:
+      -
+        name: family-id
+        type: u16
+      -
+        name: family-name
+        type: string
+      -
+        name: version
+        type: u32
+      -
+        name: hdrsize
+        type: u32
+      -
+        name: maxattr
+        type: u32
+      -
+        name: ops
+        type: array-nest
+        nested-attributes: op-attrs
+      -
+        name: mcast-groups
+        type: array-nest
+        nested-attributes: mcast-group-attrs
+      -
+        name: policy
+        type: nest-type-value
+        type-value: [ policy-id, attr-id ]
+        nested-attributes: policy-attrs
+      -
+        name: op-policy
+        type: nest-type-value
+        type-value: [ op-id ]
+        nested-attributes: op-policy-attrs
+      -
+        name: op
+        type: u32
+  -
+    name: mcast-group-attrs
+    name-prefix: ctrl-attr-mcast-grp-
+    enum-name:
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: id
+        type: u32
+  -
+    name: op-attrs
+    name-prefix: ctrl-attr-op-
+    enum-name:
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: flags
+        type: u32
+        enum: op-flags
+        enum-as-flags: true
+  -
+    name: policy-attrs
+    name-prefix: nl-policy-type-attr-
+    enum-name:
+    attributes:
+      -
+        name: type
+        type: u32
+        enum: attr-type
+      -
+        name: min-value-s
+        type: s64
+      -
+        name: max-value-s
+        type: s64
+      -
+        name: min-value-u
+        type: u64
+      -
+        name: max-value-u
+        type: u64
+      -
+        name: min-length
+        type: u32
+      -
+        name: max-length
+        type: u32
+      -
+        name: policy-idx
+        type: u32
+      -
+        name: policy-maxtype
+        type: u32
+      -
+        name: bitfield32-mask
+        type: u32
+      -
+        name: mask
+        type: u64
+      -
+        name: pad
+        type: pad
+  -
+    name: op-policy-attrs
+    name-prefix: ctrl-attr-policy-
+    enum-name:
+    attributes:
+      -
+        name: do
+        type: u32
+      -
+        name: dump
+        type: u32
+
+operations:
+  enum-model: directional
+  name-prefix: ctrl-cmd-
+  list:
+    -
+      name: getfamily
+      doc: Get / dump genetlink families
+      attribute-set: ctrl-attrs
+      do:
+        request:
+          value: 3
+          attributes:
+            - family-name
+        reply: &all-attrs
+          value: 1
+          attributes:
+            - family-id
+            - family-name
+            - hdrsize
+            - maxattr
+            - mcast-groups
+            - ops
+            - version
+      dump:
+        reply: *all-attrs
+    -
+      name: getpolicy
+      doc: Get / dump genetlink policies
+      attribute-set: ctrl-attrs
+      dump:
+        request:
+          value: 10
+          attributes:
+            - family-name
+            - family-id
+            - op
+        reply:
+          value: 10
+          attributes:
+            - family-id
+            - op-policy
+            - policy
-- 
2.42.0


