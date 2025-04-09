Return-Path: <netdev+bounces-180531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E691DA8199D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F98C08CA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CFE5FB95;
	Wed,  9 Apr 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT8tRoaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D05464E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157070; cv=none; b=QuPF4G4t6lh+1XaJhhfi1Pm0FD2hixpNyxaOetu23ye+SvYOSPdAC7p6C6VEV1BmSSWMI4PglXpiMdolUxo8RWU2csGWXnWND+RUoaWr4mU77XLW0KMnZA3b8nK4XC2BkEvUiXDzLinzAp9wMDQFEFvxQhi70RQ8/I5AS9dXbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157070; c=relaxed/simple;
	bh=YLEgglGjzIFUoh6DToizvydwHhhfPXLxH56ZctPPFJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paNGQej2y0GUyrSD8IzRqfP7H65S3FhiZqP3lP6DLzKS4/m8W7TdD+UvTqdN0SyAHaPpDqkGY2avUwYO7QyfVcEDikGNzfvgxlb/OcHGNoYOem6xRUrC2bH8vkOti0gxi55oQX+2GpBdbnUqUEkEz3/b1PD5fA/W6BDLWNzUc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT8tRoaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BE6C4CEE5;
	Wed,  9 Apr 2025 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157069;
	bh=YLEgglGjzIFUoh6DToizvydwHhhfPXLxH56ZctPPFJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GT8tRoaSGET/E6W/NAKdgvXsfhmpAhIJYczVeAixusvREzjUFdb8GYzapr3GEbfE1
	 8ccATwmRmc8exdmxfhUahqol3psJOZ2phhm7A/L9PTuZYAL1huoCF96pzfVmY3iQV7
	 XhriMmWRPQdARkdIBq1PotBXvNg5TmaxvdYuiYc6NQBhruI2P/5FgCd5dbIqymyS2o
	 unO4BAyN+9iShb5YJOvaofCO5SG7ZouNQZmWKVx7na7NcfbwoUz9Mz0P4VzvrCTFiV
	 VyMv0IlXaALc217/p5FH+rubTqpmsL7BviSZHaG/DxqqP7J5l76uG9hyMocNof47aD
	 yAP3Qt1IcUcPw==
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
Subject: [PATCH net-next 10/13] tools: ynl-gen: consider dump ops without a do "type-consistent"
Date: Tue,  8 Apr 2025 17:03:57 -0700
Message-ID: <20250409000400.492371-11-kuba@kernel.org>
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

If the type for the response to do and dump are the same we don't
generate it twice. This is called "type_consistent" in the generator.
Consider operations which only have dump to also be consistent.
This removes unnecessary "_dump" from the names. There's a number
of GET ops in classic Netlink which only have dump handlers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b0b47a493a86..c97cda43a604 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1212,6 +1212,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
+        self.type_onside = False
         if op_mode != 'do' and 'dump' in op:
             if 'do' in op:
                 if ('reply' in op['do']) != ('reply' in op["dump"]):
@@ -1219,7 +1220,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
                     self.type_consistent = False
             else:
-                self.type_consistent = False
+                self.type_consistent = True
+                self.type_onside = True
 
         self.attr_set = attr_set
         if not self.attr_set:
@@ -1516,7 +1518,9 @@ _C_KW = {
         suffix += f"{direction_to_suffix[direction]}"
     else:
         if direction == 'request':
-            suffix += '_req_dump'
+            suffix += '_req'
+            if not ri.type_onside:
+                suffix += '_dump'
         else:
             if ri.type_consistent:
                 if deref:
@@ -1995,7 +1999,7 @@ _C_KW = {
     if not direction and ri.type_name_conflict:
         suffix += '_'
 
-    if ri.op_mode == 'dump':
+    if ri.op_mode == 'dump' and not ri.type_onside:
         suffix += '_dump'
 
     ri.cw.block_start(line=f"struct {ri.family.c_name}{suffix}")
@@ -2979,7 +2983,7 @@ _C_KW = {
                     ri = RenderInfo(cw, parsed, args.mode, op, 'dump')
                     print_req_type(ri)
                     print_req_type_helpers(ri)
-                    if not ri.type_consistent:
+                    if not ri.type_consistent or ri.type_onside:
                         print_rsp_type(ri)
                     print_wrapped_type(ri)
                     print_dump_prototype(ri)
@@ -3057,7 +3061,7 @@ _C_KW = {
                 if 'dump' in op:
                     cw.p(f"/* {op.enum_name} - dump */")
                     ri = RenderInfo(cw, parsed, args.mode, op, "dump")
-                    if not ri.type_consistent:
+                    if not ri.type_consistent or ri.type_onside:
                         parse_rsp_msg(ri, deref=True)
                     print_req_free(ri)
                     print_dump_type_free(ri)
-- 
2.49.0


