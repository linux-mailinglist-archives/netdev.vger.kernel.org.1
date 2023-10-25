Return-Path: <netdev+bounces-44211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9367D71A4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367041C20C55
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928A2E656;
	Wed, 25 Oct 2023 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvigF7xP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74C26E3C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE9C433C8;
	Wed, 25 Oct 2023 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698250976;
	bh=0HXWW+/bzfd0m4nuGk3Rkz9/ToswSDujSboXrysLScE=;
	h=From:To:Cc:Subject:Date:From;
	b=VvigF7xP/ngXIvKDKJcJez4kUo3FMdAvVN9odwTsIlsbx5ddtyUierLPKvHTttRXn
	 QYF85MdM2a979LZAKhjQeOouuhtdWJwfTlIGt2swqo6Yj086DcLKKDi9H04VcoNCl2
	 jomBbbLvnZjgLlnm+aVsNv3RyOI7OEVeCOHRgYUA8NOd3DGaiv9293yBtv9/NPh5KT
	 PvFEK/WCjQp3oDgH2CylNVMjIx7iOFoP6dgIbM6/oqnKhpCJ8Vsg5gyacOnm13vlZN
	 QsO9CO2cdXvz0UazrVDlX4NJtX+gUs2rfzt9Bc2y4oiyVkV5amKhDn4NN2pkyOdPh7
	 meBxPLrHfQmyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] netlink: specs: support conditional operations
Date: Wed, 25 Oct 2023 09:22:53 -0700
Message-ID: <20231025162253.133159-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page pool code is compiled conditionally, but the operations
are part of the shared netlink family. We can handle this
by reporting empty list of pools or -EOPNOTSUPP / -ENOSYS
but the cleanest way seems to be removing the ops completely
at compilation time. That way user can see that the page
pool ops are not present using genetlink introspection.
Same way they'd check if the kernel is "new enough" to
support the ops.

Extend the specs with the ability to specify the config
condition under which op (and its policies, etc.) should
be hidden.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      |  5 +++++
 Documentation/netlink/genetlink-legacy.yaml |  5 +++++
 Documentation/netlink/genetlink.yaml        |  5 +++++
 tools/net/ynl/ynl-gen-c.py                  | 22 +++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 7ef2496d57c8..9d13bbb7ae47 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -295,6 +295,11 @@ additionalProperties: False
               type: array
               items:
                 enum: [ strict, dump, dump-strict ]
+            config-cond:
+              description: |
+                Name of the kernel config option gating the presence of
+                the operation, without the 'CONFIG_' prefix.
+              type: string
             do: &subop-type
               description: Main command handler.
               type: object
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index cd5ebe39b52c..0daf40402a29 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -346,6 +346,11 @@ additionalProperties: False
               type: array
               items:
                 enum: [ strict, dump, dump-strict ]
+            config-cond:
+              description: |
+                Name of the kernel config option gating the presence of
+                the operation, without the 'CONFIG_' prefix.
+              type: string
             # Start genetlink-legacy
             fixed-header: *fixed-header
             # End genetlink-legacy
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 501ed2e6c8ef..3283bf458ff1 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -264,6 +264,11 @@ additionalProperties: False
               type: array
               items:
                 enum: [ strict, dump, dump-strict ]
+            config-cond:
+              description: |
+                Name of the kernel config option gating the presence of
+                the operation, without the 'CONFIG_' prefix.
+              type: string
             do: &subop-type
               description: Main command handler.
               type: object
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 0fee68863db4..6eb32b2ef848 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1162,6 +1162,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self._block_end = False
         self._silent_block = False
         self._ind = 0
+        self._ifdef_block = None
         if out_file is None:
             self._out = os.sys.stdout
         else:
@@ -1202,6 +1203,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if self._silent_block:
             ind += 1
         self._silent_block = line.endswith(')') and CodeWriter._is_cond(line)
+        if line[0] == '#':
+            ind = 0
         if add_ind:
             ind += add_ind
         self._out.write('\t' * ind + line + '\n')
@@ -1328,6 +1331,19 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             line += '= ' + str(one[1]) + ','
             self.p(line)
 
+    def ifdef_block(self, config):
+        config_option = None
+        if config:
+            config_option = 'CONFIG_' + c_upper(config)
+        if self._ifdef_block == config_option:
+            return
+
+        if self._ifdef_block:
+            self.p('#endif /* ' + self._ifdef_block + ' */')
+        if config_option:
+            self.p('#ifdef ' + config_option)
+        self._ifdef_block = config_option
+
 
 scalars = {'u8', 'u16', 'u32', 'u64', 's32', 's64', 'uint', 'sint'}
 
@@ -2006,10 +2022,13 @@ _C_KW = {
 
 
 def print_req_policy(cw, struct, ri=None):
+    if ri and ri.op:
+        cw.ifdef_block(ri.op.get('config-cond', None))
     print_req_policy_fwd(cw, struct, ri=ri, terminate=False)
     for _, arg in struct.member_list():
         arg.attr_policy(cw)
     cw.p("};")
+    cw.ifdef_block(None)
     cw.nl()
 
 
@@ -2127,6 +2146,7 @@ _C_KW = {
             if op.is_async:
                 continue
 
+            cw.ifdef_block(op.get('config-cond', None))
             cw.block_start()
             members = [('cmd', op.enum_name)]
             if 'dont-validate' in op:
@@ -2157,6 +2177,7 @@ _C_KW = {
                 if op.is_async or op_mode not in op:
                     continue
 
+                cw.ifdef_block(op.get('config-cond', None))
                 cw.block_start()
                 members = [('cmd', op.enum_name)]
                 if 'dont-validate' in op:
@@ -2192,6 +2213,7 @@ _C_KW = {
                 members.append(('flags', ' | '.join([c_upper('genl-' + x) for x in flags])))
                 cw.write_struct_init(members)
                 cw.block_end(line=',')
+    cw.ifdef_block(None)
 
     cw.block_end(line=';')
     cw.nl()
-- 
2.41.0


