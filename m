Return-Path: <netdev+bounces-221885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB6B52473
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE91C8289A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4C311C1F;
	Wed, 10 Sep 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="HltxTKhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8630FF36;
	Wed, 10 Sep 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545741; cv=none; b=DMvAOOJTqAmgJrk5eaQYSrPR7gE+9CQK2WWcIdMWhXoT0MJx2OukyLPdVkNrH9lcniG7vDNkZ2a5DkaaBlitayU6THEfUcFqBonheao7Nf88DXIrsY0wZ9Q7MefJL3TcD8pYObKCE6Ojtp4ayQQeaw+xS+oDL5KyzreWfUvxbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545741; c=relaxed/simple;
	bh=nmFUdln7rWayXOvm+tCjXRJq0z3FgFYUv+rQXSS1YKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvOtya7ANAo9ZyMnn5btkaVWMAKuWDd+0kudNgHAA1M+NK5ytYsGYcb9FjVAra6hsX+NEf/eNnVfHORrjLymqEh23T2J7CsNqH767R9QiSKvmt6vjBDVsKAalmZMp+M9Z0ZzGXU8MBmmaErd53XcPnD82mf3Uz3CK6Ae0YPfzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=HltxTKhi; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=nmFUdln7rWayXOvm+tCjXRJq0z3FgFYUv+rQXSS1YKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HltxTKhiOHnCSUfdLrTG0iql13BAsPaDviXRRjJeOvWgY0+fo21zV1lKcSz2gEXNL
	 L1FC5zrJ8EISxDPPjVrprNtiWuZaGH+2kl9PSTZt+vCj8QpgQiRX6QsVbRQ4iZA8KZ
	 g6uI2QCbYkiOI3atxij7Wnul56VLVU6cGkmxReUsofKV4jy+CeR2gMaKLPoLekwKkK
	 5Vl3ihDFfXTiE+Lc/bhpFBTLcgl2orys1DvV0XVlPDmCOEOJxywPjSV/5+7w2i6ZGX
	 KqFdn6b3y0ewBDHrc7XyDXsyhjGNLe6TNW0RO+TvLO5rAHp8hy+Pku72gThVtot2Ty
	 lzZIp2a/SfYSQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3DB566000C;
	Wed, 10 Sep 2025 23:08:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id F351E203A9B; Wed, 10 Sep 2025 23:08:42 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 05/12] tools: ynl-gen: add CodeWriter.p_lines() helper
Date: Wed, 10 Sep 2025 23:08:27 +0000
Message-ID: <20250910230841.384545-6-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910230841.384545-1-ast@fiberby.net>
References: <20250910230841.384545-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a helper for writing an array of lines, and convert
all the existing loops doing that, to use the new helper.

This is a trivial patch with no behavioural changes intended,
there are no changes to the generated code.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 6441d5a31391..18c6ed0044b9 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -181,8 +181,7 @@ class Type(SpecAttr):
 
     def free(self, ri, var, ref):
         lines = self._free_lines(ri, var, ref)
-        for line in lines:
-            ri.cw.p(line)
+        ri.cw.p_lines(lines)
 
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
@@ -268,13 +267,9 @@ class Type(SpecAttr):
             if self.presence_type() == 'present':
                 ri.cw.p(f"{var}->_present.{self.c_name} = 1;")
 
-        if init_lines:
-            ri.cw.nl()
-            for line in init_lines:
-                ri.cw.p(line)
+        ri.cw.p_lines(init_lines, nl_before=True)
 
-        for line in lines:
-            ri.cw.p(line)
+        ri.cw.p_lines(lines)
         ri.cw.block_end()
         return True
 
@@ -1789,8 +1784,7 @@ class CodeWriter:
         self.block_start()
         self.write_func_lvar(local_vars=local_vars)
 
-        for line in body:
-            self.p(line)
+        self.p_lines(body)
         self.block_end()
 
     def writes_defines(self, defines):
@@ -1831,6 +1825,12 @@ class CodeWriter:
             self.p('#ifdef ' + config_option)
         self._ifdef_block = config_option
 
+    def p_lines(self, lines, nl_before=False):
+        if lines and nl_before:
+            self.nl()
+        for line in lines or []:
+            self.p(line)
+
 
 scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
 
@@ -2088,8 +2088,7 @@ def put_req_nested(ri, struct):
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
 
-    for line in init_lines:
-        ri.cw.p(line)
+    ri.cw.p_lines(init_lines)
 
     for _, arg in struct.member_list():
         arg.attr_put(ri, "obj")
@@ -2150,8 +2149,7 @@ def _multi_parse(ri, struct, init_lines, local_vars):
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
 
-    for line in init_lines:
-        ri.cw.p(line)
+    ri.cw.p_lines(init_lines)
     ri.cw.nl()
 
     for arg in struct.inherited:
@@ -2280,10 +2278,8 @@ def parse_rsp_submsg(ri, struct):
 
         ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
         get_lines, init_lines, _ = arg._attr_get(ri, var)
-        for line in init_lines or []:
-            ri.cw.p(line)
-        for line in get_lines:
-            ri.cw.p(line)
+        ri.cw.p_lines(init_lines)
+        ri.cw.p_lines(get_lines)
         if arg.presence_type() == 'present':
             ri.cw.p(f"{var}->_present.{arg.c_name} = 1;")
         ri.cw.block_end()
-- 
2.51.0


