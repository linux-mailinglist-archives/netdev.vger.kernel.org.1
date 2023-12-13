Return-Path: <netdev+bounces-57113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FB8122B1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D77A28286A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078483B04;
	Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dECbEhij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17583AFF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B892EC433D9;
	Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509286;
	bh=fR0LIwr6FIDqSdHG5IbIHg4GElsS3enKl26mk8zmeJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dECbEhijfbB8c4Dh4y/iTc1gMoXrAXWlr02Cm1HY0Fms98UJwLu2vP/Ob2R0RkElf
	 SySLPdbBYSi1QXs6AgOABZOad9nnV0b1TKfV2J+gniDcuowji2O2kBPa1qUEAyJJ9T
	 PlWxKWM8F3KR/wepkvjjkCklN1C7z7+X+yH6T4ClxGJUu8PDHuk+ZvSW/j3nIzbmrW
	 igR0w5s+icEVup6HCAw8cF1EfXKQ9RVaMn3dHkvWKXfqrugEVEABMls5tyD+Atargk
	 DXhTDWgfIRM/++yqkhU+zmjvLIse6ArGZ/kZAO4OF1/3W0qyLDvwd0VMNusXEy6/Nt
	 HF63OUbPEyaRg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/8] tools: ynl-gen: support fixed headers in genetlink
Date: Wed, 13 Dec 2023 15:14:27 -0800
Message-ID: <20231213231432.2944749-4-kuba@kernel.org>
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

Support genetlink families using simple fixed headers.
Assume fixed header is identical for all ops of the family for now.

Fixed headers are added to the request and reply structs as a _hdr
member, and copied to/from netlink messages appropriately.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.c    |  8 +++----
 tools/net/ynl/lib/ynl.h    |  1 +
 tools/net/ynl/ynl-gen-c.py | 44 ++++++++++++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 587286de10b5..c82a7f41b31c 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -191,12 +191,12 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 			     str ? " (" : "");
 
 		start = mnl_nlmsg_get_payload_offset(ys->nlh,
-						     sizeof(struct genlmsghdr));
+						     ys->family->hdr_len);
 		end = mnl_nlmsg_get_payload_tail(ys->nlh);
 
 		off = ys->err.attr_offs;
 		off -= sizeof(struct nlmsghdr);
-		off -= sizeof(struct genlmsghdr);
+		off -= ys->family->hdr_len;
 
 		n += ynl_err_walk(ys, start, end, off, ys->req_policy,
 				  &bad_attr[n], sizeof(bad_attr) - n, NULL);
@@ -217,14 +217,14 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 			     bad_attr[0] ? ", " : (str ? " (" : ""));
 
 		start = mnl_nlmsg_get_payload_offset(ys->nlh,
-						     sizeof(struct genlmsghdr));
+						     ys->family->hdr_len);
 		end = mnl_nlmsg_get_payload_tail(ys->nlh);
 
 		nest_pol = ys->req_policy;
 		if (tb[NLMSGERR_ATTR_MISS_NEST]) {
 			off = mnl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_NEST]);
 			off -= sizeof(struct nlmsghdr);
