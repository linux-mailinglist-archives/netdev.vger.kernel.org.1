Return-Path: <netdev+bounces-76648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D386E6FB
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479BE287B0E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA0F500;
	Fri,  1 Mar 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE+AAosB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF956FC3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313286; cv=none; b=M6ZFy7HR98yBbORWn9ZDWvPlZrA9jnvi1bfbxq2rKW4p+o0Vt4zlL4XHb9j6h3+dPdF/9ndVTQX1SV8XvV8CVpsiwz/pKjQCIfkusyRa2QwEuzRTdzkVapHCwdxyHvzeUZhlnagUzUMDcnDYOB0pE5jt+PgAF9LT5YleMtO/ziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313286; c=relaxed/simple;
	bh=xkaHrcLkpSmNxGh5grebGCaGBvNuRiuDh19PT8gcvII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxgqfjJgSHt/3N6rKc0VD/HinJbUeBxMPjqyFwnICtt84hzLRbwj/jWK9nX5uEyXS/snq4ZpaObjANXEXsGz4jfWucZ+E56siOvkewGGWcpaKfCq0pchMNw2TCsgLjOkMLRZLPNC6/XVYOw7a1o5jPa1andvxzGDoAhLf/XwX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE+AAosB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412c23551e2so10548535e9.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313282; x=1709918082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DQDjaCr/OkAn7DTXR1QZoJd6CRz/IrrXKz+pjcqAdU=;
        b=JE+AAosB3UANmJyPO6mHGHtXve/0lgtc9sax93qas4QQgd2tAyUX3x91JPF2NnpLJ9
         RpHRzdznWxuwPMw0geHqX1VSYQXU2k/HVzuxrcfxKK6IxxP7pGlJ63MG09aqJ9l2OrkP
         TlWJeaiMIiodIEcO1VBaZlFrBZ3YX+bxW5EmwwyYZ8RDf6dLw3MrcHgZMwXWsMEiqGp6
         pQ+VbWPeApsD8AL3hxPL7ELvoB3GuvIgqDZDP/Mwzm3UfnCf7p4cTHDUrqsgEmqgG/8U
         FUCaX+bjYFCWVN4/2eFRzkxr+VJj4bHAJwBkSNzr7OPeylpGRJtbjem0wsWJYaHQd1H4
         Wj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313282; x=1709918082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DQDjaCr/OkAn7DTXR1QZoJd6CRz/IrrXKz+pjcqAdU=;
        b=LjNGXi+nZQi6Hc5djmDPW/CIf8aGo5VSryjZ7fmhP/juHyNTTdAcG34vZQFK1H2IqI
         pAbezXguXs3WcysDE4P3P+21P8K0w2FQSqFeFTthGCBGkndeoJPNvGm2fVcRh5ZrBOMM
         USxwFaYn4Bo0iovU9QeCMXJC0/zEqaU5xW5anFfQgxOxcBP8Oldhvga7vLWWGvmplGIW
         3uCHI28WGoA1vsRPEu7jjosjTimFRsImdzeBmTddq04aKMZdbOoGMqOdF9LKFrRL8Ehz
         6DDOfwJGjTzFlwXKaLZ0UaOcVnoy6twXWIb9rVfkncgxe0K4JnhbxOeRaGMoD9sWMAwT
         lOSw==
X-Gm-Message-State: AOJu0YyWcXtaVx72eC9ZC1FAzwgMAWa/HgE2fzyoX0spN4Sxss5/uQoe
	64Sx2jwcBofobdnxJKrg4JXAFJ7EmVuK2EfqMhItYIxDzQTG33oqV/Ksa3tgjBU=
X-Google-Smtp-Source: AGHT+IHl9bpJZBXE57H3kE82DYOhYbh1INMXrBvv8KoZzIGE9RIQiVRL3nKx5W2shqNBsOp6xzIA1A==
X-Received: by 2002:a05:600c:474d:b0:412:c285:1091 with SMTP id w13-20020a05600c474d00b00412c2851091mr2864680wmo.7.1709313282507;
        Fri, 01 Mar 2024 09:14:42 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c06e:e547:41d1:e2b2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0033e17ff60e4sm3387556wrg.7.2024.03.01.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:14:42 -0800 (PST)
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
Subject: [PATCH net-next v1 4/4] doc/netlink/specs: Add spec for nlctrl netlink family
Date: Fri,  1 Mar 2024 17:14:31 +0000
Message-ID: <20240301171431.65892-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301171431.65892-1-donald.hunter@gmail.com>
References: <20240301171431.65892-1-donald.hunter@gmail.com>
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
 Documentation/netlink/specs/nlctrl.yaml | 191 ++++++++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
new file mode 100644
index 000000000000..9b35a390ae96
--- /dev/null
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nlctrl
+
+protocol: genetlink-legacy
+
+doc: |
+  Genetlink control.
+
+definitions:
+  -
+    name: op-flags
+    type: flags
+    entries:
+      - admin-perm
+      - cmd-cap-do
+      - cmd-cap-dump
+      - cmd-cap-haspol
+      - uns-admin-perm
+  -
+    name: attr-type
+    type: enum
+    entries:
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
+        type: array-nest
+        nest-depth: 2
+        nested-attributes: policy-attrs
+      -
+        name: op-policy
+        type: array-nest
+        nested-attributes: op-policy-attrs
+      -
+        name: op
+        type: u32
+  -
+    name: mcast-group-attrs
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: id
+        type: u32
+  -
+    name: op-attrs
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
+        reply: &all_attrs
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
+        reply: *all_attrs
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


