Return-Path: <netdev+bounces-38596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFE7BB9CA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D688D1C209B1
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B523768;
	Fri,  6 Oct 2023 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6VCxuv+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720C210FB
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 13:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CAFC433C7;
	Fri,  6 Oct 2023 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696600235;
	bh=F4RFWOeLeMbo09N7t0OYwtjAh8trSnsqnD28ETHMUuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=a6VCxuv+twmTkXsGkfmuqj0UBZrKNmEOet4IlydWVemq2P9PFQdFnQQ+rR5wt+Hs+
	 Z9JzVBpdpUk+s41z6hJtT4JNDYAj/efFd50DynKcDqbf5E0ChwE0FNA3I282EdipQw
	 P0uozKoGXdgfWYEIUESDR918l7rk/5Rg3QPlidrsZFHm2wpnYG2XAPeqKly37EGB6S
	 +gsBtb1FtmZtkOIaKX35DXNPwrXobmljRqRATO+EBI9R3en1yrga306xce61uEub6X
	 6YNE17uKGrgtneHQt566tgvDnZxWHar5wBtcYQUXLLp1WVBuh+pRN10vlbNiYpWQ1A
	 Ey2Ka2LBrL98A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH net-next] tools: ynl-gen: handle do ops with no input attrs
Date: Fri,  6 Oct 2023 06:50:32 -0700
Message-ID: <20231006135032.3328523-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code supports dumps with no input attributes currently
thru a combination of special-casing and luck.
Clean up the handling of ops with no inputs. Create empty
Structs, and skip printing of empty types.
This makes dos with no inputs work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Hi Lorenzo, the StructNone from my initial patch felt a little
too hacky, so I ditched it :) Could you double check that this
works the same as the previous version?
---
 tools/net/ynl/ynl-gen-c.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 168fe612b029..f125b5f704ba 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1041,9 +1041,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if op_mode == 'notify':
             op_mode = 'do'
         for op_dir in ['request', 'reply']:
-            if op and op_dir in op[op_mode]:
-                self.struct[op_dir] = Struct(family, self.attr_set,
-                                             type_list=op[op_mode][op_dir]['attributes'])
+            if op:
+                type_list = []
+                if op_dir in op[op_mode]:
+                    type_list = op[op_mode][op_dir]['attributes']
+                self.struct[op_dir] = Struct(family, self.attr_set, type_list=type_list)
         if op_mode == 'event':
             self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
 
@@ -1752,6 +1754,8 @@ _C_KW = {
 
 
 def print_req_type_helpers(ri):
+    if len(ri.struct["request"].attr_list) == 0:
+        return
     print_alloc_wrapper(ri, "request")
     print_type_helpers(ri, "request")
 
@@ -1773,6 +1777,8 @@ _C_KW = {
 
 
 def print_req_type(ri):
+    if len(ri.struct["request"].attr_list) == 0:
+        return
     print_type(ri, "request")
 
 
@@ -2515,9 +2521,8 @@ _C_KW = {
                 if 'dump' in op:
                     cw.p(f"/* {op.enum_name} - dump */")
                     ri = RenderInfo(cw, parsed, args.mode, op, 'dump')
-                    if 'request' in op['dump']:
-                        print_req_type(ri)
-                        print_req_type_helpers(ri)
+                    print_req_type(ri)
+                    print_req_type_helpers(ri)
                     if not ri.type_consistent:
                         print_rsp_type(ri)
                     print_wrapped_type(ri)
-- 
2.41.0


