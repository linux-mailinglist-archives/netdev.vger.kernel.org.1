Return-Path: <netdev+bounces-230682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D1BED26F
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE04E9E64
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69287230BFD;
	Sat, 18 Oct 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c/U2VCaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C82224B1E
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800692; cv=none; b=gOpaTYBo4yPFhtNifthI/3rw9IHomFbE1e0KdXtkLVjp4LmlM7j+UptYZSdTGxh2VC902+oGKjruyYyEwubt2dlwECGoR69p7gKCEy3yPlu5+O/k/C225dzlatEiTXopD1lGAYBHOxlAvBnK5QdJeWFFjOkXblBuAH3Xl6ID0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800692; c=relaxed/simple;
	bh=qzqeSszSGyaiszISR/czBnXkGhO6/26SHNNlkpAcUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyoL3yqpfqdbJ5ZeZX6E882/HZXnm/OPEuP9Y3jAncpeHuJcHNnZiHX/UNCqskGujCVxdTzFrkKq26q20tq/v0uZmuYZgw1YqROKBohgs9dJGLF/CXSmoyYEZP9+Yy92mvTQLVN94txfvFXcRol7IAasw0loyECXnLz8zn1XDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=c/U2VCaE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b64cdbb949cso382737566b.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800685; x=1761405485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6ph45DuTn4gKNCYi+keao8MWtW71hOag0yh3hz/4co=;
        b=c/U2VCaEB6ndaedTInB0zdhVqGa3dEKg60chIXK/eWHosMuxErYuaa0fPrJFXXnWLE
         Tz/Cz1Q8agXVzVlofRPE+6Ol/Srxg2Rn8kiQ4/ioOqrx5ric3VHna99uxQEDTk9kRzJ6
         wO+bSw9/PlU6mOYVeWO+ZD1XMwSToD4Q9KJKhtbhxWtCN1+fG7oVvK3IQswfW9kbayeT
         7aWIq256mwCoyE+HZcy5ieD/IPZ9Iqbh5t/eAX3rBthSq1WOyKRX/WVoeMk5mba4EoSC
         WbZn7hEx13MsWpnWmxVfx+ls5rEKmt82qOjjA67KNgehoSOsjTfFQwt0F1qUqP1tsC0F
         PmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800685; x=1761405485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6ph45DuTn4gKNCYi+keao8MWtW71hOag0yh3hz/4co=;
        b=EoZ+tWPXX8Kt2cNnpm75tOLvjoWqw7iPXbbQD+yl4bSxl6mSm+5acZ/D93u8tVdpMn
         /+GSrM64Gs33RbxxPyRmWkWL8iIDlfFItpiBTESwDCjAFXdsdtiwPs+28m7/j2vGGNhk
         hepndFyHe0YLVaKidrYkgYZrE+TMyNilk3+g/0NRoQuUIBjHFnoUVzCXe8b7FHDRku3m
         D9St9+RofJhNBJEOb9cZmpH0U/b5CDwyzeRfR7rbkCYsgvHQ71N8rrkGrkAogJmtVPBe
         SzNowotbhj7c14PAclahtZUERv5gUAxi7C/r8GtimiNgXlqb/OZAnyjnHonbD1X+4JlG
         3a6w==
X-Forwarded-Encrypted: i=1; AJvYcCVg3vrfyp0k27hAoAXThZI+5hidQHdMJo2OmQBDyT1Q1ZTmu3OLkSKWyXE5pLNtIk0gf58geDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxosZdP2h9TkISOowHPCZU3VJ04oCardi1pq29vwpdZCnYmt9B2
	JcgUJo29GOJhuh4PVm5GrR062zzfoPiuh4x6eFmGmVu+/5N4bBOzhFSs
X-Gm-Gg: ASbGnct2YszfSAGwcz5rp2fDTAqtGzrI1o6ttJ5a0Dai+G/UbB4929xHaNqngrVG1dO
	TFPlRD9v+lJNNgfJ9U6l4EAyYkWZSMLb0MmMQQGHn5VMFBKtAMTbj3ngcM9dn4KuAojjKC+nDmy
	r/N9mvBDXTn14lbZAZrXCytjBAdbZjrdDyVfD896ycFfNUFpYeUeEn7gAAIPFChrFplrYnqkx4A
	EINiukLLT07dulQG9H4f7yRT+PgUsWbf39GsHDHjPXU6JKLops7fZpAkV47Ukat3exfYVRlQf3q
	rK/exNOjxXnrBLzDxDiSJpPnWXjoWgmR3b0aVPrAb/ybGY/sRM6U8rKEGJgJaTbGAs3hy5iU33R
	Se3f3sv90x61ahZX6pytd9oG1SsKcN2TWCRvHu4hpPyxzn78HISdwW4MkQbh2QOTADVWNDuXeNY
	11ZlE69bxUtwmHr8ldpEZ5sEgizldvl6+Sp1R+KLbWYvxBLvQTGSDjk7e135H3I1V/QXhQ3DOco
	W/OC8UoKFyZ
