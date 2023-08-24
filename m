Return-Path: <netdev+bounces-30169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C5786441
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511411C20CF5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB120F0A;
	Thu, 24 Aug 2023 00:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009F185E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7378EC433CB;
	Thu, 24 Aug 2023 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837065;
	bh=nIeGE9Jvr7uNy02A80qLNxdt30YhD3cj4P3xipqN7dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4ciuTSyT4mywnOAVQT1NAC9LnX9cEGQc06omJ72F68IcRJYvXhGGw0Qa0/kUmljA
	 2R31fDlTrdK0iLmjA/prbEHCQAh5x5v6d7+9jwaSDU+TcxbsQShLVsV0QG+LxcS1O8
	 j+fYg79XFfb0621SzfW87ttM8EiVHjvm+xDMlKoP8b4zK2Bbi2Ra2WA7Akd8Y/KugP
	 W84nWjp5grHKVQzAr0mDuXrcS/zWPm2OHsSFWu2x8S3mn/j9efcie0pS7u8j8wmp41
	 vBBW5RIol8SHQmgab5jHWtiayfMFtB2UEAmU4cv9qMvU5j8l2XqyD/HH6wO6V/IHIw
	 lUmCiFQz2+Fvw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] tools: ynl-gen: support empty attribute lists
Date: Wed, 23 Aug 2023 17:30:55 -0700
Message-ID: <20230824003056.1436637-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824003056.1436637-1-kuba@kernel.org>
References: <20230824003056.1436637-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differentiate between empty list and None for member lists.
New families may want to create request responses with no attribute.
If we treat those the same as None we end up rendering
a full parsing policy in user space, instead of an empty one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 13d06931c045..9209bdcca9c6 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -615,7 +615,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self.attr_list = []
         self.attrs = dict()
-        if type_list:
+        if type_list is not None:
             for t in type_list:
                 self.attr_list.append((t, self.attr_set[t]),)
         else:
@@ -1543,7 +1543,14 @@ _C_KW = {
 
     ri.cw.write_func_prot('int', f'{op_prefix(ri, "reply", deref=deref)}_parse', func_args)
 
-    _multi_parse(ri, ri.struct["reply"], init_lines, local_vars)
+    if ri.struct["reply"].member_list():
+        _multi_parse(ri, ri.struct["reply"], init_lines, local_vars)
+    else:
+        # Empty reply
+        ri.cw.block_start()
+        ri.cw.p('return MNL_CB_OK;')
+        ri.cw.block_end()
+        ri.cw.nl()
 
 
 def print_req(ri):
-- 
2.41.0


