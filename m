Return-Path: <netdev+bounces-30170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D9786442
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EB281408
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B020F14;
	Thu, 24 Aug 2023 00:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01F17E1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A7DC433CD;
	Thu, 24 Aug 2023 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837065;
	bh=sX2jxdvGohWc/s7qEPs/TLCqCMIx+jBGDYkzqEfDR5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nL75fbOl6+qMsbCyhHYe9xdcqP3yoa8j2Wy0dvaQY0exJ9/ZsQuAZp8+4LikBkFu1
	 CVdnFa7uGjcachb4MiPgIOvZ2jroz3hLsNwrzmXGO0l0ngjZZQQkiZJ3QHKQmsvdlu
	 rzbEWwuicR8CpjhnXsHW66xX7rzASS/YUu/1nWoeqYXG51HGQG+FlaIusfEkepHrWG
	 8LAymtXmDMnrVhQfgYjeRc42tBAxwhFJ2oudLajhemHjbvboKQOF/Sx4JrP8H+Cocf
	 dI1iO1PBXI1lmLnj2EZOFvwqWLSHFMoPQZFX+ZHCn3YtoZtdppdXY8fe9RtObernlE
	 FbpZlifx7vGYg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] tools: ynl-gen: fix collecting global policy attrs
Date: Wed, 23 Aug 2023 17:30:54 -0700
Message-ID: <20230824003056.1436637-4-kuba@kernel.org>
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

We look for attributes inside do.request, but there's another
layer of nesting in the spec, look inside do.request.attributes.

This bug had no effect as all global policies we generate (fou)
seem to be full, anyway, and we treat full and empty the same.

Next patch will change the treatment of empty policies.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index e27deb199a70..13d06931c045 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -978,7 +978,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
             for op_mode in ['do', 'dump']:
                 if op_mode in op:
-                    global_set.update(op[op_mode].get('request', []))
+                    req = op[op_mode].get('request')
+                    if req:
+                        global_set.update(req.get('attributes', []))
 
         self.global_policy = []
         self.global_policy_set = attr_set_name
-- 
2.41.0


