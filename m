Return-Path: <netdev+bounces-180997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953BA835EE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A7546427C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B71DEFC6;
	Thu, 10 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6yg2+38"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5941DED52
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249637; cv=none; b=OItdXibIDVPyJUXA8599yeSVtgRunaqjlcQ33slHE4Uj6IqrkMvarAPioaejOSarWqav1fycswUmKHDwxrQvPRlq89nPjVa16bKB2yHgSt431wS+4kf5+6Nw2gg+CBeP23bKQTUpZKZdixfcRwcbz/Lo0Nj7Cl8peFQbZfbmDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249637; c=relaxed/simple;
	bh=/hq0OpQUPN9SFGPFXRnwKL2/v53srh8HgYgOmaKN1og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd94BKXg2dR7H9VJIWKFBgSCsuQIw1mnmoOlUTt8MXZfqb0jUR2TOPNOBCzmjHCGXePE2Erphppe4a+vEbsP8EIMR9WM/hT4D0yxetUmrhJbZ+SYvrpOxph8aPEYsohzPwOFbsmRcb6KEdOLTw1orHDScX/IgEY3xGnNs8kTqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6yg2+38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0230AC4CEEA;
	Thu, 10 Apr 2025 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249636;
	bh=/hq0OpQUPN9SFGPFXRnwKL2/v53srh8HgYgOmaKN1og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6yg2+38qBJVrKa++D9wO7CVeJuacIKOLfVbbyIikUWl26gSjvcnQihom+GgesF+5
	 AHpAiL9/sqSsb4gPpl6lPH5/n2gudR+NhBld68cXjWYqh0FoMMMqKH5u4sJIiwosP6
	 XzeLs4bFEU+82qmv+NBQZBdocXt1Y9SAzWd3sx7BYVTLNBKUy0jPsTvKyFCrVMRcp5
	 4BNZvXSaD6HWFy6AF2JYUQmckJaV5Uio708Gl8kIZGdU8OP4M4sOgB369ZGomqq9AF
	 +Tb+H8i0NXD7VXJNWU87mDlKsWVifQtlj5S59aDpDKRKjclRjZSa4j898ohdQEpY9o
	 HOZuhGc49v6aw==
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
Subject: [PATCH net-next v2 10/13] tools: ynl-gen: consider dump ops without a do "type-consistent"
Date: Wed,  9 Apr 2025 18:46:55 -0700
Message-ID: <20250410014658.782120-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
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

Make sure we output the "onesided" types, normally if the type
is consistent we only output it when we render the do structures.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - s/onside/oneside/
 - extend commit msg
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b0b47a493a86..efed498ccb35 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1212,6 +1212,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
+        self.type_oneside = False
         if op_mode != 'do' and 'dump' in op:
             if 'do' in op:
                 if ('reply' in op['do']) != ('reply' in op["dump"]):
@@ -1219,7 +1220,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
                     self.type_consistent = False
             else:
-                self.type_consistent = False
+                self.type_consistent = True
+                self.type_oneside = True
 
         self.attr_set = attr_set
         if not self.attr_set:
@@ -1516,7 +1518,9 @@ _C_KW = {
         suffix += f"{direction_to_suffix[direction]}"
     else:
         if direction == 'request':
-            suffix += '_req_dump'
+            suffix += '_req'
+            if not ri.type_oneside:
+                suffix += '_dump'
         else:
             if ri.type_consistent:
                 if deref:
@@ -1995,7 +1999,7 @@ _C_KW = {
     if not direction and ri.type_name_conflict:
         suffix += '_'
 
-    if ri.op_mode == 'dump':
+    if ri.op_mode == 'dump' and not ri.type_oneside:
         suffix += '_dump'
 
     ri.cw.block_start(line=f"struct {ri.family.c_name}{suffix}")
@@ -2979,7 +2983,7 @@ _C_KW = {
                     ri = RenderInfo(cw, parsed, args.mode, op, 'dump')
                     print_req_type(ri)
                     print_req_type_helpers(ri)
-                    if not ri.type_consistent:
+                    if not ri.type_consistent or ri.type_oneside:
                         print_rsp_type(ri)
                     print_wrapped_type(ri)
                     print_dump_prototype(ri)
@@ -3057,7 +3061,7 @@ _C_KW = {
                 if 'dump' in op:
                     cw.p(f"/* {op.enum_name} - dump */")
                     ri = RenderInfo(cw, parsed, args.mode, op, "dump")
-                    if not ri.type_consistent:
+                    if not ri.type_consistent or ri.type_oneside:
                         parse_rsp_msg(ri, deref=True)
                     print_req_free(ri)
                     print_dump_type_free(ri)
-- 
2.49.0