X-Google-Smtp-Source: AGHT+IEaxfddzIsW7EfJsH4hq5Kgg3RQ2/rfz47KNABoXSBEYYMg0uwV1ertYdf1YmLz+K9fDfpnSQ==
X-Received: by 2002:a17:907:7ea5:b0:b54:185f:359c with SMTP id a640c23a62f3a-b6473149643mr898256366b.16.1760800685477;
        Sat, 18 Oct 2025 08:18:05 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:05 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 4/4] tools: ynl: add start-index property for indexed arrays
Date: Sat, 18 Oct 2025 17:17:37 +0200
Message-ID: <20251018151737.365485-5-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux tc actions expect that the action order starts from index
one. To accommodate this, add a start-index property to the ynl spec
for indexed arrays. This property allows the starting index to be
specified, ensuring compatibility with consumers that require a
non-zero-based index.

For example if we have "start_index = 1" then we get the following
diff.

 		ynl_attr_put_str(nlh, TCA_FLOWER_INDEV, obj->indev);
 	array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
 	for (i = 0; i < obj->_count.act; i++)
-		tc_act_attrs_put(nlh, i, &obj->act[i]);
+		tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
 	ynl_attr_nest_end(nlh, array);

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 Documentation/netlink/netlink-raw.yaml | 13 +++++++++++++
 Documentation/netlink/specs/tc.yaml    |  7 +++++++
 tools/net/ynl/pyynl/lib/nlspec.py      |  1 +
 tools/net/ynl/pyynl/ynl_gen_c.py       |  6 +++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 246fa07bccf6..aafb7cb16beb 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -260,6 +260,9 @@ properties:
                   Sometimes, however, both forms are necessary, in which case header contains the enum
                   form while specific attributes may request to convert the values into a bitfield.
                 type: boolean
+              start-index:
+                description: For indexed arrays the first index value.
+                type: integer
               checks:
                 description: Kernel input validation.
                 type: object
@@ -308,6 +311,16 @@ properties:
                 type: string
               # End netlink-raw
 
+            # allow start index only for indexed arrays
+            if:
+              properties:
+                type:
+                  const: indexed-array
+            then: {}
+            else:
+              not:
+                required: [ start-index ]
+
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
         name-prefix:
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b398f7a46dae..459aa51059ec 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2044,6 +2044,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: police
         type: nest
@@ -2303,6 +2304,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: police
         type: nest
@@ -2493,6 +2495,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: key-eth-dst
         type: binary
@@ -3020,6 +3023,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: mask
         type: u32
@@ -3180,6 +3184,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: flags
         type: u32
@@ -3566,6 +3571,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
   -
     name: taprio-attrs
     name-prefix: tca-taprio-attr-
@@ -3798,6 +3804,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        start-index: 1
       -
         name: indev
         type: string
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 85c17fe01e35..08660602da9d 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -181,6 +181,7 @@ class SpecAttr(SpecElement):
         self.display_hint = yaml.get('display-hint')
         self.sub_message = yaml.get('sub-message')
         self.selector = yaml.get('selector')
+        self.start_index = yaml.get('start-index', 0)
 
         self.is_auto_scalar = self.type == "sint" or self.type == "uint"
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index aadeb3abcad8..698d6089a856 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -852,7 +852,11 @@ class TypeIndexedArray(Type):
             ri.cw.p(f"ynl_attr_put(nlh, i, {var}->{self.c_name}[i], {self.checks['exact-len']});")
         elif self.sub_type == 'nest':
             ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
-            ri.cw.p(f"{self.nested_render_name}_put(nlh, i, &{var}->{self.c_name}[i]);")
+            ri.cw.p(
+                f"{self.nested_render_name}_put(nlh, "
+                f"i{f' + {self.start_index}' if self.start_index > 0 else ''}, "
+                f"&{var}->{self.c_name}[i]);"
+            )
         else:
             raise Exception(f"Put for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
-- 
2.51.0


