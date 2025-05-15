Return-Path: <netdev+bounces-190880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF52AB92BF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06FE1B62B06
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8DE28D845;
	Thu, 15 May 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN+jDOyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EED28A708
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351027; cv=none; b=NEobs/04JvIt4fMWV1QoB33xLvEzXouPymeFtjWgV2qUKYMMXYUT7loJxgL838srJUTWeu716VHzn65zheDSlVZgRY9evRkI9R4qZdUUXtpb0vcesJ4D7Q8yhEaBhOeu1ge/BEzc2Kid+qvwuOU/gnK66o6FX/9HUKuK2fxfHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351027; c=relaxed/simple;
	bh=74Y8ypVz5NP6BD0bpLtLukz0TDH25kAWsBiQAp92lDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeWGLEYuYHVkjpne/ineGye/DuSdp8oq2NBSfzT3EIg+3ci6cdtCxJNr6nnJ3fqp9D8thsTzcURgDiAFtDHa+L18k99ly62dpme7DDH1j+fCKsDeTZnEVpj+XaoWdGoVo36/OrBgNDJqIgjdb4w1yeB74hmUV8kZSuoF/RdP22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN+jDOyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F080C4CEE7;
	Thu, 15 May 2025 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351027;
	bh=74Y8ypVz5NP6BD0bpLtLukz0TDH25kAWsBiQAp92lDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JN+jDOyoAibAuOaWbJ2DOV/79P7VdIk+yRI5bYi48ldD0lWHnqgkOwFy34YsrtA2M
	 oi27FQiH7HOekn+57ftiTlX1eTz2ITaVIk6JuYNBhCvQdgzOuZzupNC74aYgMdsRLW
	 pnkP4Tu/HuMCU383a1kb7RPSeFEctfBdUBPQeRBjnAuWfV1O9mLpXnIp0Kmgq3ixHF
	 9asFpKkJqLtC95ANCNLv1Vb2A/OsgAb9sopGcuthSetexcbVZoVykdjpy38kYiuZau
	 t+0jkHO6OBbaVnzxlAUMT8QGNlyI7TYyGV4p+SYAFU21N7AlMSrHfmHbfi3eG/ozwK
	 TlfQbkzN6v95g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/9] tools: ynl-gen: factor out the annotation of pure nested struct
Date: Thu, 15 May 2025 16:16:43 -0700
Message-ID: <20250515231650.1325372-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're about to add some code here for sub-messages.
Factor out the nest-related logic to make the code readable.
No functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9e143520e2f7..84140ce3a48d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1239,6 +1239,25 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             else:
                 pns_key_list.append(name)
 
+    def _load_nested_set_nest(self, spec):
+        inherit = set()
+        nested = spec['nested-attributes']
+        if nested not in self.root_sets:
+            if nested not in self.pure_nested_structs:
+                self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
+        else:
+            raise Exception(f'Using attr set as root and nested not supported - {nested}')
+
+        if 'type-value' in spec:
+            if nested in self.root_sets:
+                raise Exception("Inheriting members to a space used as root not supported")
+            inherit.update(set(spec['type-value']))
+        elif spec['type'] == 'indexed-array':
+            inherit.add('idx')
+        self.pure_nested_structs[nested].set_inherited(inherit)
+
+        return nested
+
     def _load_nested_sets(self):
         attr_set_queue = list(self.root_sets.keys())
         attr_set_seen = set(self.root_sets.keys())
@@ -1246,29 +1265,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         while len(attr_set_queue):
             a_set = attr_set_queue.pop(0)
             for attr, spec in self.attr_sets[a_set].items():
-                if 'nested-attributes' not in spec:
+                if 'nested-attributes' in spec:
+                    nested = self._load_nested_set_nest(spec)
+                else:
                     continue
 
-                nested = spec['nested-attributes']
                 if nested not in attr_set_seen:
                     attr_set_queue.append(nested)
                     attr_set_seen.add(nested)
 
-                inherit = set()
-                if nested not in self.root_sets:
-                    if nested not in self.pure_nested_structs:
-                        self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
-                else:
-                    raise Exception(f'Using attr set as root and nested not supported - {nested}')
-
-                if 'type-value' in spec:
-                    if nested in self.root_sets:
-                        raise Exception("Inheriting members to a space used as root not supported")
-                    inherit.update(set(spec['type-value']))
-                elif spec['type'] == 'indexed-array':
-                    inherit.add('idx')
-                self.pure_nested_structs[nested].set_inherited(inherit)
-
         for root_set, rs_members in self.root_sets.items():
             for attr, spec in self.attr_sets[root_set].items():
                 if 'nested-attributes' in spec:
-- 
2.49.0


