Return-Path: <netdev+bounces-57115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341B8122B3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044551C21454
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D077B27;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgs4+P8E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981277B24
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86342C433C7;
	Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509286;
	bh=pnrRVNX5R7tCkP00jAArpiubgJm4gxwD6foFlqmDjnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dgs4+P8EJITHowc+0o5IKgFh0skIhtiDExRCkvadZo8MF5GXXwFkx26+EiIt4GYTC
	 pBVEiNDMZ3yeXFfbd7fS3onK1833/QpnN0VpxYpuwc5r6eSde0YZVoDkz/7+9FCMhS
	 Dudb9pgQcuDeTlai5jNg3Pre7ezJ8CAbPPc8e9A0ItG/PqWVK73m22fH+hkuOtlz+6
	 qwpIEyJxmmCWgrIiKPxcE6rf3aInN+KRtzhvAcGkmtVikIOk9BZeEMZwraQrOQu2kZ
	 m9qSeWU6Ka37maMR18pPAkC47fk5uBHUr1oV05KV4oqNXwLMU/Azs3hG7utqtBa/57
	 Ws68XZOXZYZIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/8] tools: ynl-gen: record information about recursive nests
Date: Wed, 13 Dec 2023 15:14:29 -0800
Message-ID: <20231213231432.2944749-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213231432.2944749-1-kuba@kernel.org>
References: <20231213231432.2944749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track which nests are recursive. Non-recursive nesting gets
rendered in C as directly nested structs. For recursive
ones we need to put a pointer in, rather than full struct.

Track this information, no change to generated code, yet.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2b7961838fb6..8a2c304cd2ad 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -105,6 +105,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def is_scalar(self):
         return self.type in {'u8', 'u16', 'u32', 'u64', 's32', 's64'}
 
+    def is_recursive(self):
+        return False
+
     def presence_type(self):
         return 'bit'
 
@@ -529,6 +532,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 
 class TypeNest(Type):
+    def is_recursive(self):
+        return self.family.pure_nested_structs[self.nested_attrs].recursive
+
     def _complex_member_type(self, ri):
         return self.nested_struct_type
 
@@ -700,9 +706,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if self.nested and space_name in family.consts:
             self.struct_name += '_'
         self.ptr_name = self.struct_name + ' *'
+        # All attr sets this one contains, directly or multiple levels down
+        self.child_nests = set()
 
         self.request = False
         self.reply = False
+        self.recursive = False
 
         self.attr_list = []
         self.attrs = dict()
@@ -1059,14 +1068,20 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 pns_key_seen.add(name)
             else:
                 pns_key_list.append(name)
-        # Propagate the request / reply
+        # Propagate the request / reply / recursive
         for attr_set, struct in reversed(self.pure_nested_structs.items()):
             for _, spec in self.attr_sets[attr_set].items():
                 if 'nested-attributes' in spec:
-                    child = self.pure_nested_structs.get(spec['nested-attributes'])
+                    child_name = spec['nested-attributes']
+                    struct.child_nests.add(child_name)
+                    child = self.pure_nested_structs.get(child_name)
                     if child:
+                        if not child.recursive:
+                            struct.child_nests.update(child.child_nests)
                         child.request |= struct.request
                         child.reply |= struct.reply
+                if attr_set in struct.child_nests:
+                    struct.recursive = True
 
     def _load_attr_use(self):
         for _, struct in self.pure_nested_structs.items():
-- 
2.43.0


