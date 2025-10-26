Return-Path: <netdev+bounces-233017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA8C0AFB0
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBE5189D28C
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851B2222AA;
	Sun, 26 Oct 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpgkXalN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995F1E832A
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501635; cv=none; b=m66vmmVkXpzmHqhxmrdUmy3iPI9MiH84RpioADcZiihqLC0HUfLDTPaVvRNhDdjbR9kwvA3ERBnlxb8iErT7LmNThLBAI9XBl194tAgZtB3Uuoo4GR5sqM+BK76lZsJ53SUWgGrhQNSch8+zYGSB9E43dHS++CT2fStgZAV0XZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501635; c=relaxed/simple;
	bh=bsUdyZxowJWtgAkdDM6NuUseZpm4ADIH7h8y/G9Cook=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNmYtaB6xlhwvYgIO+G2XhT8Yv00zaxTQ6o0jReDmCnn1QVYXCYPyrmHNb4YBSanF8K+g4mZi/Zz+YVDI7stiUfuvrfIoc7r4fIYwANBwZ7aUWQhvB2/GtCE5eSjeKfxxT5w78Vv7Xd4hkMbj0ntqkvLHy/0uTQCRTpf7gSDJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpgkXalN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a28226dd13so2656902b3a.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761501633; x=1762106433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHaV3TmVxnoAqXhejDq47KmdfYQgyKejybkw2Me1N8k=;
        b=NpgkXalN53zfOx+82hdqq4mmlp//Iv6h4JAR8h1ZIM/tCt9p/liItaXki+4QQobo8c
         WmNSdBiWKl31KOXZFAJ3HoPcHkqyrXKi6aNn2HHs358D3ULZ+6BibVbUTzgE3CNgyL55
         ieWLl3LUx+WptnS5oOooDUoN0TlXFQt6C0RuOrIWH15pTktjh+/6HNSF3uhmGiGjBYhj
         lp33KOWi0z797HS34O6WHnANnjb9iuWp0iMfMLaLBHYOT1a+ewJ3eV0tVhL/TUu1HWi9
         bwQiz5mGuvMq4sb36JCIfC/uj9y5Ct8xn6eL/O7aYQJBINvgr+a4fANpmHZDNIIwqW10
         QYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501633; x=1762106433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHaV3TmVxnoAqXhejDq47KmdfYQgyKejybkw2Me1N8k=;
        b=CQ+pd3PtRbPuf/YL/sbe/9vZKwfos+ShaPdc6/NP/4+U3KgaeVmUb636iGL01MT71j
         DOeZq/2hB4Lg+T/zHnsCBqB+Uc45kCiBX5+gMZccrQEYpm9vl0bHAIRboLoRiQYPlh1L
         VefuCZ09Y+r11p416WFE37NVxBsbstDvwRaEnGVPwSPef6MBavD0umT0Qh9odNOKdMDM
         fjCyfnzAtH6SdTWlXY+Z2cj4ymz1b5Jn98AFA5S1W1AVcwsNdcwRK5rnTxoQksSzbSHE
         +yDkVo5QYaQxrNMuWonPsODIhGbmI8AAlnUjCJ3laY8G7oHouzUvOaeOheY24F4tDQir
         YklA==
X-Forwarded-Encrypted: i=1; AJvYcCXZRg2impgYIGWrM1GvSaHIJfvyhoKEpqgFR65noCKm1v5y9JKXCfPR0R0VZv+VPB1ss2DlM0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ktnh1StF4pr1gZLnl5J7uJElVkTzM2/bzPZ/2Xz+cz1ce+mY
	o82Cy0ebDi/62VqEfWI6Osgpgi8a+TE//MJPbnSq46nLL6DiFBYtMKlD
X-Gm-Gg: ASbGncsXOP4g2KNbvVNtHJJOUtxdfAxD80eAfXdMebRZjKGWwRd7JYCwhkikLUyZ+iD
	fheeJBaMTUUWJWkuDKyeJDAa7uYAzCi5Vo4oj9f8Cel2AYS6TdE3Ew36iqrMa4oEAPba7u8DirY
	s7nUsBfc3MEUBWbQUfOZfHk8jEQlZL+sH3nRjkJZ1+h1eMgl5zh6Rf5W+KH2qHyNv1c9xmiQFFS
	aL2N/A0wIcTHVnuDpg+2TblKCMJ5yZDRhmnkyWafi0FkyyCvzfpqYwaMjVzgpDEGzhiUXsp3LzW
	AG3aMLAULeZ5EpF5BTFUHCBxRstRZXh01iiQ8n2bWjbaMU7AIs+2duGNcDPZaHyKT6yb7bD4Im0
	w2w8g7qUwutLNVLi6Zn6sgMK7iVulw1IXndecEhKtcL+vCTNW4VBqkYOH94X7walXE0Vj09tlYi
	8=