-			off -= sizeof(struct genlmsghdr);
+			off -= ys->family->hdr_len;
 
 			n += ynl_err_walk(ys, start, end, off, ys->req_policy,
 					  &miss_attr[n], sizeof(miss_attr) - n,
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 5de580b992b8..ce77a6d76ce0 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -44,6 +44,7 @@ struct ynl_error {
 struct ynl_family {
 /* private: */
 	const char *name;
+	size_t hdr_len;
 	const struct ynl_ntf_info *ntf_info;
 	unsigned int ntf_info_size;
 };
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index ab009d0f9db5..70e2c41e5bd6 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1124,6 +1124,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.op_mode = op_mode
         self.op = op
 
+        self.fixed_hdr = None
+        if op and op.fixed_header:
+            self.fixed_hdr = 'struct ' + c_lower(op.fixed_header)
+
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
         if op_mode != 'do' and 'dump' in op:
@@ -1570,7 +1574,9 @@ _C_KW = {
     if struct.nested:
         iter_line = "mnl_attr_for_each_nested(attr, nested)"
     else:
-        iter_line = "mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr))"
+        if ri.fixed_hdr:
+            local_vars += ['void *hdr;']
+        iter_line = "mnl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
 
     array_nests = set()
     multi_attrs = set()
@@ -1603,6 +1609,9 @@ _C_KW = {
     for arg in struct.inherited:
         ri.cw.p(f'dst->{arg} = {arg};')
 
+    if ri.fixed_hdr:
+        ri.cw.p('hdr = mnl_nlmsg_get_payload_offset(nlh, sizeof(struct genlmsghdr));')
+        ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({ri.fixed_hdr}));")
     for anest in sorted(all_multi):
         aspec = struct[anest]
         ri.cw.p(f"if (dst->{aspec.c_name})")
@@ -1723,6 +1732,10 @@ _C_KW = {
         ret_err = 'NULL'
         local_vars += [f'{type_name(ri, rdir(direction))} *rsp;']
 
+    if ri.fixed_hdr:
+        local_vars += ['size_t hdr_len;',
+                       'void *hdr;']
+
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
@@ -1733,6 +1746,13 @@ _C_KW = {
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p(f"yrs.yarg.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
     ri.cw.nl()
+
+    if ri.fixed_hdr:
+        ri.cw.p("hdr_len = sizeof(req->_hdr);")
+        ri.cw.p("hdr = mnl_nlmsg_put_extra_header(nlh, hdr_len);")
+        ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
+        ri.cw.nl()
+
     for _, attr in ri.struct["request"].member_list():
         attr.attr_put(ri, "req")
     ri.cw.nl()
@@ -1773,9 +1793,11 @@ _C_KW = {
                   'struct nlmsghdr *nlh;',
                   'int err;']
 
-    for var in local_vars:
-        ri.cw.p(f'{var}')
-    ri.cw.nl()
+    if ri.fixed_hdr:
+        local_vars += ['size_t hdr_len;',
+                       'void *hdr;']
+
+    ri.cw.write_func_lvar(local_vars)
 
     ri.cw.p('yds.ys = ys;')
     ri.cw.p(f"yds.alloc_sz = sizeof({type_name(ri, rdir(direction))});")
@@ -1788,6 +1810,12 @@ _C_KW = {
     ri.cw.nl()
     ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
+    if ri.fixed_hdr:
+        ri.cw.p("hdr_len = sizeof(req->_hdr);")
+        ri.cw.p("hdr = mnl_nlmsg_put_extra_header(nlh, hdr_len);")
+        ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
+        ri.cw.nl()
+
     if "request" in ri.op[ri.op_mode]:
         ri.cw.p(f"ys->req_policy = &{ri.struct['request'].render_name}_nest;")
         ri.cw.nl()
@@ -1845,6 +1873,10 @@ _C_KW = {
 
     ri.cw.block_start(line=f"struct {ri.family.c_name}{suffix}")
 
+    if ri.fixed_hdr:
+        ri.cw.p(ri.fixed_hdr + ' _hdr;')
+        ri.cw.nl()
+
     meta_started = False
     for _, attr in struct.member_list():
         for type_filter in ['len', 'bit']:
@@ -2482,6 +2514,10 @@ _C_KW = {
 
     cw.block_start(f'{symbol} = ')
     cw.p(f'.name\t\t= "{family.c_name}",')
+    if family.fixed_header:
+        cw.p(f'.hdr_len\t= sizeof(struct genlmsghdr) + sizeof(struct {c_lower(family.fixed_header)}),')
+    else:
+        cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
     if family.ntfs:
         cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
         cw.p(f".ntf_info_size\t= MNL_ARRAY_SIZE({family['name']}_ntf_info),")
-- 
2.43.0


