Return-Path: <netdev+bounces-30517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72221787A50
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019E0281694
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D748BEB;
	Thu, 24 Aug 2023 21:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832837F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 21:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F82C433C8;
	Thu, 24 Aug 2023 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692912275;
	bh=H02t7eTLHymxc1CnzGXi2J2hvdzRXQhKbhtk4zwunYg=;
	h=From:To:Cc:Subject:Date:From;
	b=jp3Nwe29pvX+XfOwFtAhI/wht3pXne6M56aZPifHVeWJqbCkVmoZq9d3nWc178Oux
	 5swkCiN2Wa//4e7lZfo4mUdAioE4ulGGzHDxAiKoX86V9wq+1QKrVy59xZVfeJeTDr
	 xwhf0opXivB+kWcqhTX3Wi8vHW9REo4Mv9NsA1+DTAKtGR8/NdtGjw6KxohVUjLKYR
	 J+f6Rpaf0rh4/cGLESBNTfacpwAhYiE6Ldpm66YpMBwstTpbigYz0gITmF2x8PImID
	 UE975dZOWITYSP1o/9ykkr9h0ZPM3hVCqEfJpfkqi7OIOEhzJWUR+sxrv1eZ9ZZX1z
	 Vs0wHMNLhe0HA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl-gen: fix uAPI generation after tempfile changes
Date: Thu, 24 Aug 2023 14:24:31 -0700
Message-ID: <20230824212431.1683612-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use a tempfile for code generation, to avoid wiping the target
file out if the code generator crashes. File contents are copied
from tempfile to actual destination at the end of main().

uAPI generation is relatively simple so when generating the uAPI
header we return from main() early, and never reach the "copy code
over" stage. Since commit under Fixes uAPI headers are not updated
by ynl-gen.

Move the copy/commit of the code into CodeWriter, to make it
easier to call at any point in time. Hook it into the destructor
to make sure we don't miss calling it.

Fixes: f65f305ae008 ("tools: ynl-gen: use temporary file for rendering")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 tools/net/ynl/ynl-gen-c.py | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 9209bdcca9c6..897af958cee8 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1045,14 +1045,30 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 
 class CodeWriter:
-    def __init__(self, nlib, out_file):
+    def __init__(self, nlib, out_file=None):
         self.nlib = nlib
 
         self._nl = False
         self._block_end = False
         self._silent_block = False
         self._ind = 0
-        self._out = out_file
+        if out_file is None:
+            self._out = os.sys.stdout
+        else:
+            self._out = tempfile.TemporaryFile('w+')
+            self._out_file = out_file
+
+    def __del__(self):
+        self.close_out_file()
+
+    def close_out_file(self):
+        if self._out == os.sys.stdout:
+            return
+        with open(self._out_file, 'w+') as out_file:
+            self._out.seek(0)
+            shutil.copyfileobj(self._out, out_file)
+            self._out.close()
+        self._out = os.sys.stdout
 
     @classmethod
     def _is_cond(cls, line):
@@ -2313,11 +2329,9 @@ _C_KW = {
     parser.add_argument('--source', dest='header', action='store_false')
     parser.add_argument('--user-header', nargs='+', default=[])
     parser.add_argument('--exclude-op', action='append', default=[])
-    parser.add_argument('-o', dest='out_file', type=str)
+    parser.add_argument('-o', dest='out_file', type=str, default=None)
     args = parser.parse_args()
 
-    tmp_file = tempfile.TemporaryFile('w+') if args.out_file else os.sys.stdout
-
     if args.header is None:
         parser.error("--header or --source is required")
 
@@ -2341,7 +2355,7 @@ _C_KW = {
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
         os.sys.exit(1)
 
-    cw = CodeWriter(BaseNlLib(), tmp_file)
+    cw = CodeWriter(BaseNlLib(), args.out_file)
 
     _, spec_kernel = find_kernel_root(args.spec)
     if args.mode == 'uapi' or args.header:
@@ -2590,10 +2604,6 @@ _C_KW = {
     if args.header:
         cw.p(f'#endif /* {hdr_prot} */')
 
-    if args.out_file:
-        out_file = open(args.out_file, 'w+')
-        tmp_file.seek(0)
-        shutil.copyfileobj(tmp_file, out_file)
 
 if __name__ == "__main__":
     main()
-- 
2.41.0


