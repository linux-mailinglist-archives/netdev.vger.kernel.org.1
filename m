Return-Path: <netdev+bounces-180529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B811A81996
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC0D190035A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121A2F509;
	Wed,  9 Apr 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx9xmEHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFC259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157068; cv=none; b=qebc4B4uJ9tEo+conf5I06CtyiIrbJoUukkh7v7CyBIw5VkV8ga8ksuknpEQIf5HHfl41ZdP13Ooqs/S7d4/hcFCT70rT843YRzTb58YJkRQKfmehLW/brN3EFH0cbK3kgcw1pGmglucOz9Mi9m2sgEa7GumdNxtzmvmp2ZTHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157068; c=relaxed/simple;
	bh=2tMR18DDkuaPYjcWc/QVhGJoT15D3/AfPjnshHgYOeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ3bLA504BTKT3c/pL7VqLGyiYtkCdf66gpWAf8PQMPqSzuwPilRNlz+OHNx8hqlgOsTOEVvsIknmSv1ruEwp0JlqekHx1x0uFMs/kCXxzR9WjBqlheSDR8i5FTeQnI4CP3GLBNIiUVTcgiQPUOl0AAprN42rHvBrllE2jMnt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx9xmEHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EBC4CEE9;
	Wed,  9 Apr 2025 00:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157068;
	bh=2tMR18DDkuaPYjcWc/QVhGJoT15D3/AfPjnshHgYOeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lx9xmEHdnK0bkSsA5IIc0XOtiWBcxSH9C3+AvEy9RFWPaPdzXflAKzMMI8jiIS3dR
	 v14k0qyuPF4QUiZkr5yPaUnh9dJZjrrgb7EjkwwCFuPmPnQd8Lyf6UrLVYrL5uGzeA
	 0Xc2MoUnbfSHOlKz4IxyJzPFbNBtZZG/YL7/und/fk9ixa3NhIE7XR8akSGpLwThPg
	 Hgg+ka/F44rsFXsJPR2TH4+n7yn6F3sflrwNsGoTgYMztzpLd8Pjj4Zhzu7vZUjnrH
	 0rmQ0C+ev9bafRQFs4jChO7f133LRxqh9rB2LcVGaCqfbqGALevHVphwwkg6MARZgs
	 m60NWZAHO4miA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/13] tools: ynl-gen: don't consider requests with fixed hdr empty
Date: Tue,  8 Apr 2025 17:03:55 -0700
Message-ID: <20250409000400.492371-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C codegen skips generating the structs if request/reply has no attrs.
In such cases the request op takes no argument and return int
(rather than response struct). In case of classic netlink a lot of
information gets passed using the fixed struct, however, so adjust
the logic to consider a request empty only if it has no attrs _and_
no fixed struct.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9e00aac4801c..04f1ac62cb01 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1247,6 +1247,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if op_mode == 'event':
             self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
 
+    def type_empty(self, key):
+        return len(self.struct[key].attr_list) == 0 and self.fixed_hdr is None
+
 
 class CodeWriter:
     def __init__(self, nlib, out_file=None, overwrite=True):
@@ -2034,7 +2037,7 @@ _C_KW = {
 
 
 def print_req_type_helpers(ri):
-    if len(ri.struct["request"].attr_list) == 0:
+    if ri.type_empty("request"):
         return
     print_alloc_wrapper(ri, "request")
     print_type_helpers(ri, "request")
@@ -2057,7 +2060,7 @@ _C_KW = {
 
 
 def print_req_type(ri):
-    if len(ri.struct["request"].attr_list) == 0:
+    if ri.type_empty("request"):
         return
     print_type(ri, "request")
 
-- 
2.49.0


