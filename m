Return-Path: <netdev+bounces-57116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF68122B4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8771282904
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E977B33;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh0z0NQh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8177B2E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A2C433B9;
	Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509287;
	bh=+bi/fiqRNNhZum6quBLHzvwfDYp0KGd4uov++Rba+Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jh0z0NQhuafaF/2M6RBsoTfUs+ki9dhkqJFd4MVlSX2Wgj4YTV5dXyK8kMhA+OAK6
	 tjOn9GeroC2eij+AU/grTA4XDw1HGyOgWG42WrkGFJuR2SsZXHTcvvHSzs0s+1NQml
	 ORVYaFuvsVmpMjw6xZAtp2lbUGpnEk1wnfDmlx+y/YXkeysrK7Srdc4HmE6WsSJtmf
	 cFn+dr2ilyI07jZtvWBASr+kQt6sCIdQtB3ilB9EjCPBtnx+qRLwFkOeiJzYav8zvJ
	 qZ4GjC6c/3YO7TAR+Wo1komiffu+M3+6nN208e6exKPpZLIQhqbAnPt+ZTaseNIaAE
	 jVU91QzO9CjHA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/8] tools: ynl-gen: re-sort ignoring recursive nests
Date: Wed, 13 Dec 2023 15:14:30 -0800
Message-ID: <20231213231432.2944749-7-kuba@kernel.org>
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

We try to keep the structures and helpers "topologically sorted",
to avoid forward declarations. When recursive nests are at play
we need to sort twice, because structs which end up being marked
as recursive will get a full set of forward declarations, so we
should ignore them for the purpose of sorting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 52 +++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 8a2c304cd2ad..4ef3a774c402 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1008,6 +1008,33 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 self.root_sets[op['attribute-set']]['request'].update(req_attrs)
                 self.root_sets[op['attribute-set']]['reply'].update(rsp_attrs)
 
+    def _sort_pure_types(self):
+        # Try to reorder according to dependencies
+        pns_key_list = list(self.pure_nested_structs.keys())
+        pns_key_seen = set()
+        rounds = len(pns_key_list) ** 2  # it's basically bubble sort
+        for _ in range(rounds):
+            if len(pns_key_list) == 0:
+                break
+            name = pns_key_list.pop(0)
+            finished = True
+            for _, spec in self.attr_sets[name].items():
+                if 'nested-attributes' in spec:
+                    nested = spec['nested-attributes']
+                    # If the unknown nest we hit is recursive it's fine, it'll be a pointer
+                    if self.pure_nested_structs[nested].recursive:
+                        continue
+                    if nested not in pns_key_seen:
+                        # Dicts are sorted, this will make struct last
+                        struct = self.pure_nested_structs.pop(name)
+                        self.pure_nested_structs[name] = struct
+                        finished = False
+                        break
+            if finished:
+                pns_key_seen.add(name)
+            else:
+                pns_key_list.append(name)
+
     def _load_nested_sets(self):
         attr_set_queue = list(self.root_sets.keys())
         attr_set_seen = set(self.root_sets.keys())
@@ -1047,27 +1074,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                     if attr in rs_members['reply']:
                         self.pure_nested_structs[nested].reply = True
 
-        # Try to reorder according to dependencies
-        pns_key_list = list(self.pure_nested_structs.keys())
-        pns_key_seen = set()
-        rounds = len(pns_key_list)**2  # it's basically bubble sort
-        for _ in range(rounds):
-            if len(pns_key_list) == 0:
-                break
-            name = pns_key_list.pop(0)
-            finished = True
-            for _, spec in self.attr_sets[name].items():
-                if 'nested-attributes' in spec:
-                    if spec['nested-attributes'] not in pns_key_seen:
-                        # Dicts are sorted, this will make struct last
-                        struct = self.pure_nested_structs.pop(name)
-                        self.pure_nested_structs[name] = struct
-                        finished = False
-                        break
-            if finished:
-                pns_key_seen.add(name)
-            else:
-                pns_key_list.append(name)
+        self._sort_pure_types()
+
         # Propagate the request / reply / recursive
         for attr_set, struct in reversed(self.pure_nested_structs.items()):
             for _, spec in self.attr_sets[attr_set].items():
@@ -1083,6 +1091,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 if attr_set in struct.child_nests:
                     struct.recursive = True
 
+        self._sort_pure_types()
+
     def _load_attr_use(self):
         for _, struct in self.pure_nested_structs.items():
             if struct.request:
-- 
2.43.0


