Return-Path: <netdev+bounces-180996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D1A835F5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ECC8A293B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C71DD0F2;
	Thu, 10 Apr 2025 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igu/nogw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5E1DC9B0
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249636; cv=none; b=TgkLkdbAQgPeDuSJkOOMFEix0RCdkeOlTRhIxzcVn0aw8HyePk2hltk4+vrZL0+FZ7vi7PKfm389Dcw6A0TUlfxpkp/aepcTHAgYFn5dUGOt3GImSHxKBjZ64pEtT6gr2uD9dZzV1+Zvwq+fl73BQbWmb49u0AgUIc7GHgZE39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249636; c=relaxed/simple;
	bh=19N7IMgAQ20DbAsJ2YZ0IEia+k1fep/RYxtQto5l4Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO2LRG/Dh7w1awMq1tXT68dOIegpkHgqiqnBvZ6uY3V+svzyRRDkfrEp1HyBaZFUr4EJej+Tihub5FIeX2RikNfkkk417q78RjBSYeIDyLOY1vnQJaSMtz8+sCZ3AmaVx8Fk9OTjwC5CGaoM6GwaOzbXNtNDwP1WZVW3kaE8HIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igu/nogw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DF8C4CEEC;
	Thu, 10 Apr 2025 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249635;
	bh=19N7IMgAQ20DbAsJ2YZ0IEia+k1fep/RYxtQto5l4Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Igu/nogwL0AYMOuruP3i7jyzxvGKXblQc9cxDz5xXSeRCsaJwo2064buTCYEIbVed
	 yQniIbWBKOV+3AgC+E6UW4mjvEkYrTKNBQQuy6cNYjmnEmYAvHW0ZcpnuX4dwk5WvO
	 LYCGaL5TkoL4/o54c7XNXR2CPztBoS9qEXYHXLKohmiradvBFA8XcyfEDnuVf824nT
	 1i8cocNx0UaRHyLa6/DIjJmkLQBbTTOXbLGl6MprfFVyFGvU4bVZMQZ5E87GGIVE8T
	 NCmkfHzuxCvIZSW9CCxphshZBHGCHWjLNsF3QjXz6XH8xolX9Yhhsw4o4SKksLj8dW
	 ETdMZe0tQtiyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/13] tools: ynl: don't use genlmsghdr in classic netlink
Date: Wed,  9 Apr 2025 18:46:54 -0700
Message-ID: <20250410014658.782120-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the codegen calls the right YNL lib helper to start
the request based on family type. Classic netlink request must
not include the genl header.

Conversely don't expect genl headers in the responses.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  3 +++
 tools/net/ynl/lib/ynl.c          |  8 ++++----
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 +++++++++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 3c09a7bbfba5..634eb16548b9 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -94,6 +94,9 @@ struct ynl_ntf_base_type {
 	unsigned char data[] __attribute__((aligned(8)));
 };
 
+struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id);
+struct nlmsghdr *ynl_msg_start_dump(struct ynl_sock *ys, __u32 id);
+
 struct nlmsghdr *
 ynl_gemsg_start_req(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 struct nlmsghdr *
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index b9fda1a99453..70f899a54007 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -451,14 +451,14 @@ ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
 	return nlh;
 }
 
-void ynl_msg_start_req(struct ynl_sock *ys, __u32 id)
+struct nlmsghdr *ynl_msg_start_req(struct ynl_sock *ys, __u32 id)
 {
-	ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK);
+	return ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK);
 }
 
-void ynl_msg_start_dump(struct ynl_sock *ys, __u32 id)
+struct nlmsghdr *ynl_msg_start_dump(struct ynl_sock *ys, __u32 id)
 {
-	ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP);
+	return ynl_msg_start(ys, id, NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP);
 }
 
 struct nlmsghdr *
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 04f1ac62cb01..b0b47a493a86 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1710,7 +1710,10 @@ _C_KW = {
         ri.cw.p(f'dst->{arg} = {arg};')
 
     if ri.fixed_hdr:
-        ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
+        if ri.family.is_classic():
+            ri.cw.p('hdr = ynl_nlmsg_data(nlh);')
+        else:
+            ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
         ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({ri.fixed_hdr}));")
     for anest in sorted(all_multi):
         aspec = struct[anest]
@@ -1857,7 +1860,10 @@ _C_KW = {
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
 
-    ri.cw.p(f"nlh = ynl_gemsg_start_req(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
+    if ri.family.is_classic():
+        ri.cw.p(f"nlh = ynl_msg_start_req(ys, {ri.op.enum_name});")
+    else:
+        ri.cw.p(f"nlh = ynl_gemsg_start_req(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
     ri.cw.p(f"ys->req_policy = &{ri.struct['request'].render_name}_nest;")
     if 'reply' in ri.op[ri.op_mode]:
@@ -1926,7 +1932,10 @@ _C_KW = {
     else:
         ri.cw.p(f'yds.rsp_cmd = {ri.op.rsp_value};')
     ri.cw.nl()
-    ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
+    if ri.family.is_classic():
+        ri.cw.p(f"nlh = ynl_msg_start_dump(ys, {ri.op.enum_name});")
+    else:
+        ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
     if ri.fixed_hdr:
         ri.cw.p("hdr_len = sizeof(req->_hdr);")
@@ -2736,7 +2745,9 @@ _C_KW = {
     if family.is_classic():
         cw.p(f'.is_classic\t= true,')
         cw.p(f'.classic_id\t= {family.get("protonum")},')
-    if family.fixed_header:
+    if family.is_classic():
+        cw.p(f'.hdr_len\t= sizeof(struct {c_lower(family.fixed_header)}),')
+    elif family.fixed_header:
         cw.p(f'.hdr_len\t= sizeof(struct genlmsghdr) + sizeof(struct {c_lower(family.fixed_header)}),')
     else:
         cw.p('.hdr_len\t= sizeof(struct genlmsghdr),')
-- 
2.49.0


