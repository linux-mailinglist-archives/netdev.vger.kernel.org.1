Return-Path: <netdev+bounces-185823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D16A9BCF9
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF84C46041D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FC1632D9;
	Fri, 25 Apr 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVnT84Fh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57215ECDF
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549004; cv=none; b=T+UqIR7lNyQMxd6nsE3Z10TjUf3VOvJwElP+4+JvIqpFgiQ5nI/80UtDwz+Jzw7vLKbwQjUL6S0URxdRjbk9Bd2SloDkzU0Tg0JY5VotBI2UdF+YL3aUS+fgIOW7tfwUDIsm6eP4beG1vvIvKvUzMU663KAW3dsrM5oTOFMjR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549004; c=relaxed/simple;
	bh=LSsKEYkgkWRDSSOiGDks1mwT1AB/p6cDoqGcjhAfJXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffVzjKIKqpo84oNQ/dCe95LuiwzsgCG8SgqWfg12HuDXnNc6YBVMwRnX8oGeis9P2mxp8Z6LB9afZjzuqFbMg7aLoRCW94MeLr4ETVMoRIl06PArRmov58Fsyo63XWvl0mqtE+ZYk1aMBmSHr6FLafFTj8BhrbS17Oe65nOdWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVnT84Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF993C4CEEC;
	Fri, 25 Apr 2025 02:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549004;
	bh=LSsKEYkgkWRDSSOiGDks1mwT1AB/p6cDoqGcjhAfJXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVnT84Fh2CzMDh8AlysIX3eZsWz39Z3rIY1W7777y55YnVF0qt5OwrkR2GdUDxtcA
	 O5hVev1qj2CgdGv/6Re0sDCDWMlbFh6er67G5efGN26LrU0EGwOU2rRMPiw1MvpoaH
	 TKmg9j1QCW4e3cKkK2bOohWLNwlP2YywDxGX7AOhsaSWxsRDEZcXJ3efa60WjJkQSw
	 n69R7r98fjlKz2ud1ZaLsFGIO96tMcVrFjvvFTC1zRwp6Ix8k/dyIXg6EnXV0fvctB
	 8PeYPcM6ja2vJ+Uw4UcTtMlv9t0RERQXxjvjpJDmnFiLlBvFRIJUADHZQWW/YH3lGz
	 30ximkOHOFUTg==
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
Subject: [PATCH net-next v2 02/12] tools: ynl-gen: factor out free_needs_iter for a struct
Date: Thu, 24 Apr 2025 19:43:01 -0700
Message-ID: <20250425024311.1589323-3-kuba@kernel.org>
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

Instead of walking the entries in the code gen add a method
for the struct class to return if any of the members need
an iterator.

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


