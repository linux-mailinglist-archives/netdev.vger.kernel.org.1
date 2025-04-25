Return-Path: <netdev+bounces-185831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E7A9BD01
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617C41BA088E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52AA195811;
	Fri, 25 Apr 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+zv6QT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7B194C86
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549010; cv=none; b=QbrrJT9JCjEfiqlzTuO7W7mVdqWs69mfWTVUb7+p+7Gb3QNgrerIWkHD0wgCdaY8aAM3imnHhJ/ir19qXArsXsjZhDy63oJ1ndEcBIoS8KdyTOiZcIZu0iAb1XBhK1xwPHyiKvDz5Fi3DQnI+C1Yt1TqyiDieFbqTk7JyUfKVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549010; c=relaxed/simple;
	bh=RG2eseKyXPRLSHvEJklXi9zGP7lm8PV/yhWYAgjOhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmbG3khZ1leRWiJkYTNNRWqbOTyosnqdh6EjxW1Q2VwHXQjaHnYseOp3bLVigrpgg3G/0pYFYBBqy50lNNOmZOE1B+w2Qc1ysBM2aB9OctExvz42BKtlM0LCfQG140XVmvDkFDdexhlu6I3fXoXulNkJ++GOsSaU615omy3QXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+zv6QT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C731C4CEEB;
	Fri, 25 Apr 2025 02:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549009;
	bh=RG2eseKyXPRLSHvEJklXi9zGP7lm8PV/yhWYAgjOhYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+zv6QT/iJxJk/cFv2Tj629Ua2xtHL6XKAUEBX5dm6+qb6V/4EfLoLYE1ZUYpBLHJ
	 sL32+zQzlMCdkMFZPUKdDxPJ9JhVbGIuWuAVRm5zEvnvWMntVA7yuOQxIrwwnRFhXd
	 tz6woghH9HjzzZ2jGgw3XIiaMHmIka0OvaTpWwhqx9eDP0Jdta5n4m8OkZ/I03MQw+
	 GYOIMkQz+vtLdYb42KBBhd+gVII2kF4eOHQ2FW0/T/gvnKNeSgKAETpG2MxhOip/r8
	 SZs7lwma+bU8JqC2BoeE9OK2L1hPkFT1jnqCyzl4ESsRhnn33XikjvJrJWjqmrnkZs
	 yWNXogp5/Bmpg==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/12] tools: ynl-gen: don't init enum checks for classic netlink
Date: Thu, 24 Apr 2025 19:43:10 -0700
Message-ID: <20250425024311.1589323-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
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
v2:
 - move the comment about the skip before the if
v1: https://lore.kernel.org/4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2d185c7ea16c..eda9109243e2 100755
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
+        # computing checks we only need them for policy
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


