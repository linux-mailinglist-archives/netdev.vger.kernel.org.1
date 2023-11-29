Return-Path: <netdev+bounces-52254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E807FE05C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217FB1C20ACC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51B5EE83;
	Wed, 29 Nov 2023 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtjQPGfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174F5EE80
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 19:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD194C433AB;
	Wed, 29 Nov 2023 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286588;
	bh=gpgiAHn1DJy7po5SVSiv2Qo1ibeCjtlzbdlZt3uvnUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtjQPGfSIsFcL6eGuWXTnR7TdG2CWEcUaLAj4Qr5xkTz0TnYCY8tT2QZXp0BkJwX1
	 ELpJxzCA4jTqr9kFQ6/OK24AOl261ewsdw0Gb5SaXTORVlbucdx9T8AKmI4g1SR0DQ
	 OayF8ERoEyvnfDR6UWC0H7/oE7JiYc0DZhB4cjF2apBupb61zHQTigqgcu3wEYXctS
	 02/aiGAv4foibBj/sSRE8cwAWyUyZOYECIKJG97SHaxKc5jpuGJZs4GotKGYuLr8uO
	 S3WYHMvWqgINGvjQjgCNe891anrAqq7FU/4fEd0sHRTEWiZBSZhz52bZPMQXYWPJ1s
	 jiQ4AXc4rEsVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@google.com
Subject: [PATCH net-next 4/4] tools: ynl: don't skip regeneration from make targets
Date: Wed, 29 Nov 2023 11:36:22 -0800
Message-ID: <20231129193622.2912353-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
References: <20231129193622.2912353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2b7ac0c87d98 ("tools: ynl-gen: don't touch the output file if
content is the same") is working too well. It was added so that
ynl-regen -f doesn't make us rebuild half of the kernel, if there
are no actual changes in any generated code.

When ynl-gen-c is called by make, however, we're better off trusting
make's tracking and overwrite the file. Otherwise if output is identical
we won't update file timestamps and make will retry code gen on every
invocation.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@google.com
---
 tools/net/ynl/ynl-gen-c.py | 12 ++++++++----
 tools/net/ynl/ynl-regen.sh |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index cbbda276f6d1..ba1c3611c6fa 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1164,8 +1164,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 
 class CodeWriter:
-    def __init__(self, nlib, out_file=None):
+    def __init__(self, nlib, out_file=None, overwrite=True):
         self.nlib = nlib
+        self._overwrite = overwrite
 
         self._nl = False
         self._block_end = False
@@ -1186,8 +1187,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             return
         # Avoid modifying the file if contents didn't change
         self._out.flush()
-        if os.path.isfile(self._out_file) and filecmp.cmp(self._out.name, self._out_file, shallow=False):
-            return
+        if not self._overwrite and os.path.isfile(self._out_file):
+            if filecmp.cmp(self._out.name, self._out_file, shallow=False):
+                return
         with open(self._out_file, 'w+') as out_file:
             self._out.seek(0)
             shutil.copyfileobj(self._out, out_file)
@@ -2516,6 +2518,8 @@ _C_KW = {
     parser.add_argument('--header', dest='header', action='store_true', default=None)
     parser.add_argument('--source', dest='header', action='store_false')
     parser.add_argument('--user-header', nargs='+', default=[])
+    parser.add_argument('--cmp-out', action='store_true', default=None,
+                        help='Do not overwrite the output file if the new output is identical to the old')
     parser.add_argument('--exclude-op', action='append', default=[])
     parser.add_argument('-o', dest='out_file', type=str, default=None)
     args = parser.parse_args()
@@ -2543,7 +2547,7 @@ _C_KW = {
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
         os.sys.exit(1)
 
-    cw = CodeWriter(BaseNlLib(), args.out_file)
+    cw = CodeWriter(BaseNlLib(), args.out_file, overwrite=(not args.cmp_out))
 
     _, spec_kernel = find_kernel_root(args.spec)
     if args.mode == 'uapi' or args.header:
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index bdba24066cf1..a37304dcc88e 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -30,8 +30,8 @@ for f in $files; do
     fi
 
     echo -e "\tGEN ${params[2]}\t$f"
-    $TOOL --mode ${params[2]} --${params[3]} --spec $KDIR/${params[0]} \
-	  $args -o $f
+    $TOOL --cmp-out --mode ${params[2]} --${params[3]} \
+	  --spec $KDIR/${params[0]} $args -o $f
 done
 
 popd >>/dev/null
-- 
2.43.0


