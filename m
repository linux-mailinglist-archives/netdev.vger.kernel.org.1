Return-Path: <netdev+bounces-42311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173387CE2FB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F2B281C6A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968D3C07E;
	Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzOl7iKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE236AE1
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F0C433CA;
	Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697647162;
	bh=hHZqQfu0LcOsMyK+2xuUZImnS4VYZwlSqpPcgVTw5mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzOl7iKKZWlz4XU5Gd94RNyfSLhAKC9pp8sovfV8kjj10NPwVMjlsccyFCusip0TP
	 GeuX2j9q2Q3eUickcYfQj8unRCKSUd7X7d7SZSU7zcqLEjB2pcJg62XxWCcbBUtLWI
	 RF6DKYWahUMtlm8pDSXtmjGFFotFWw7OlYQ36EOora/N8n4xWZ4Bep4phqU7cmnMRw
	 pRMlajjVAIPM5waKtzJKCb/Sh6L4Ien4OaHeCly2sdMIwCvJbXLkNrDU9GCHxizspI
	 6DBf4o8ZfggRFAlbDxWx4Z0NofTnooirclBg6rizzHlpXKaDFyndBdfGvWfeCtNHJe
	 0mSrHn+NUzIzw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dcaratti@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tools: ynl-gen: track attribute use
Date: Wed, 18 Oct 2023 09:39:15 -0700
Message-ID: <20231018163917.2514503-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163917.2514503-1-kuba@kernel.org>
References: <20231018163917.2514503-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For range validation we'll need to know if any individual
attribute is used on input (i.e. whether we will generate
a policy for it). Track this information.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index f125b5f704ba..7f4ad4014d17 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -42,6 +42,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.type = attr['type']
         self.checks = attr.get('checks', {})
 
+        self.request = False
+        self.reply = False
+
         if 'len' in attr:
             self.len = attr['len']
         if 'nested-attributes' in attr:
@@ -846,6 +849,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self._load_root_sets()
         self._load_nested_sets()
+        self._load_attr_use()
         self._load_hooks()
 
         self.kernel_policy = self.yaml.get('kernel-policy', 'split')
@@ -966,6 +970,22 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                         child.request |= struct.request
                         child.reply |= struct.reply
 
+    def _load_attr_use(self):
+        for _, struct in self.pure_nested_structs.items():
+            if struct.request:
+                for _, arg in struct.member_list():
+                    arg.request = True
+            if struct.reply:
+                for _, arg in struct.member_list():
+                    arg.reply = True
+
+        for root_set, rs_members in self.root_sets.items():
+            for attr, spec in self.attr_sets[root_set].items():
+                if attr in rs_members['request']:
+                    spec.request = True
+                if attr in rs_members['reply']:
+                    spec.reply = True
+
     def _load_global_policy(self):
         global_set = set()
         attr_set_name = None
-- 
2.41.0


