Return-Path: <netdev+bounces-209046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C6B0E190
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82708162293
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413027B4F5;
	Tue, 22 Jul 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyHKwdee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CC27AC50
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201184; cv=none; b=OLsM4+oFizAJ7cX8ccgSr+RHKxhI2rqbXrimXtL6I9KTEYSNcjiPwugyswpB7tuvIl/MvDmGhOyXnh+te33dCZybbc9VP4Dc4OW/A+p680hAnd0j9vm8vG0tvOy4d0oununis0eAMok30cgrePZ+STHwCfb2kwnvUcXqng0fi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201184; c=relaxed/simple;
	bh=JShZwkwF4MLCb+iEpOuP6r25CzgsCtOhYKnIcOK2lTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaEf24TPPxliBHGs+VN3dvuFQCxwHL85HbJ5IwgRtQ6CuR3KArsvvAehHi0GJc9fXUgCeyP6gXRV+fxffKZA+dMhufUiRD3qfxU3kNs+3z4d/pmFaw+XEJHgIL94BERTa0WI4ktcLBjxVVcFs76wnP/z8iGyQFNa+J7Q9UYuXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyHKwdee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5524BC4CEF9;
	Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201183;
	bh=JShZwkwF4MLCb+iEpOuP6r25CzgsCtOhYKnIcOK2lTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyHKwdeePdhopR2yPzcgAqwIqCpUg9qzwV/3/VLp/o6zart5V19zmJqViS7A8dyU4
	 +xHV/HmmRQnhjQQ2PXDOIO5xDwzF+ffp2csa7MfaT0r6ZE+BQOMZEwMfNg2SnIvWqL
	 kcCXWkhhWLRmUNWxC9j/CvJYqOpXR3NLhhx3VbY33VlLJgMT1EVdf2JeRJxX168TJi
	 zyTiSMoG4auvnTFDbAiRmhbI8waB/WwrNNPPTA0r0D6+pw/xLaHcj9Y6Z5XEFmV/fU
	 9LX2+LUGIslsLnDDgcjnki8BN74ygMd4P00ncTaNJxdwoiAXwMh/RJVl0jW/HJJMjp
	 EhQmOuA5ohEPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] tools: ynl-gen: print alloc helper for multi-val attrs
Date: Tue, 22 Jul 2025 09:19:25 -0700
Message-ID: <20250722161927.3489203-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>
References: <20250722161927.3489203-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general YNL provides allocation and free helpers for types.
For pure nested structs which are used as multi-attr (and therefore
have to be allocated dynamically) we already print a free helper
as it's needed by free of the containing struct.

Add printing of the alloc helper for consistency. The helper
takes the number of entries to allocate as an argument, e.g.:

  static inline struct netdev_queue_id *netdev_queue_id_alloc(unsigned int n)
  {
	return calloc(n, sizeof(struct netdev_queue_id));
  }

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index dc78542e6c88..0394b786aa93 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2472,11 +2472,22 @@ _C_KW = {
     return 'obj'
 
 
-def print_alloc_wrapper(ri, direction):
+def print_alloc_wrapper(ri, direction, struct=None):
     name = op_prefix(ri, direction)
-    ri.cw.write_func_prot(f'static inline struct {name} *', f"{name}_alloc", [f"void"])
+    struct_name = name
+    if ri.type_name_conflict:
+        struct_name += '_'
+
+    arg = ["void"]
+    cnt = "1"
+    if struct and struct.in_multi_val:
+        arg = ["unsigned int n"]
+        cnt = "n"
+
+    ri.cw.write_func_prot(f'static inline struct {struct_name} *',
+                          f"{name}_alloc", arg)
     ri.cw.block_start()
-    ri.cw.p(f'return calloc(1, sizeof(struct {name}));')
+    ri.cw.p(f'return calloc({cnt}, sizeof(struct {struct_name}));')
     ri.cw.block_end()
 
 
@@ -2547,6 +2558,8 @@ _C_KW = {
     _print_type(ri, "", struct)
 
     if struct.request and struct.in_multi_val:
+        print_alloc_wrapper(ri, "", struct)
+        ri.cw.nl()
         free_rsp_nested_prototype(ri)
         ri.cw.nl()
 
-- 
2.50.1


