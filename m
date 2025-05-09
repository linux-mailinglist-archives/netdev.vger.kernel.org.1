Return-Path: <netdev+bounces-189309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A429AB1912
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A833DA03ADF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A345B2309A7;
	Fri,  9 May 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsM3vlCh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44C230996
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805341; cv=none; b=ICQ8gb5Evj0EItCjG/pfPzwC4aaRwTi7amDdBBkWjzBDxkDtSwViK3fhYUtM2ozfwu4oQQWzVwFpIaHbsygnDJumPf2Y6gHg3UsfPRt9fn+CejC5czzC3opo7z7L/b9GbBaHr5QOL6J2ataZtxfcCzU7kLBtZJEGYW7FrOhZj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805341; c=relaxed/simple;
	bh=lGdptKdhkHIzJry3exOOLjd5lSZlLAoDHph2qPfWYlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7kODW+AXAtYDUqmHBnM18xPGZ6Km0nEm/H5u1TJ31wa0B5loZ19goYJRN3tBN1XvKf6go6ZD3SYVNW4bUTWEyUvCpW/2W+wQqVM+f8MfT57DMdKynbjQfxI5jsGzhDk7+0HA/g9cP5fpLc5LQL1EGhRokoS5bBp8kr7Kam8fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsM3vlCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0BBC4CEEF;
	Fri,  9 May 2025 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805339;
	bh=lGdptKdhkHIzJry3exOOLjd5lSZlLAoDHph2qPfWYlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsM3vlChJfPRQcZX6U4c0E19R7SPHRXjVdDKw5B8JEac3bT9wFRzVrJ6M/A4YlUUo
	 SIPCGsvZdapXNMckvQS//yS9Ytig7ae3y1t3N6CNhL4avciHjwm0IxCcEpWDoLZdED
	 ru0UQ2IbcW+X5oDxE0Juu5Zw8hbD2c0VXMRrnpd8oZXw/FpmtqpCX9EnakchDLpidc
	 Blao74+h3/Nhh1rLiNQSwcOoyIwJFDzyGIqsn/AHIE4TiMqH4bRqxJnS7Fy+0gI9OQ
	 l2vL4VytrZ3+YKTvqqsBFb2IgRiC5ys9T0F+YI0HAUosHOWxa58d6hUd9w/ZTyO0nL
	 8ojCpTnAdFUYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/3] tools: ynl-gen: support struct for binary attributes
Date: Fri,  9 May 2025 08:42:13 -0700
Message-ID: <20250509154213.1747885-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509154213.1747885-1-kuba@kernel.org>
References: <20250509154213.1747885-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using a struct pointer for binary attrs. Len field is maintained
because the structs may grow with newer kernel versions. Or, which matters
more, be shorter if the binary is built against newer uAPI than kernel
against which it's executed. Since we are storing a pointer to a struct
type - always allocate at least the amount of memory needed by the struct
per current uAPI headers (unused mem is zeroed). Technically users should
check the length field but per modern ASAN checks storing a short object
under a pointer seems like a bad idea.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
  - create a separate class
v1: https://lore.kernel.org/20250508022839.1256059-4-kuba@kernel.org
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9a5c65966e9d..3b064c61a374 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -566,6 +566,23 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 f'memcpy({member}, {self.c_name}, {presence});']
 
 
+class TypeBinaryStruct(TypeBinary):
+    def struct_member(self, ri):
+        ri.cw.p(f'struct {c_lower(self.get("struct"))} *{self.c_name};')
+
+    def _attr_get(self, ri, var):
+        struct_sz = 'sizeof(struct ' + c_lower(self.get("struct")) + ')'
+        len_mem = var + '->_' + self.presence_type() + '.' + self.c_name
+        return [f"{len_mem} = len;",
+                f"if (len < {struct_sz})",
+                f"{var}->{self.c_name} = calloc(1, {struct_sz});",
+                "else",
+                f"{var}->{self.c_name} = malloc(len);",
+                f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
+               ['len = ynl_attr_data_len(attr);'], \
+               ['unsigned int len;']
+
+
 class TypeBinaryScalarArray(TypeBinary):
     def arg_member(self, ri):
         return [f'__{self.get("sub-type")} *{self.c_name}', 'size_t count']
@@ -1010,7 +1027,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif elem['type'] == 'string':
             t = TypeString(self.family, self, elem, value)
         elif elem['type'] == 'binary':
-            if elem.get('sub-type') in scalars:
+            if 'struct' in elem:
+                t = TypeBinaryStruct(self.family, self, elem, value)
+            elif elem.get('sub-type') in scalars:
                 t = TypeBinaryScalarArray(self.family, self, elem, value)
             else:
                 t = TypeBinary(self.family, self, elem, value)
-- 
2.49.0


