Return-Path: <netdev+bounces-77914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D2873725
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B4628123B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A913173E;
	Wed,  6 Mar 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmG9Q/HB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05482130AFC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729838; cv=none; b=E4iEgPtUNMf5YHqSVZtcu0x4WV/3PGlGsChRs5e505XvEmSeXAeqnwJHn8m2LUr0oFY5mHtTqSZHjDhEn1NgrEBbhA3Yeyj7Q3PAPHtE2kZn9TtZAujaQshJ0SlQKYTBYQS4rrpLsMCwMXV8hk8dwyEdPmApaT4jVjT7JkNq08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729838; c=relaxed/simple;
	bh=LNhHtjjKiO66wuzCvV8h/rAdQdAYk3CcCuwunqmvIyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4/VTbPe+X9F60fGZiOF9wJLojFJkCnbm1OmoWQrVrxgxOp1+icjDfBB2K+WXaG94mSIXNa9dQTUwAch2DIaJd7FcOkdA3dmgumESJ+etau9XOkCyJVimJGSqE4U9prtQCrkerXEuYXneVjG3XhL7wEHK8ps4A/Df2tFwl0bov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmG9Q/HB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51364c3d5abso443840e87.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729835; x=1710334635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCZAK3Ii/hnvHy+vEnXOA+S4Q0EMIqgCX16Mb5G/BgM=;
        b=OmG9Q/HBKsdW+o7nFjnArm9GzP6XCDuykcbziyraVr+jJlIsB9FoXtwRRLIRZR9ixC
         iNB2TunoqY6oEJxUZZGiJ1Tj4nvrc0rnv2A44p8aK1YdOLkr3CW3tuLNv6Y8uB+JApsH
         Q7ETVSFDxjl35mK0dUPmTCGyg/eJt35mxXOIuvNJX6Lrwvv+tIlXuriXgH+6Ot3/fI1t
         TZSGyeVg36l6b3o+0JfT0tBkjfNsuNqPjXsvJWepf/82abAnPO/e5KssU8UEXaima00c
         PyELdN4rPVDm6vPMm2WgFBbkJQV7LGPR9SRiYDqoKEqQF4tt6ChKeABpMqC1xzYKtYVJ
         +0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729835; x=1710334635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCZAK3Ii/hnvHy+vEnXOA+S4Q0EMIqgCX16Mb5G/BgM=;
        b=P/5nZnimX9+NcKS/HrjKjdNvY2K/xmDwiTbVvhHd9ipReLL0Ffbdl/JO0jd/48wrrX
         IyJCGBLMD8gsOvlIFGz9WOATzE8foqltH/6989bpg2MDeaSO0dNxq2ZAwHfDFYPlScGb
         IN1tX40ld7A4Plk2oJTZCeixlJdLLPCWIkoCy7dM1wRdyS1sBKlXP37bpFXw2WMSs3rL
         1pDU773GcBetCE0jPury9+5bX3MYXz0npMnc8sQUE+rziIv90WObS9SueC++oEDZL4dS
         yBM0z96gfc2wNbEwSCjqoRB671rRHpo6umP86ydMdWv19CiiA3QwLyyS4ekoy1xsvKAo
         sPrw==
X-Gm-Message-State: AOJu0YxsqiajyBmITTSo1BEBCNJsWk6qhr50JuCD2ImQicp1M1rM8vpe
	n+N3I5FDpSXtVkE7rHKyDiOLEaP0Hyn8rFEpC11HklCnJI2N/Z1+eS1iXKGx6yo=
X-Google-Smtp-Source: AGHT+IFY6079Asdqz4eLTn/hcBoNe2Q1CmVt1Mjtpbo4Xjpg4ur/2t2NkgAom0EHYZtE7u5+J4ye5A==
X-Received: by 2002:a05:6512:282c:b0:513:5217:6201 with SMTP id cf44-20020a056512282c00b0051352176201mr4347881lfb.59.1709729834389;
        Wed, 06 Mar 2024 04:57:14 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:13 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] doc/netlink/specs: Add spec for nlctrl netlink family
Date: Wed,  6 Mar 2024 12:57:04 +0000
Message-ID: <20240306125704.63934-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306125704.63934-1-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
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
 Documentation/netlink/specs/nlctrl.yaml | 206 ++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
new file mode 100644
index 000000000000..2e55e61aea11
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
+  Genetlink control.
+
+definitions:
+  -
+    name: op-flags
+    type: flags
+    enum-name: ''
+    entries:
+      - admin-perm
+      - cmd-cap-do
+      - cmd-cap-dump
+      - cmd-cap-haspol
+      - uns-admin-perm
+  -
+    name: attr-type
+    enum-name: netlink_attribute_type
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
+    name-prefix: CTRL_ATTR_
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
+    name-prefix: CTRL_ATTR_MCAST_GRP_
+    enum-name: ''
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: id
+        type: u32
+  -
+    name: op-attrs
+    name-prefix: CTRL_ATTR_OP_
+    enum-name: ''
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
+    name-prefix: NL_POLICY_TYPE_ATTR_
+    enum-name: ''
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
+    name-prefix: CTRL_ATTR_POLICY_
+    enum-name: ''
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
+  name-prefix: CTRL_CMD_
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
+
-- 
2.42.0


