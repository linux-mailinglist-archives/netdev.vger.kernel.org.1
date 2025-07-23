Return-Path: <netdev+bounces-209413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D4B0F8AF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22F31C86C22
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34321771C;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWrV64Ax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5321504E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290661; cv=none; b=IgRS16hN452Q/47EOnXXy8skaY3Zet7v+7f0LTMl0PjvkPR8Oo8CEolFZwFeGsqfOKNoNN70Qn6DafQz5t8uavGz9BKl2xyy1YpnYgWdFVz4h/gU2rtSaooR4YcP5eu4bWPnPJMhsRKEHS38BpA+eZpmcjGJjScUR1RPBMSvNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290661; c=relaxed/simple;
	bh=VdRYZfEVnJp3Fr+miV2hCkTKkZHFrIVwh4yZ8YxuOn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv1V13LqJCmjKZgu21xWQQERCgQZk7US4ZjnUk2nJLdDkNVAbYL6cBjIadXJmZzEDwepqiE2Yh12DvT+FMJf6h2qbHR0LfhYQAtoK2MsaG0MAV6zfOQdO8nWUH8azt94wfC8pmOz/OzeyBzSWsCYQeLZ1yC8Lao6pYWk4zLtQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWrV64Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101A5C4CEE7;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290661;
	bh=VdRYZfEVnJp3Fr+miV2hCkTKkZHFrIVwh4yZ8YxuOn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWrV64Ax0QwCVAmaT2/yfykV8E6Rsc+Ej5O7OpsE8YjNIRJGU/MI8obKzgF9XefmT
	 oipZ+ic2C/fnqMM27Tdr+n9tiiZ4NuU5Nw8teef1bIPIT7M5NgjytSwb9tA+RZc3W3
	 M8GwuiWzeBLMNe5T+0NOxl1GZtj7xyPN9zKGJD3b1+9inFbiYdQ5hfcNws8rmSSqlr
	 KVB2vS30si5WsrVklKKTpQa/EszUzb0YJS0PGgNyBMuyl/7aYFOeh1tFUQGX0SiRQI
	 tH9qall0Yyy8SkLg83ML/5G9EnlJBX91fLn/mkeChSgvoJDo+KOhaLE5ltrj4EYlV+
	 tdWDYngNEHJQw==
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
Subject: [PATCH net-next v2 3/5] tools: ynl-gen: print alloc helper for multi-val attrs
Date: Wed, 23 Jul 2025 10:10:44 -0700
Message-ID: <20250723171046.4027470-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723171046.4027470-1-kuba@kernel.org>
References: <20250723171046.4027470-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - naming - arg vs args vs [arg], args seems most prevalent
v1: https://lore.kernel.org/m2ldof9sxs.fsf@gmail.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index dc78542e6c88..6bc0782f2658 100755
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
+    args = ["void"]
+    cnt = "1"
+    if struct and struct.in_multi_val:
+        args = ["unsigned int n"]
+        cnt = "n"
+
+    ri.cw.write_func_prot(f'static inline struct {struct_name} *',
+                          f"{name}_alloc", args)
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


