Return-Path: <netdev+bounces-221895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7789B52484
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA04E1D6C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801EC32A816;
	Wed, 10 Sep 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LWCYqDZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313B317702;
	Wed, 10 Sep 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545746; cv=none; b=GpH21UpaDXIzm3OitsByZxmhZ3ycb7WTatnGFbvwxdvRuX4VPKPH7SLd2WfykPNnO/P2gPtLx6PdGI3pZqfFXxViLk2mpB48aRiU/jfNNvjZFInrqjpco2nITexkSvzvDLCrQLEZqHdYq7THoXtjqWE/+IIIcL0FNu1+CeRVox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545746; c=relaxed/simple;
	bh=9YMEML/2cAF/dYFs5UWYG9j95tdvfBp0b58/5bdDpPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQ0FqRth3KwQi2xQLekO55CV6HT9KsX7mQks2aZrYvsOGcI5NahQ4/Hbks2nNQaPILhx9aw19kSnYgR6Dpukh2x3kFm0/HqO7R5+5SORHM/+iJ7oy63FewjOjyoit0uwfoymhmcHSezLijkrM20MDjTdwxbh4U+17fQsHDOyFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LWCYqDZl; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545731;
	bh=9YMEML/2cAF/dYFs5UWYG9j95tdvfBp0b58/5bdDpPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWCYqDZlxeZ1RYVDqKTrcp2TOseJUtrLdk/brH+iTTmlvJkr4ivvSNGy7r5A/22hA
	 A6yJqVxBmaguVaHjY2LNXfpHkpawZWXUHes17bcT39zMU5Hl1VOcu6ourEVa7M8sxh
	 nlL6OaABOOsufOkY6xf8YzFJYzjBM88eW+EyUK821kAg/JqikFVRuQZoK1N1wdVxpS
	 LPb/Bm468DOCsu8Z4c3jwghh1gDXOXJVQIeAJQBEImss1OSt76vZ7xYFPsyDQgp9p2
	 FmY3SfVpqn4cLDYaOmvc2NdGMCX3IKlgGr0R6x8NiMokk1sQRojL9MDrizOWZpP91N
	 bH7aqG2Fe/bkQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 40FA360078;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 09DAD2044FF; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 06/12] tools: ynl-gen: deduplicate fixed_header handling
Date: Wed, 10 Sep 2025 23:08:28 +0000
Message-ID: <20250910230841.384545-7-ast@fiberby.net>
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

Fixed headers are handled nearly identical in print_dump(),
print_req() and put_req_nested(), generalize them and use a
common function to generate them.

This only causes cosmetic changes to tc_netem_attrs_put() in
tc-user.c.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 18c6ed0044b9..f149c68ae84e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1829,7 +1829,10 @@ class CodeWriter:
         if lines and nl_before:
             self.nl()
         for line in lines or []:
-            self.p(line)
+            if line == '':
+                self.nl()
+            else:
+                self.p(line)
 
 
 scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
@@ -1922,6 +1925,15 @@ def type_name(ri, direction, deref=False):
     return f"struct {op_prefix(ri, direction, deref=deref)}"
 
 
+def prepare_fixed_header(var, local_vars, init_lines):
+    local_vars += ['size_t hdr_len;',
+                   'void *hdr;']
+    init_lines += [f'hdr_len = sizeof({var}->_hdr);',
+                   'hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);',
+                   f'memcpy(hdr, &{var}->_hdr, hdr_len);',
+                   '']
+
+
 def print_prototype(ri, direction, terminate=True, doc=None):
     suffix = ';' if terminate else ''
 
@@ -2077,10 +2089,7 @@ def put_req_nested(ri, struct):
         local_vars.append('struct nlattr *nest;')
         init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
     if struct.fixed_header:
-        local_vars.append('void *hdr;')
-        struct_sz = f'sizeof({struct.fixed_header})'
-        init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
-        init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
+        prepare_fixed_header('obj', local_vars, init_lines)
 
     local_vars += put_local_vars(struct)
 
@@ -2349,6 +2358,7 @@ def print_req(ri):
     ret_ok = '0'
     ret_err = '-1'
     direction = "request"
+    init_lines = []
     local_vars = ['struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };',
                   'struct nlmsghdr *nlh;',
                   'int err;']
@@ -2359,8 +2369,7 @@ def print_req(ri):
         local_vars += [f'{type_name(ri, rdir(direction))} *rsp;']
 
     if ri.struct["request"].fixed_header:
-        local_vars += ['size_t hdr_len;',
-                       'void *hdr;']
+        prepare_fixed_header('req', local_vars, init_lines)
 
     local_vars += put_local_vars(ri.struct["request"])
 
@@ -2379,11 +2388,7 @@ def print_req(ri):
         ri.cw.p(f"yrs.yarg.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
     ri.cw.nl()
 
-    if ri.struct['request'].fixed_header:
-        ri.cw.p("hdr_len = sizeof(req->_hdr);")
-        ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
-        ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
-        ri.cw.nl()
+    ri.cw.p_lines(init_lines)
 
     for _, attr in ri.struct["request"].member_list():
         attr.attr_put(ri, "req")
@@ -2421,13 +2426,13 @@ def print_dump(ri):
     direction = "request"
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
+    init_lines = []
     local_vars = ['struct ynl_dump_state yds = {};',
                   'struct nlmsghdr *nlh;',
                   'int err;']
 
     if ri.struct['request'].fixed_header:
-        local_vars += ['size_t hdr_len;',
-                       'void *hdr;']
+        prepare_fixed_header('req', local_vars, init_lines)
 
     if "request" in ri.op[ri.op_mode]:
         local_vars += put_local_vars(ri.struct["request"])
@@ -2449,11 +2454,7 @@ def print_dump(ri):
     else:
         ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
-    if ri.struct['request'].fixed_header:
-        ri.cw.p("hdr_len = sizeof(req->_hdr);")
-        ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
-        ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
-        ri.cw.nl()
+    ri.cw.p_lines(init_lines)
 
     if "request" in ri.op[ri.op_mode]:
         ri.cw.p(f"ys->req_policy = &{ri.struct['request'].render_name}_nest;")
-- 
2.51.0


