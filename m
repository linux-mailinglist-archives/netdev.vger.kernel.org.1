Return-Path: <netdev+bounces-78822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD9876B03
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D8E1F217AB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFB225D4;
	Fri,  8 Mar 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8+LGrQh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9498833
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924606; cv=none; b=eurRm9Y+SGXY/KGxsockYWQFXUHy1ztM30rkcY+gdX70Re42EkKNqGIPOhFn0V1xA/sVjK9sdeJxqoqNiOM/Y0L6b9Gp6+VBhaZ44uiwRK77L0AFYlvBU7Sf7hpR/9MvJGqHCImXAXdcS1zTO8Y7VfBMGNeNjmZ8LrBmJ/q5FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924606; c=relaxed/simple;
	bh=QY//B5H9t7Hopwq8QpRUnAlJOSmQI87jLNXcCC4HyTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7ci0LhDm2cQLD0ia8ixhSj99YbGCysm/ktDc9skIlSl7u6qTu+edZ/NSBn6M2tnVaip8PqfogSa+GqmxjRK1+gA8j4DXSL1M7QIJJVyntUKW/80pld9ntZuMSuxFbZwzOHKo2NU0qNHJFBFJy6lVAI1HgRSi5BQ2nQZQk2DzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8+LGrQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837CFC433F1;
	Fri,  8 Mar 2024 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709924605;
	bh=QY//B5H9t7Hopwq8QpRUnAlJOSmQI87jLNXcCC4HyTo=;
	h=From:To:Cc:Subject:Date:From;
	b=i8+LGrQhC/eIfUrAG/UCyFeGU7ZgMM+3bn/pQ13yPX5Fy5lFab1W49FzUpuK1JfJ3
	 yFUpO0VHzaSQC0tA1vFPd6p2c4WTcAZdzbE3XZrG5fPiEKUCuC+zMW+hNpcU/FkX9B
	 3rblVy3UA+MgggnfBq+fCSjJM8DtEIaSLknpVSyQIr0BxWrKtBZptfkOn9y2Qb4aNZ
	 T7I3vgnKAZiYKsdOtoXax0I7kn9g2A/wE73zNSnddiPJwETg96P0RF2ngVmoIa7NsR
	 VqeRh44SyJeTI5C28oohBpz21gtSsPP6WXrlZxv88jUaQ2dEvUaWI+qLi1WJlbT3p4
	 Rki8kvPJRemAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] netlink: specs: support generating code for genl socket priv
Date: Fri,  8 Mar 2024 11:03:19 -0800
Message-ID: <20240308190319.2523704-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The family struct is auto-generated for new families, support
use of the sock_priv_* mechanism added in commit a731132424ad
("genetlink: introduce per-sock family private storage").

For example if the family wants to use struct sk_buff as its
private struct (unrealistic but just for illustration), it would
add to its spec:

  kernel-family:
    headers: [ "linux/skbuff.h" ]
    sock-priv: struct sk_buff

ynl-gen-c will declare the appropriate priv size and hook
in function prototypes to be implemented by the family.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: almasrymina@google.com
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 Documentation/netlink/genetlink-c.yaml      | 19 +++++++++++++++++++
 Documentation/netlink/genetlink-legacy.yaml | 19 +++++++++++++++++++
 Documentation/netlink/genetlink.yaml        | 19 +++++++++++++++++++
 tools/net/ynl/lib/nlspec.py                 |  2 ++
 tools/net/ynl/ynl-gen-c.py                  | 10 ++++++++++
 5 files changed, 69 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..292068cc8a5a 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -370,3 +370,22 @@ additionalProperties: False
               type: string
             # End genetlink-c
             flags: *cmd_flags
