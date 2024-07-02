Return-Path: <netdev+bounces-108516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BBE9240E0
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994DD1C22407
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B61BA075;
	Tue,  2 Jul 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1UznOQH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B55515B0FE
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930602; cv=none; b=X0jAYmfdI4pTJdAQoxsc5cGsQBzrWpgZfc5oWZN8PgnLoettl5cV1Li/pV8izR9WyBsDSKxUXZUZvrlk8yssJ1L/5RV4KC+BHplpUnyTs7Ys7PhFqQz2+/Kbj3oYEwEC0/H94vSGe8JZMOfwaPSO2mr9RZFZLaEpQfVV38zapgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930602; c=relaxed/simple;
	bh=AksUKb3HV++Nbk4Q+Qpm5rXNKBYb9EoUW+ib/cR5SQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZmn9wIkpENz/QCw59Z95c4dSSdVq4pSRwaH9JuVURRfZaNpmxAgck6ZJcU1GHHssS2PyN+bUWd4Mt04FZtwjBnepmfr4DbVd42Tn0zfjecPluow7k0gnN87arM/GeIoIxUzz1xkwcvfEPJbvyn9gnan1EwUWrTOm8VMce6euzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1UznOQH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719930599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g8gIvg7Tcd9T+zmmSpo2Rip4McYLSwKIHuHAwqweqZE=;
	b=P1UznOQHMEUWY0Ne0KHaLldpL7VLRtv1zQPdVMHu2Zb2ElpC6tIEdLsjwebgGR4776Ata3
	wkBybJIr3k5OuIBK0+asqH3j6psGhviAMT2rpN6XCwABGlQEZHM4sMGiZdGcaBz3sy50tC
	9+RU/bfmDDTYqEEMzJ+Yvg92kKBBJts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-a3Lhk2QSMQ2KhJdNOY0W5Q-1; Tue,
 02 Jul 2024 10:29:57 -0400
X-MC-Unique: a3Lhk2QSMQ2KhJdNOY0W5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E2291944D38;
	Tue,  2 Jul 2024 14:29:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07F2D1944DD3;
	Tue,  2 Jul 2024 14:29:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next] tools: ynl: use ident name for Family, too.
Date: Tue,  2 Jul 2024 16:29:31 +0200
Message-ID: <9bbcab3094970b371bd47aa18481ae6ca5a93687.1719930479.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This allow consistent naming convention between Family and others
element's name.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/net/ynl/ynl-gen-c.py | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 374ca5e86e24..51529fabd517 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -59,9 +59,9 @@ class Type(SpecAttr):
         if 'nested-attributes' in attr:
             self.nested_attrs = attr['nested-attributes']
             if self.nested_attrs == family.name:
-                self.nested_render_name = c_lower(f"{family.name}")
+                self.nested_render_name = c_lower(f"{family.ident_name}")
             else:
-                self.nested_render_name = c_lower(f"{family.name}_{self.nested_attrs}")
+                self.nested_render_name = c_lower(f"{family.ident_name}_{self.nested_attrs}")
 
             if self.nested_attrs in self.family.consts:
                 self.nested_struct_type = 'struct ' + self.nested_render_name + '_'
@@ -693,9 +693,9 @@ class Struct:
 
         self.nested = type_list is None
         if family.name == c_lower(space_name):
-            self.render_name = c_lower(family.name)
+            self.render_name = c_lower(family.ident_name)
         else:
-            self.render_name = c_lower(family.name + '-' + space_name)
+            self.render_name = c_lower(family.ident_name + '-' + space_name)
         self.struct_name = 'struct ' + self.render_name
         if self.nested and space_name in family.consts:
             self.struct_name += '_'
@@ -761,7 +761,7 @@ class EnumEntry(SpecEnumEntry):
 
 class EnumSet(SpecEnumSet):
     def __init__(self, family, yaml):
-        self.render_name = c_lower(family.name + '-' + yaml['name'])
+        self.render_name = c_lower(family.ident_name + '-' + yaml['name'])
 
         if 'enum-name' in yaml:
             if yaml['enum-name']:
@@ -777,7 +777,7 @@ class EnumSet(SpecEnumSet):
         else:
             self.user_type = 'int'
 
