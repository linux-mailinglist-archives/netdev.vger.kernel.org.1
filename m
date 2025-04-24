Return-Path: <netdev+bounces-185366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D4A99EA9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D335194585E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475CD19C57C;
	Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcxvGLd7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334C19ABD8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460738; cv=none; b=dfoblzlw/u6j7eKe6bt+yY2B+InSgAMh6AjV/kXGDuDFpuY7uUw7Qo6W1GZcQaT40eUlqJpNHaH9HcCoYCfIsbmeRJ4FesNeHY9A+7MpXVrnSmYwqGABuN1ddn/9DhsGXYCkAEUySG1AGt4m/WfOEE+XZvGfzz3qp4XW1zOQta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460738; c=relaxed/simple;
	bh=w26YErioA6F0dltK/RGy9ymtm77tbndDa12AFUO8SeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ1ht6fyU59daksp7CYf2+lD8r4T4Bbv6JP47DtZEFHoVhSIpmAhyZTZS8QDXHJJXNIXK/rPkjXJ/8ndgO5czD5520BefRBDIlFcaX3hqbPVYKnEYyL00mjxLBfFYlXNtnDl/OZciIPEF4QBIbYCat8ZyVeKhn6V1dv1lNrFcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcxvGLd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDE9C4CEEA;
	Thu, 24 Apr 2025 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460737;
	bh=w26YErioA6F0dltK/RGy9ymtm77tbndDa12AFUO8SeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcxvGLd75qkz1hvXdoZBnk48hbqOBd9hENQuojnBC+3Bxy4AttUv6eZjJl7XcRfGV
	 jJ+h4k0MHKMod48ko30vvF/OcGlvyjur9xp5us+PQaxwwyauL1ZfOTTIFtUuah+7FD
	 9l9uejTu5Akj4cukE/Dr/3aj5fzrlD+2pZWVvMgVrN8gr7s4LxzKIqU8RHr9qnRXku
	 FTacRjsTLNiNCzBy9YZKvt2qJ9Rewf0haUTkwbxZF2SFj/7oKME7ppMYkJySL9WBIE
	 vVP4rz6pIOrVR68RVxrooyJjZHkBx9Aaovz2IWhAJEQhoTN5cPz4oyqS1DIzqrU1QZ
	 E+wFdCh1ddc2g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/12] tools: ynl: let classic netlink requests specify extra nlflags
Date: Wed, 23 Apr 2025 19:11:59 -0700
Message-ID: <20250424021207.1167791-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Classic netlink makes extensive use of flags. Support specifying
them the same way as attributes are specified (using a helper),
for example:

     rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);

Wrap the code up in a RenderInfo predicate. I think that some
genetlink families may want this, too. It should be easy to
add a spec property later.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  2 +-
 tools/net/ynl/lib/ynl.c          |  4 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py | 21 ++++++++++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 634eb16548b9..5debb09491e7 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -94,7 +94,7 @@ struct ynl_ntf_base_type {
 	unsigned char data[] __attribute__((aligned(8)));
 };
 
-struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id);
+struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id, __u16 flags);
 struct nlmsghdr *ynl_msg_start_dump(struct ynl_sock *ys, __u32 id);
 
 struct nlmsghdr *
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 70f899a54007..c16f01372ca3 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -451,9 +451,9 @@ ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
 	return nlh;
 }
 
-struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id)
+struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id, __u16 flags)
 {
-	return ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK);
+	return ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK | flags);
 }
 
 struct nlmsghdr *ynl_msg_start_dump(struct ynl_sock *ys, __u32 id)
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 569768bcf155..35a7e3ba0725 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1296,6 +1296,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def type_empty(self, key):
         return len(self.struct[key].attr_list) == 0 and self.fixed_hdr is None
 
+    def needs_nlflags(self, direction):
+        return self.op_mode == 'do' and direction == 'request' and self.family.is_classic()
+
 
 class CodeWriter:
     def __init__(self, nlib, out_file=None, overwrite=True):
@@ -1926,7 +1929,7 @@ _C_KW = {
     ri.cw.write_func_lvar(local_vars)
 
     if ri.family.is_classic():
-        ri.cw.p(f"nlh = ynl_msg_start_req(ys, {ri.op.enum_name});")
+        ri.cw.p(f"nlh = ynl_msg_start_req(ys, {ri.op.enum_name}, req->_nlmsg_flags);")
     else:
         ri.cw.p(f"nlh = ynl_gemsg_start_req(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
@@ -2055,6 +2058,16 @@ _C_KW = {
     ri.cw.write_func_prot('void', f"{name}_free", [f"struct {struct_name} *{arg}"], suffix=suffix)
 
 
+def print_nlflags_set(ri, direction):
+    name = op_prefix(ri, direction)
+    ri.cw.write_func_prot(f'static inline void', f"{name}_set_nlflags",
+                          [f"struct {name} *req", "__u16 nl_flags"])
+    ri.cw.block_start()
+    ri.cw.p('req->_nlmsg_flags = nl_flags;')
+    ri.cw.block_end()
+    ri.cw.nl()
+
+
 def _print_type(ri, direction, struct):
     suffix = f'_{ri.type_name}{direction_to_suffix[direction]}'
     if not direction and ri.type_name_conflict:
@@ -2065,6 +2078,9 @@ _C_KW = {
 
     ri.cw.block_start(line=f"struct {ri.family.c_name}{suffix}")
 
+    if ri.needs_nlflags(direction):
+        ri.cw.p('__u16 _nlmsg_flags;')
+        ri.cw.nl()
     if ri.fixed_hdr:
         ri.cw.p(ri.fixed_hdr + ' _hdr;')
         ri.cw.nl()
@@ -2104,6 +2120,9 @@ _C_KW = {
     print_free_prototype(ri, direction)
     ri.cw.nl()
 
+    if ri.needs_nlflags(direction):
+        print_nlflags_set(ri, direction)
+
     if ri.ku_space == 'user' and direction == 'request':
         for _, attr in ri.struct[direction].member_list():
             attr.setter(ri, ri.attr_set, direction, deref=deref)
-- 
2.49.0


