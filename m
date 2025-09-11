Return-Path: <netdev+bounces-222293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDEFB53CDF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38935AA177E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730752765D9;
	Thu, 11 Sep 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="YhFg3m8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAC27281D;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621136; cv=none; b=nYI1WRnAKDzBUv8QvslpjMI8aTUBgfByJ9VMkAssN8p9riEgVHVMtTtgiHwgE/a367paHHKe1K2xjYvKNw9LTiEa7hF3EMIhM6gzG0ESlzLrvcijHlgriAwEE7QeaKBtQCrA2g4jzNA91KnzArME4+UgoF61VuaXe136xgJcQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621136; c=relaxed/simple;
	bh=BQC1Dyawkb1Zu4qHJO8XzZ7e0+gVs8UpteFavlIpea0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En6Xsbe4FkoZAk94Zgc+Cng2S2JuJ98xUuMTadLtXkhr7BPXW4hvIeVKFB08UmAeDEcXWEMe0P9imPqcKlTqskfPaEoX9IWjdTRI1fQacADBNeSicO5gKH9Jw3iiRYmrdcZpNY3RmywXmU0twOOEc7ljPXQS0LauXz83IfWBfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=YhFg3m8m; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=BQC1Dyawkb1Zu4qHJO8XzZ7e0+gVs8UpteFavlIpea0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhFg3m8mEc3vLKlbqULWgOnI9myrPsQ9F+e4kyCfm7ZfNE8b5R7Y5S7g9Jd+QQy1R
	 q2B/3Uz2mYplB8lWyeOnex7J/x8ChWA2QNLNXQMx736/02NVnedEwBI+ulWIr7tXVh
	 Pzz3W+ncc/Blwub/tffxUGx2XTNmRQwxpiF8j5F/mO7yUQEjKARxxJX0Q2mKcCKCH1
	 cbfc6mlycr73/j5YtHBYgD6AtG6Ebymq0udsInXTj0AXNRRd0fLezIE6LLE8aBC1O2
	 nT0KMhRGh3euayOfYFRc8vX9cqKiKkr5+7EeVRyVyHakhGab/noBuSr9CP8J96UmHu
	 lAtpesUcFaJfA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C4C3B60128;
	Thu, 11 Sep 2025 20:05:26 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0CC8C204AFE; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/13] tools: ynl-gen: add CodeWriter.p_lines() helper
Date: Thu, 11 Sep 2025 20:04:58 +0000
Message-ID: <20250911200508.79341-6-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
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
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index e4cb8c95632c..7a2e49a84735 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -180,8 +180,7 @@ class Type(SpecAttr):
 
     def free(self, ri, var, ref):
         lines = self._free_lines(ri, var, ref)
-        for line in lines:
-            ri.cw.p(line)
+        ri.cw.p_lines(lines)
 
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
@@ -267,13 +266,9 @@ class Type(SpecAttr):
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
 
@@ -1788,8 +1783,7 @@ class CodeWriter:
         self.block_start()
         self.write_func_lvar(local_vars=local_vars)
 
-        for line in body:
-            self.p(line)
+        self.p_lines(body)
         self.block_end()
 
     def writes_defines(self, defines):
@@ -1830,6 +1824,12 @@ class CodeWriter:
             self.p('#ifdef ' + config_option)
         self._ifdef_block = config_option
 
+    def p_lines(self, lines, nl_before=False):
+        if lines and nl_before:
+            self.nl()
+        for line in lines or []:
+            self.p(line)
+
 
 scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
 
@@ -2085,8 +2085,7 @@ def put_req_nested(ri, struct):
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
 
-    for line in init_lines:
-        ri.cw.p(line)
+    ri.cw.p_lines(init_lines)
 
     for _, arg in struct.member_list():
         arg.attr_put(ri, "obj")
@@ -2147,8 +2146,7 @@ def _multi_parse(ri, struct, init_lines, local_vars):
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
 
-    for line in init_lines:
-        ri.cw.p(line)
+    ri.cw.p_lines(init_lines)
     ri.cw.nl()
 
     for arg in struct.inherited:
@@ -2277,10 +2275,8 @@ def parse_rsp_submsg(ri, struct):
 
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