-        self.value_pfx = yaml.get('name-prefix', f"{family.name}-{yaml['name']}-")
+        self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
 
         super().__init__(family, yaml)
 
@@ -802,9 +802,9 @@ class AttrSet(SpecAttrSet):
             if 'name-prefix' in yaml:
                 pfx = yaml['name-prefix']
             elif self.name == family.name:
-                pfx = family.name + '-a-'
+                pfx = family.ident_name + '-a-'
             else:
-                pfx = f"{family.name}-a-{self.name}-"
+                pfx = f"{family.ident_name}-a-{self.name}-"
             self.name_prefix = c_upper(pfx)
             self.max_name = c_upper(self.yaml.get('attr-max-name', f"{self.name_prefix}max"))
             self.cnt_name = c_upper(self.yaml.get('attr-cnt-name', f"__{self.name_prefix}max"))
@@ -861,7 +861,7 @@ class Operation(SpecOperation):
     def __init__(self, family, yaml, req_value, rsp_value):
         super().__init__(family, yaml, req_value, rsp_value)
 
-        self.render_name = c_lower(family.name + '_' + self.name)
+        self.render_name = c_lower(family.ident_name + '_' + self.name)
 
         self.dual_policy = ('do' in yaml and 'request' in yaml['do']) and \
                          ('dump' in yaml and 'request' in yaml['dump'])
@@ -911,11 +911,11 @@ class Family(SpecFamily):
         if 'uapi-header' in self.yaml:
             self.uapi_header = self.yaml['uapi-header']
         else:
-            self.uapi_header = f"linux/{self.name}.h"
+            self.uapi_header = f"linux/{self.ident_name}.h"
         if self.uapi_header.startswith("linux/") and self.uapi_header.endswith('.h'):
             self.uapi_header_name = self.uapi_header[6:-2]
         else:
-            self.uapi_header_name = self.name
+            self.uapi_header_name = self.ident_name
 
     def resolve(self):
         self.resolve_up(super())
@@ -923,7 +923,7 @@ class Family(SpecFamily):
         if self.yaml.get('protocol', 'genetlink') not in {'genetlink', 'genetlink-c', 'genetlink-legacy'}:
             raise Exception("Codegen only supported for genetlink")
 
-        self.c_name = c_lower(self.name)
+        self.c_name = c_lower(self.ident_name)
         if 'name-prefix' in self.yaml['operations']:
             self.op_prefix = c_upper(self.yaml['operations']['name-prefix'])
         else:
@@ -2173,7 +2173,7 @@ def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
     if not terminate or exported:
-        cw.p(f"/* Ops table for {family.name} */")
+        cw.p(f"/* Ops table for {family.ident_name} */")
 
         pol_to_struct = {'global': 'genl_small_ops',
                          'per-op': 'genl_ops',
@@ -2225,12 +2225,12 @@ def print_kernel_op_table_fwd(family, cw, terminate):
             continue
 
         if 'do' in op:
-            name = c_lower(f"{family.name}-nl-{op_name}-doit")
+            name = c_lower(f"{family.ident_name}-nl-{op_name}-doit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct genl_info *info'], suffix=';')
 
         if 'dump' in op:
-            name = c_lower(f"{family.name}-nl-{op_name}-dumpit")
+            name = c_lower(f"{family.ident_name}-nl-{op_name}-dumpit")
             cw.write_func_prot('int', name,
                                ['struct sk_buff *skb', 'struct netlink_callback *cb'], suffix=';')
     cw.nl()
@@ -2256,13 +2256,13 @@ def print_kernel_op_table(family, cw):
                                             for x in op['dont-validate']])), )
             for op_mode in ['do', 'dump']:
                 if op_mode in op:
-                    name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
+                    name = c_lower(f"{family.ident_name}-nl-{op_name}-{op_mode}it")
                     members.append((op_mode + 'it', name))
             if family.kernel_policy == 'per-op':
                 struct = Struct(family, op['attribute-set'],
                                 type_list=op['do']['request']['attributes'])
 
