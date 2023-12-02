Return-Path: <netdev+bounces-53291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E62801E91
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 22:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118451C2074A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7922136E;
	Sat,  2 Dec 2023 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaX0S6zb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14B2136C
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 21:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B610FC433C8;
	Sat,  2 Dec 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701551418;
	bh=m7zllL0sw2cSJ/qHuur+MvTFKgxeOq26yQhHnyAUmzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oaX0S6zbV518VColxvbnuI5Dbt+cBk+bobapqoYLd5jjLXAkbJ9umKokO7b7rIU1K
	 o5xFui9RSSkkh9FvbwX0dTJ92W7vAYTpb3p5Efg3pHtBJRK7BnDvDs7frytzD6XW4I
	 iqqPesGdXubJ5TcFTCpcN0lIzc89kzgfCysrIh1exGS8c6NGsKFUMqrNpA4jHUd1Uv
	 p4BEqvG6t0Y7pJe3P8fX2bmmdQuVcXklXD5vH5QKcOx6G0UzDu23GuJKH1PMvDCiO2
	 9ORihIE87JaAr3km9qm3uaoF137pX6EbDSydoarSe0TEDxBoiIw3sYekxpQKqqWUrG
	 uVHcgY+PUGztQ==
From: Jakub Kicinski <kuba@kernel.org>
To: dev@web.codeaurora.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tools: pynl: make flags argument optional for do()
Date: Sat,  2 Dec 2023 13:10:05 -0800
Message-ID: <20231202211005.341613-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1768d8a767f8 ("tools/net/ynl: Add support for create flags")
added support for setting legacy netlink CRUD flags on netlink
messages (NLM_F_REPLACE, _EXCL, _CREATE etc.).

Most of genetlink won't need these, don't force callers to pass
in an empty argument to each do() call.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/lib/ynl.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92995bca14e1..c56dad9593c6 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -705,7 +705,7 @@ genl_family_name_to_id = None
 
       return op['do']['request']['attributes'].copy()
 
-    def _op(self, method, vals, flags, dump=False):
+    def _op(self, method, vals, flags=None, dump=False):
         op = self.ops[method]
 
         nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
@@ -769,7 +769,7 @@ genl_family_name_to_id = None
             return rsp[0]
         return rsp
 
-    def do(self, method, vals, flags):
+    def do(self, method, vals, flags=None):
         return self._op(method, vals, flags)
 
     def dump(self, method, vals):
-- 
2.43.0


