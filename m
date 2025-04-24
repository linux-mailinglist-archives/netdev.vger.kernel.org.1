Return-Path: <netdev+bounces-185372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A691A99EB0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8204466DD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA231D9A5D;
	Thu, 24 Apr 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/nOYqcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DB1D7E54
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460741; cv=none; b=Klbk1qJuasz6Lif0g8zt8YNVffqd679Mi7VuuZWnFeXRrVom55dg2niH6i3xcZm1/u9zoSzcb9uY4ENk4qE4kV+Y8NX1QMsMALOcppNdXG+PLDeZVLCuFXWaTeLd8EsnOaOnrQS9noWPkhJ4G+gdX4FTpDVHk9x1y0v8FdEHqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460741; c=relaxed/simple;
	bh=zNIW2Scb/vu9/qaxPPNn9n8dkXzLBTKPY1zSdRPIRZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkDg6nZKBA9KgjPQqKUanB97jHCuJEZztJSa1Otkkty8nSGgphaCVhP1/4SKtgx4MWjFFYIKVZUc9dED09DK6z1kndRCRvwZ2n1YhhqeobgnJt9ARl0WTUYQrzXZNSF9lmvcFzzXVE6UgnRj+BaPNK4WMcLFbiNhJUXP31xp1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/nOYqcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8459BC4CEF3;
	Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460740;
	bh=zNIW2Scb/vu9/qaxPPNn9n8dkXzLBTKPY1zSdRPIRZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/nOYqcE+R1rM+lypYsDkcQKPbkIG0cjQlfUu4kKbFWG+IrO/p/RfiU5cG926aFNr
	 hSmEunHSCFoKLUkAK/p6o1PRaQkg892DD8zibtZV3LlMMw7t7CJBRum8l1TASi8Hst
	 qsVHzjKWbJYGOWFpyf1RVtp3tc26KmkJ5ANP40A40zwZqQt1twOBSwckrG+g1RTJPg
	 wE49G9q2wFn6QTvC3lc7wIlDoSU3x5w+oIhlJc586eYfk/LaT5YSdMjsv8/twKIajk
	 MBHGARUGEZ2RxBqWfEgIYV0xTWUKe0EhQy27Wjqtwwcjo3vd7T0yj9InFKLrBx04g9
	 be7hg+vuYlBiQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/12] tools: ynl-gen: don't init enum checks for classic netlink
Date: Wed, 23 Apr 2025 19:12:06 -0700
Message-ID: <20250424021207.1167791-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 97fe9938c233..fbcd3da72b3d 100755
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
+        if not family.is_classic():
+            # Classic families have some funny enums, don't bother
+            # computing checks we only need them for policy
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