+
+  kernel-family:
+    description: Additional global attributes used for kernel C code generation.
+    type: object
+    additionalProperties: False
+    properties:
+      headers:
+        description: |
+          List of extra headers which should be included in the source
+          of the generated code.
+        type: array
+        items:
+          type: string
+      sock-priv:
+        description: |
+          Literal name of the type which is used within the kernel
+          to store the socket state. The type / structure is internal
+          to the kernel, and is not defined in the spec.
+        type: string
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..b6de66e38bdb 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -431,3 +431,22 @@ additionalProperties: False
               type: string
             # End genetlink-c
             flags: *cmd_flags
+
+  kernel-family:
+    description: Additional global attributes used for kernel C code generation.
+    type: object
+    additionalProperties: False
+    properties:
+      headers:
+        description: |
+          List of extra headers which should be included in the source
+          of the generated code.
+        type: array
+        items:
+          type: string
+      sock-priv:
+        description: |
+          Literal name of the type which is used within the kernel
+          to store the socket state. The type / structure is internal
+          to the kernel, and is not defined in the spec.
+        type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3283bf458ff1..0512c771d737 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -328,3 +328,22 @@ additionalProperties: False
                 The name for the group, used to form the define and the value of the define.
               type: string
             flags: *cmd_flags
+
+  kernel-family:
+    description: Additional global attributes used for kernel C code generation.
+    type: object
+    additionalProperties: False
+    properties:
+      headers:
+        description: |
+          List of extra headers which should be included in the source
+          of the generated code.
+        type: array
+        items:
+          type: string
+      sock-priv:
+        description: |
+          Literal name of the type which is used within the kernel
+          to store the socket state. The type / structure is internal
+          to the kernel, and is not defined in the spec.
+        type: string
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index fbce52395b3b..6d08ab9e213f 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -418,6 +418,7 @@ jsonschema = None
         consts     dict of all constants/enums
         fixed_header  string, optional name of family default fixed header struct
         mcast_groups  dict of all multicast groups (index by name)
+        kernel_family   dict of kernel family attributes
     """
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
         with open(spec_path, "r") as stream:
@@ -461,6 +462,7 @@ jsonschema = None
         self.ntfs = collections.OrderedDict()
         self.consts = collections.OrderedDict()
         self.mcast_groups = collections.OrderedDict()
+        self.kernel_family = collections.OrderedDict(self.yaml.get('kernel-family', {}))
 
         last_exception = None
         while len(self._resolution_list) > 0:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2f5febfe66a1..d78dd005cdb9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2340,6 +2340,10 @@ _C_KW = {
 
     cw.p(f"extern struct genl_family {family.c_name}_nl_family;")
     cw.nl()
+    if 'sock-priv' in family.kernel_family:
+        cw.p(f'void {family.c_name}_nl_sock_priv_init({family.kernel_family["sock-priv"]} *priv);')
+        cw.p(f'void {family.c_name}_nl_sock_priv_destroy({family.kernel_family["sock-priv"]} *priv);')
+        cw.nl()
 
 
 def print_kernel_family_struct_src(family, cw):
@@ -2361,6 +2365,11 @@ _C_KW = {
     if family.mcgrps['list']:
         cw.p(f'.mcgrps\t\t= {family.c_name}_nl_mcgrps,')
         cw.p(f'.n_mcgrps\t= ARRAY_SIZE({family.c_name}_nl_mcgrps),')
+    if 'sock-priv' in family.kernel_family:
+        cw.p(f'.sock_priv_size\t= sizeof({family.kernel_family["sock-priv"]}),')
+        # Force cast here, actual helpers take pointer to the real type.
+        cw.p(f'.sock_priv_init\t= (void *){family.c_name}_nl_sock_priv_init,')
+        cw.p(f'.sock_priv_destroy = (void *){family.c_name}_nl_sock_priv_destroy,')
     cw.block_end(';')
 
 
@@ -2657,6 +2666,7 @@ _C_KW = {
                 cw.p(f'#include "{os.path.basename(args.out_file[:-2])}.h"')
             cw.nl()
         headers = ['uapi/' + parsed.uapi_header]
+        headers += parsed.kernel_family.get('headers', [])
     else:
         cw.p('#include <stdlib.h>')
         cw.p('#include <string.h>')
-- 
2.44.0