-                name = c_lower(f"{family.name}-{op_name}-nl-policy")
+                name = c_lower(f"{family.ident_name}-{op_name}-nl-policy")
                 members.append(('policy', name))
                 members.append(('maxattr', struct.attr_max_val.enum_name))
             if 'flags' in op:
@@ -2294,7 +2294,7 @@ def print_kernel_op_table(family, cw):
                         members.append(('validate',
                                         ' | '.join([c_upper('genl-dont-validate-' + x)
                                                     for x in dont_validate])), )
-                name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
+                name = c_lower(f"{family.ident_name}-nl-{op_name}-{op_mode}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
                 members.append((op_mode + 'it', name))
@@ -2305,9 +2305,9 @@ def print_kernel_op_table(family, cw):
                                     type_list=op[op_mode]['request']['attributes'])
 
                     if op.dual_policy:
-                        name = c_lower(f"{family.name}-{op_name}-{op_mode}-nl-policy")
+                        name = c_lower(f"{family.ident_name}-{op_name}-{op_mode}-nl-policy")
                     else:
-                        name = c_lower(f"{family.name}-{op_name}-nl-policy")
+                        name = c_lower(f"{family.ident_name}-{op_name}-nl-policy")
                     members.append(('policy', name))
                     members.append(('maxattr', struct.attr_max_val.enum_name))
                 flags = (op['flags'] if 'flags' in op else []) + ['cmd-cap-' + op_mode]
@@ -2326,7 +2326,7 @@ def print_kernel_mcgrp_hdr(family, cw):
 
     cw.block_start('enum')
     for grp in family.mcgrps['list']:
-        grp_id = c_upper(f"{family.name}-nlgrp-{grp['name']},")
+        grp_id = c_upper(f"{family.ident_name}-nlgrp-{grp['name']},")
         cw.p(grp_id)
     cw.block_end(';')
     cw.nl()
@@ -2339,7 +2339,7 @@ def print_kernel_mcgrp_src(family, cw):
     cw.block_start('static const struct genl_multicast_group ' + family.c_name + '_nl_mcgrps[] =')
     for grp in family.mcgrps['list']:
         name = grp['name']
-        grp_id = c_upper(f"{family.name}-nlgrp-{name}")
+        grp_id = c_upper(f"{family.ident_name}-nlgrp-{name}")
         cw.p('[' + grp_id + '] = { "' + name + '", },')
     cw.block_end(';')
     cw.nl()
@@ -2361,7 +2361,7 @@ def print_kernel_family_struct_src(family, cw):
     if not kernel_can_gen_family_struct(family):
         return
 
-    cw.block_start(f"struct genl_family {family.name}_nl_family __ro_after_init =")
+    cw.block_start(f"struct genl_family {family.ident_name}_nl_family __ro_after_init =")
     cw.p('.name\t\t= ' + family.fam_key + ',')
     cw.p('.version\t= ' + family.ver_key + ',')
     cw.p('.netnsok\t= true,')
@@ -2429,7 +2429,7 @@ def render_uapi(family, cw):
                 cw.p(' */')
 
             uapi_enum_start(family, cw, const, 'name')
-            name_pfx = const.get('name-prefix', f"{family.name}-{const['name']}-")
+            name_pfx = const.get('name-prefix', f"{family.ident_name}-{const['name']}-")
             for entry in enum.entries.values():
                 suffix = ','
                 if entry.value_change:
@@ -2451,7 +2451,7 @@ def render_uapi(family, cw):
             cw.nl()
         elif const['type'] == 'const':
             defines.append([c_upper(family.get('c-define-name',
-                                               f"{family.name}-{const['name']}")),
+                                               f"{family.ident_name}-{const['name']}")),
                             const['value']])
 
     if defines:
@@ -2529,7 +2529,7 @@ def render_uapi(family, cw):
     defines = []
     for grp in family.mcgrps['list']:
         name = grp['name']
-        defines.append([c_upper(grp.get('c-define-name', f"{family.name}-mcgrp-{name}")),
+        defines.append([c_upper(grp.get('c-define-name', f"{family.ident_name}-mcgrp-{name}")),
                         f'{name}'])
     cw.nl()
     if defines:
-- 
2.45.2


