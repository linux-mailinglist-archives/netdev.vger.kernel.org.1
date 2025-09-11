Return-Path: <netdev+bounces-222297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143EB53CE1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266464E0EBB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D34D27979F;
	Thu, 11 Sep 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="WAstVTba"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743E27467D;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621137; cv=none; b=Vs4tW6CXVOf+Ccp7dlK7kl92DYQLQPTAMpuR2gGJTmdn2gcT0px1yLu4XIDoLKF4nBUvMoJaIQ2nTMQ/Kqiri+1H6Srqxlx2Z3jWb0yghJdWZCe+qnILvTkKOyrPOaxU+HXqkCRx/uuZWA4BMTKTqImh4JouhYgXgv8LNjffdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621137; c=relaxed/simple;
	bh=nRP5kSsL1NhUO522TR+BNYCRG7vfbgQCQLsZarTM8HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcOZZ60zrxfTGy0rSI/ETmWBe0fDvCOdrsPiMk6SqqOh2Cbl700ftoV3gFQwA3RCTLxwW0x9jfxihwbdrtkyuq0vP9mUWVOpbiqed/5y+PWqZAaavy+kSFtido3gywhqLYvwVVPMASvYY4APUhIvru6AkVM6Sd1uVQ2wSaztXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=WAstVTba; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=nRP5kSsL1NhUO522TR+BNYCRG7vfbgQCQLsZarTM8HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAstVTbavWlOpORLtQzsZb8QQoo0KzpoUYqwExXkes5k+cuHAR1XOQ/4mkxG7cWwQ
	 s36rgOJ5lfzAEdeiF9YYw6Ecpxgz/OX6aZKss/FQyJSwpE1u+0Y5GB/wY/Ij7er2FD
	 gGMnVp9VL8r+u7jy56M9u3r+ZGXhGW6rol0nCx8WIzM6EoT7wY4gHutlTtfoQ/szZj
	 jrpz6VpdIaHDedINmtKMJkBJn3R1/Cf0BT902mEf6ErBOQVm8YJ8ZPtaPh6PCz4RnC
	 IMmSkEGc5uody4NT/A3duYL0QviQTSpLz4TOnVTk4/gjazFfG8Wq/jmAPIv2R59V+t
	 cJ4jyaZBVPT8w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2C3E960138;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 16890204C71; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
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
Subject: [PATCH net-next v3 06/13] tools: ynl-gen: deduplicate fixed_header handling
Date: Thu, 11 Sep 2025 20:04:59 +0000
Message-ID: <20250911200508.79341-7-ast@fiberby.net>
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
index 7a2e49a84735..b3ce0901a19b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1828,7 +1828,10 @@ class CodeWriter:
         if lines and nl_before:
             self.nl()
         for line in lines or []:
-            self.p(line)
+            if line == '':
+                self.nl()
+            else:
+                self.p(line)
 
 
 scalars = {'u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64', 'uint', 'sint'}
@@ -1921,6 +1924,15 @@ def type_name(ri, direction, deref=False):
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
 
@@ -2074,10 +2086,7 @@ def put_req_nested(ri, struct):
         local_vars.append('struct nlattr *nest;')
         init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
     if struct.fixed_header:
-        local_vars.append('void *hdr;')
-        struct_sz = f'sizeof({struct.fixed_header})'
-        init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
-        init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
+        prepare_fixed_header('obj', local_vars, init_lines)
 
     local_vars += put_local_vars(struct)
 
@@ -2346,6 +2355,7 @@ def print_req(ri):
     ret_ok = '0'
     ret_err = '-1'
     direction = "request"
+    init_lines = []
     local_vars = ['struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };',
                   'struct nlmsghdr *nlh;',
                   'int err;']
@@ -2356,8 +2366,7 @@ def print_req(ri):
         local_vars += [f'{type_name(ri, rdir(direction))} *rsp;']
 
     if ri.struct["request"].fixed_header:
-        local_vars += ['size_t hdr_len;',
-                       'void *hdr;']
+        prepare_fixed_header('req', local_vars, init_lines)
 
     local_vars += put_local_vars(ri.struct["request"])
 
@@ -2376,11 +2385,7 @@ def print_req(ri):
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
@@ -2418,13 +2423,13 @@ def print_dump(ri):
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
@@ -2446,11 +2451,7 @@ def print_dump(ri):
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


