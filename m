Return-Path: <netdev+bounces-186787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E4AA10E4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33CE4A60D7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546824395C;
	Tue, 29 Apr 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dim11Cu7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2A23E227
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941638; cv=none; b=I8OL1+0HWr7fyZ5WcD1TPtSinOqDXhmFHgZmT37wfef+StplS85k5xrzhcW4kYzTpG+uMTpf1R2lBZ2swvF7SEeiLD4yp51wfngTkN7ObjYw/ovJVWWOARXpIolz1NJDRQW3+XozgxV9yGyzObtCeQhvAS28gdjNkgPGH5fgkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941638; c=relaxed/simple;
	bh=p+c66w8JWB7ZFLLZnH6e7DPsFLM0G891A4GUZNYRYH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ46aUC5ZiePoHIl+ixqFmHSgEU2rWxSBBwcAO0/j+mDTKIY8j11hWw/Xupcm5twk/2Nt7dQJFCuc/CAt3r52j4pv4qW4uGs+TKEtVrhE8Sgajyq+M+r5yLmNyy6hAWuuNEbWw6c83tUt0/Y1kdbvM1VtwO06V2vx9mi/cFaEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dim11Cu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB81C4CEEF;
	Tue, 29 Apr 2025 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941638;
	bh=p+c66w8JWB7ZFLLZnH6e7DPsFLM0G891A4GUZNYRYH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dim11Cu71W1UoLy+cne+ll94/DyJAr/QMMna6lEfVbuzSKf31lRtFDGVfk7PTLSyM
	 ztJAVKQiDgSFDMqZrfPtRUDJnTBLHbGqaS6+h8ZPj2F1RLvyjEnIPuWqcqSsUhhmUf
	 KAAcpDvDC9SmPHCtzK4t1MV0ahT1MtU6vdoUA3tMEsramRq5TeODOyCWPvDeJkun7C
	 7jh8wvgfxiN61bJqvMPa7zSi3IcbdrFgnlaadBM1UuMvjsuVfnZcCMrrAbRx6SPgA1
	 rbwZzaJJxT25O1VmIQj3bv7iCarFmlgHGQdS0o/01UQSX/YxpxvztxgNEfp4PFHFvJ
	 1QEwOtyGDr5tQ==
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
Subject: [PATCH net-next v3 11/12] tools: ynl-gen: don't init enum checks for classic netlink
Date: Tue, 29 Apr 2025 08:47:03 -0700
Message-ID: <20250429154704.2613851-12-kuba@kernel.org>
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

rt-link has a vlan-protocols enum with:

   name: 8021q     value: 33024
   name: 8021ad    value: 34984

It's nice to have, since it converts the values to strings in Python.
For C, however, the codegen is trying to use enums to generate strict
policy checks. Parsing such sparse enums is not possible via policies.

Since for classic netlink we don't support kernel codegen and policy
generation - skip the auto-generation of checks from enums.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - improve grammar
v2: https://lore.kernel.org/20250425024311.1589323-12-kuba@kernel.org
 - move the comment about the skip before the if
v1: https://lore.kernel.org/4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2d185c7ea16c..1dd9580086cd 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -357,26 +357,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if 'byte-order' in attr:
             self.byte_order_comment = f" /* {attr['byte-order']} */"
 
-        if 'enum' in self.attr:
-            enum = self.family.consts[self.attr['enum']]
-            low, high = enum.value_range()
-            if 'min' not in self.checks:
-                if low != 0 or self.type[0] == 's':
-                    self.checks['min'] = low
-            if 'max' not in self.checks:
-                self.checks['max'] = high
-
-        if 'min' in self.checks and 'max' in self.checks:
-            if self.get_limit('min') > self.get_limit('max'):
-                raise Exception(f'Invalid limit for "{self.name}" min: {self.get_limit("min")} max: {self.get_limit("max")}')
-            self.checks['range'] = True
-
-        low = min(self.get_limit('min', 0), self.get_limit('max', 0))
-        high = max(self.get_limit('min', 0), self.get_limit('max', 0))
-        if low < 0 and self.type[0] == 'u':
-            raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
-        if low < -32768 or high > 32767:
-            self.checks['full-range'] = True
+        # Classic families have some funny enums, don't bother
+        # computing checks, since we only need them for kernel policies
+        if not family.is_classic():
+            self._init_checks()
 
         # Added by resolve():
         self.is_bitfield = None
@@ -401,6 +385,28 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         else:
             self.type_name = '__' + self.type
 
+    def _init_checks(self):
+        if 'enum' in self.attr:
+            enum = self.family.consts[self.attr['enum']]
+            low, high = enum.value_range()
+            if 'min' not in self.checks:
+                if low != 0 or self.type[0] == 's':
+                    self.checks['min'] = low
+            if 'max' not in self.checks:
+                self.checks['max'] = high
+
+        if 'min' in self.checks and 'max' in self.checks:
+            if self.get_limit('min') > self.get_limit('max'):
+                raise Exception(f'Invalid limit for "{self.name}" min: {self.get_limit("min")} max: {self.get_limit("max")}')
+            self.checks['range'] = True
+
+        low = min(self.get_limit('min', 0), self.get_limit('max', 0))
+        high = max(self.get_limit('min', 0), self.get_limit('max', 0))
+        if low < 0 and self.type[0] == 'u':
+            raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
+        if low < -32768 or high > 32767:
+            self.checks['full-range'] = True
+
     def _attr_policy(self, policy):
         if 'flags-mask' in self.checks or self.is_bitfield:
             if self.is_bitfield:
-- 
2.49.0


