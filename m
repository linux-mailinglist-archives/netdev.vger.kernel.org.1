Return-Path: <netdev+bounces-185365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B2A99EAA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D61B1945663
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762E19CC0C;
	Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meJ0LUFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEA19ADA2
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460738; cv=none; b=KYGZlcDyYbSY+7djvxV58BtYUP1uLGiJzIBq2GHaHkGQpse4/QodwEhsJZvkEYB4JRtIFG36u9/hV3KO0n+9GhtGelYas/2AdR+ZxRBjqR8FO59FECIb5kwlAGjTsuX3C5luW9UjLSaekRYk+SpTswPWwBiGBs1zH00efbu2qAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460738; c=relaxed/simple;
	bh=07uqiOJEWFux2QtNGmYkcx3FBAxukV03pBXShHt4W90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSYzdTV0mCGR8h0ykKt6HOortkCl/ecYhKmG5r6kRG+btw5ly0PM4e3ujmnMIXx9uXD6kxPyT8Ln4UjJN1ZyNJeDPlKEC3bP+X/AgPpKrQ5OikiasRHRlO1s4/aoXbofxa2uxzzfFFFOwIsioXq8to3szEJKXKk0etzugNP1CUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meJ0LUFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5DBC4CEEE;
	Thu, 24 Apr 2025 02:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460736;
	bh=07uqiOJEWFux2QtNGmYkcx3FBAxukV03pBXShHt4W90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meJ0LUFR+CozFaMfWsm1/RJtbRDbU78AhJMicwgYEGebKBT1qu+1lLN0oapP8VNJF
	 GQ2cSR6npt5CSKAXcWBg5RFAWpAIPjyCM9gTee/W5e/P6IWPvdtJRcIdhRmX1Zgieo
	 eQjPjgJynT30+ndoJM27C4e8pvAYJ0y2omkbaXbSMM+MYlSWR9uZIG3/YRBcJknuAa
	 np1JYLKZRpnJgW9kskKhyU4NWf/QuyMMCqzvJMZ6DQxI6skyLEaKPmYFmLXxKe4C1Y
	 8ZMpTcA+NUy49sGwIHQz5S39DfVUc2eMsK+XyacybGZLgbrHIsBrJxDBVqEAUvP5Q3
	 8uedZ5Eh69RBg==
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
Subject: [PATCH net-next 02/12] tools: ynl-gen: factor out free_needs_iter for a struct
Date: Wed, 23 Apr 2025 19:11:57 -0700
Message-ID: <20250424021207.1167791-3-kuba@kernel.org>
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

Instead of walking the entries in the code gen add a method
for the struct class to return if any of the members need
an iterator.

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


