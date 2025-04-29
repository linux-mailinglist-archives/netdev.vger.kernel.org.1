Return-Path: <netdev+bounces-186778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2FAA10DB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3044A542D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186D23E35D;
	Tue, 29 Apr 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQRbBFzv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224423E329
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941632; cv=none; b=BgKGjmSWFZEwwzHBpj1wLImcXYDdKJlzkeRrRFBWyRXE+Sa0jKzC605jBchY8HO4wH76NFSfu7xK3AsY3xMcT+1DcqgKEc1UqBUpRV8ex7NlQ/wvyZ6Gw0sibwwDowlhK0Xk+SqLv/j/W3PmbqBz2mttcJxwb3cvTy5AJWJkqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941632; c=relaxed/simple;
	bh=7mEfSvk6K4TSfpzW3In1V1zOLhRC1UnoNrIHg7lojsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjkEQz3vELdNRR6qOlzPnBm2JIGkY3d2yvb++CVSnwKFSVNiAHSTPEvfqqyE63q/DzqLOVOU79zAj3XbpVOkmM+K85MOHHZ/0JfgUaI/jdvMcWZoaTYZGEM8zYPX9oeTvIudefsazQkJokeEvR+DTxVS4NPe6h/QJi1lK2mJAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQRbBFzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2556C4CEEF;
	Tue, 29 Apr 2025 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941632;
	bh=7mEfSvk6K4TSfpzW3In1V1zOLhRC1UnoNrIHg7lojsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQRbBFzvEnKoH5e9DH/yLg/patYFI1HGXdyo0OGnDdjUZoeto31V3m/0g/styI6oK
	 CXB/z1VgGVAeOZIo06z3nTpAnV1o/HoVJMb+HGH9HuvVgtvwKR4Z4JvuCULq2mmfgf
	 8NNCABXMZYdKk4oUFo2rGqrN91Bb2Da7q+qHI2HauuoeujWrtcrhh4d1dzDBxn3Qtr
	 YznSGOFoL5k1/WrTig4dsFX7S5P3w4VDNdNd+QNgU5+QyyG7i/1O7pDfEvIM4tgLwc
	 C6t8IT7h6iJ4ZXtKcZPv9k0oWeFCkeAqsxpV6t5qGlnhlojq1KiA2sxnh9sNiqQBOT
	 gv8rvWuKTIx9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 02/12] tools: ynl-gen: factor out free_needs_iter for a struct
Date: Tue, 29 Apr 2025 08:46:54 -0700
Message-ID: <20250429154704.2613851-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of walking the entries in the code gen add a method
for the struct class to return if any of the members need
an iterator.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 077aacd5f33a..90f7fe6b623b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -809,6 +809,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             raise Exception("Inheriting different members not supported")
         self.inherited = [c_lower(x) for x in sorted(self._inherited)]
 
+    def free_needs_iter(self):
+        for _, attr in self.attr_list:
+            if attr.free_needs_iter():
+                return True
+        return False
+
 
 class EnumEntry(SpecEnumEntry):
     def __init__(self, enum_set, yaml, prev, value_start):
@@ -2156,11 +2162,9 @@ _C_KW = {
 
 
 def _free_type_members_iter(ri, struct):
-    for _, attr in struct.member_list():
-        if attr.free_needs_iter():
-            ri.cw.p('unsigned int i;')
-            ri.cw.nl()
-            break
+    if struct.free_needs_iter():
+        ri.cw.p('unsigned int i;')
+        ri.cw.nl()
 
 
 def _free_type_members(ri, var, struct, ref=''):
-- 
2.49.0