X-Google-Smtp-Source: AGHT+IH1oNgGKZQ4Y9fVMbqnKjHXUHudd4pszZxhju2pFdhdSu7ADJsfQhD+q8EMHFRpUHk0PC1/dg==
X-Received: by 2002:a05:6a20:914a:b0:33f:df99:11f2 with SMTP id adf61e73a8af0-33fdf991412mr9718307637.14.1761501632586;
        Sun, 26 Oct 2025 11:00:32 -0700 (PDT)
Received: from snowman ([2401:4900:615d:9a11:7123:5dd6:caaa:5450])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7bd08asm5713439a91.3.2025.10.26.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:00:32 -0700 (PDT)
From: Khushal Chitturi <kc9282016@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>,
	Khushal Chitturi <kc928206@gmail.com>
Subject: [PATCH] xdrgen: handle _XdrString in union encoder/decoder
Date: Sun, 26 Oct 2025 23:30:16 +0530
Message-ID: <20251026180018.9248-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running xdrgen on xdrgen/tests/test.x fails when
generating encoder or decoder functions for union members
of type _XdrString. It was because _XdrString
does not have a spec attribute like _XdrBasic,
leading to AttributeError.

This patch updates emit_union_case_spec_definition
and emit_union_case_spec_decoder/encoder
to handle _XdrString by assigning
type_name = "char *" and  avoiding referencing to spec.

Testing: Fixed xdrgen tool was ran on originally failing
test file (tools/net/sunrpc/xdrgen/tests/test.x) and now completes without AttributeError.
Modified xdrgen tool was also run against nfs4_1.x (Documentation/sunrpc/xdr/nfs4_1.x).
The output header file matches with nfs4_1.h (include/linux/sunrpc/xdrgen/nfs4_1.h).
This validates the patch for all XDR input files currently within the kernel.

Signed-off-by: Khushal Chitturi <kc928206@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/union.py   | 35 ++++++++++++++-----
 .../templates/C/union/encoder/string.j2       |  6 ++++
 2 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 2cca00e279cd..3118dfdddcc4 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #!/usr/bin/env python3
 # ex: set filetype=python:
 
@@ -8,7 +9,7 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, _XdrString, get_header_name
 from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
 
 
@@ -40,13 +41,20 @@ def emit_union_case_spec_definition(
     """Emit a definition for an XDR union's case arm"""
     if isinstance(node.arm, _XdrVoid):
         return
-    assert isinstance(node.arm, _XdrBasic)
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+        classifier = ""
+    else:
+        type_name = node.arm.spec.type_name
+        classifier = node.arm.spec.c_classifier
+
+    assert isinstance(node.arm, (_XdrBasic, _XdrString))
     template = get_jinja2_template(environment, "definition", "case_spec")
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
-            classifier=node.arm.spec.c_classifier,
+            type=type_name,
+            classifier=classifier,
         )
     )
 
@@ -84,6 +92,12 @@ def emit_union_case_spec_decoder(
 
     if isinstance(node.arm, _XdrVoid):
         return
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+        classifier = ""
+    else:
+        type_name = node.arm.spec.type_name
+        classifier = node.arm.spec.c_classifier
 
     if big_endian_discriminant:
         template = get_jinja2_template(environment, "decoder", "case_spec_be")
@@ -92,13 +106,13 @@ def emit_union_case_spec_decoder(
     for case in node.values:
         print(template.render(case=case))
 
-    assert isinstance(node.arm, _XdrBasic)
+    assert isinstance(node.arm, (_XdrBasic, _XdrString))
     template = get_jinja2_template(environment, "decoder", node.arm.template)
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
-            classifier=node.arm.spec.c_classifier,
+            type=type_name,
+            classifier=classifier,
         )
     )
 
@@ -169,7 +183,10 @@ def emit_union_case_spec_encoder(
 
     if isinstance(node.arm, _XdrVoid):
         return
-
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+    else:
+        type_name = node.arm.spec.type_name
     if big_endian_discriminant:
         template = get_jinja2_template(environment, "encoder", "case_spec_be")
     else:
@@ -181,7 +198,7 @@ def emit_union_case_spec_encoder(
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
+            type=type_name,
         )
     )
 
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
new file mode 100644
index 000000000000..2f035a64f1f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (variable-length string) */
+{% endif %}
+		if (!xdrgen_encode_string(xdr, ptr->u.{{ name }}, {{ maxsize }}))
+			return false;
-- 
2.51.1


