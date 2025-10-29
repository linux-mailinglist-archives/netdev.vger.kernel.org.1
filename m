Return-Path: <netdev+bounces-233785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F51C1863E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421A93AA344
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 06:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116A2FDC59;
	Wed, 29 Oct 2025 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV6t+NOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8B2F691A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718373; cv=none; b=LSEw9nXNpdruUL4blQswBzlPME/SFgkbSd7YwPe+nY+of8CXrLanCH8U0ybXsFwK1xKWTsrlETtYy12tirCo0EYLqmzwqMmpi80w0kYQj5ZGZjojvjO9YyH6YDoi3W0MXiKHX5Ex0Xr4pH67kPYPummlYz9nzCJL7DYwKH0Ht5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718373; c=relaxed/simple;
	bh=Jz6lTbQJJpANgTNmdxol8b5N1JDR8lBZHzpn1MjixyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUMKSut7MDyUAZjlABWrQhGdaT496L4k1S8M+JxhGLGMY1q5BSVMdyAYzP8mNg450UeBUgQm9k33/59Y4URF14hJdcxL0UT99BSAj4ryO61WVpbkFVQ8Gk8skF5fFnX4S5WPLo7X3Ebn3UBU3a6xwa4A2SkX6uG5npjRMFCTnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV6t+NOM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so84232405ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761718371; x=1762323171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i05jzYamgP9lQzq7NVfIhzmsUOor7ugG/3Trve+qFY0=;
        b=MV6t+NOMaBGztvJOv/y1zG3vKZD3uDr1qwpOFTSyKHTvT0MOTuDNBtBEr74+kqgoRU
         oNwfQuK1UHZN0Re+tyccxmyoJyyojwYvc8JKr6VB+Fc67ho15e+6FOFHQ//heykfrtVR
         DBm++RTrVUrJZRMC2oRBLEFpcstcVweH8MF5nmJrZSSlEbV7VrkYzMywQDFNSe0iM1LJ
         XCxyUyHrdJmOX9tB1Hm2B6LKDaGjDunCgZ+4geJCA0sdrrURxOqq8ukMtI2wMA4Q1FXR
         qY2kmLz+NoSXUw2jEr5mqLOJjCwPdMA+489DoTHmUicam49sikk5RUfbnw4gpWywR2Ef
         F05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761718371; x=1762323171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i05jzYamgP9lQzq7NVfIhzmsUOor7ugG/3Trve+qFY0=;
        b=UAuK/BIaP+lScFEplv30t5AX2D53v6N1C0ymJzqHjXMLcBzTM7Nho3VaIShBvAztN4
         5QegkWsjTvsSthDfc8tMz9DuCSv0Qf3jaNrmOsJ5QPnXx7QkrnvYMfGHkXlWWXVWv9r2
         Te0PKQlRCV9YkCM048w+4bLhJ8/FrGMMZmdogJ+zD1jiaXUTgL88NaNFhcDwojUk0M1g
         DRTLtAQJiXQjSzO6qNF12SHKbJ4PdxRgb+jQErnSFYJy9vTyfdidv4Ms53+DS9qpS0Mv
         4tHHbt0EjvXcXLTKn9pBsq0huEG81kb0sFNNEkyl0sAaUoZam/GrfWr3f2THAeW3cwCu
         O3FA==
X-Forwarded-Encrypted: i=1; AJvYcCV8HY8khfPaYyEasUqDQcNk1UU8IF0kBKH8FwAfWw4ZgHQQgTe3cNQWOrAXGTZTW/BLbq7eOIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5U4NKVbK8eY9DHH6F0bRIm6vH6j1eVgdzI5rV1h/Xt9ihIhQJ
	8V07vB1JiyDkaTzqSc8Mae+kAiNoUMA4wNjvMqvTQ0gRA9yXmRShyMcG
X-Gm-Gg: ASbGncsqqcU+Ej4mrsEJuj4InG9NxQPJoqvRk2fNdaeTxD0+NfhMQzWkBwkTFnybkrS
	mKZc76QifKnQb7c/5fRtTZgR06ekJXZonOOFc03fmiVR8L7A/nZVKG7ujznRXoIh8kz199z2k39
	R1ws9r3mcy1yjgu0YYc647B0Vsj53im73sVL6dg0xo5B9InlaQuZvWxRNMI14AATQxNYscBep7g
	+HAz81tI4C3RmOSbO7r+46MO3HpBIaiGN3vbPglqJGUyR8f7t2vuKAjPOlkIsiFlQMYHAJlvZrr
	Ckk3fYp+ODyDCgqxSPs7EJDijc81rBF69QsQPYVTuaJvg+rWdFVveAo4wIan2nhfz2B+ei+06Rz
	5YX9McdvLw5g66EZjWWE+anUpi2kJ/qREE8i09AihIDTjVar8S1GgK/f8sBou6dd9JrzjaU9PXA
	==
X-Google-Smtp-Source: AGHT+IGDjwTRcdAqf05X0XiytKvs6TUJs4CRbFOgYSvhPEVGOev9GHKslYfuxtH72VUKIy90kLSq9g==
X-Received: by 2002:a17:902:da8b:b0:24c:9309:5883 with SMTP id d9443c01a7336-294deed42f4mr24163005ad.28.1761718371361;
        Tue, 28 Oct 2025 23:12:51 -0700 (PDT)
Received: from snowman ([2401:4900:615d:8cf8:2d1:6dfc:1f47:b080])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm140404165ad.8.2025.10.28.23.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 23:12:50 -0700 (PDT)
From: Khushal Chitturi <kc9282016@gmail.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Subject: [PATCH v3] xdrgen: handle _XdrString in union encoder/decoder
Date: Wed, 29 Oct 2025 11:42:36 +0530
Message-ID: <20251029061236.5261-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028145317.15021-1-kc9282016@gmail.com>
References: <20251028145317.15021-1-kc9282016@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running xdrgen on xdrgen/tests/test.x fails when
generating encoder or decoder functions for union
members of type _XdrString. It was because _XdrString
does not have a spec attribute like _XdrBasic,
leading to AttributeError.

This patch updates emit_union_case_spec_definition
and emit_union_case_spec_decoder/encoder to handle
_XdrString by assigning type_name = "char *" and
avoiding referencing to spec.

Testing: Fixed xdrgen tool was run on originally failing
test file (tools/net/sunrpc/xdrgen/tests/test.x) and now
completes without AttributeError. Modified xdrgen tool was
also run against nfs4_1.x (Documentation/sunrpc/xdr/nfs4_1.x).
The output header file matches with nfs4_1.h
(include/linux/sunrpc/xdrgen/nfs4_1.h).
This validates the patch for all XDR input files currently
within the kernel.

Changes since v2:
- Moved the shebang to the first line
- Removed SPDX header to match style of current xdrgen files

Changes since v1:
- Corrected email address in Signed-off-by.
- Wrapped patch description lines to 72 characters.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/union.py   | 34 ++++++++++++++-----
 .../templates/C/union/encoder/string.j2       |  6 ++++
 2 files changed, 31 insertions(+), 9 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 2cca00e279cd..ad1f214ef22a 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, _XdrString, get_header_name
 from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
 
 
@@ -40,13 +40,20 @@ def emit_union_case_spec_definition(
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
 
@@ -84,6 +91,12 @@ def emit_union_case_spec_decoder(
 
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
@@ -92,13 +105,13 @@ def emit_union_case_spec_decoder(
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
 
@@ -169,7 +182,10 @@ def emit_union_case_spec_encoder(
 
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
@@ -181,7 +197,7 @@ def emit_union_case_spec_encoder(
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


