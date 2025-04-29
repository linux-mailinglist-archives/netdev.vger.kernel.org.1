Return-Path: <netdev+bounces-186788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C83AA10E6
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E1E921FBE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8124418E;
	Tue, 29 Apr 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAMnx3KK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053524397A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941639; cv=none; b=azX/4axDAmUpR2TUh35ootnSB6IC+8OXJpfKXdzjQE7nzKx/lunodt8lGiTCRO2IED27LwlgATSx9hAPxqWZbWOpZ2aIpie3KQcNQTsyH7Aty+x0t7IhEpSXpcxL83xkPciK1YdNTcRdabT6z0WR/t5ROfnWF9CFao5e8Ib7HGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941639; c=relaxed/simple;
	bh=f9KF7NoIN1wDYfiaSLeov5DihQXbNtEAo7gEVOHig9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffB6Jy5PXuSY1UccWNUcX0VFPmj9Qys7jJMm/tyhmjI5ZipLFaeJox02M1M0LGl6EV+hB4Ek5Hhv5AMTZ2nPCm4oeejaGRpVpYJ3ZUY+TUzUdXcX63mM63Nv7QlUyRxw7dWrkcKDnIe/3Vk8zFoJrpdNqEZq03co3aqI0d5163k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAMnx3KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57790C4CEE3;
	Tue, 29 Apr 2025 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941638;
	bh=f9KF7NoIN1wDYfiaSLeov5DihQXbNtEAo7gEVOHig9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAMnx3KK5hpYs0Ns0ynEia5m+7jzGo2t3wYUIcdvl34TIFMtnOfWMAxDZ0C9x+SrI
	 ephIqatSqUOJZhdUpm5w9vwl3lFEth5b6LIBSjwlIKnldesy0VBslFjyH+ZuS3FkNm
	 uShQbYM9DRYK0JB6I0F6JxyoiO3/LMJmslOcZX/Jq0kFogICDEZZP/vGOacUYZMwZ0
	 zqoT5EpNCeUfjJrAyCOByOm0Tr7agXTV8i/t854MXLDK8yUvjeBVzEOnd7miIH8tVi
	 4baH2H/oJCouSPLhiVVzo2dzoavad1PJKwFLS3qg5vaNZG3llaROaQepJYZZZ/lhLf
	 X7iOMybdH1aTQ==
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
	jdamato@fastly.com,
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 12/12] tools: ynl: allow fixed-header to be specified per op
Date: Tue, 29 Apr 2025 08:47:04 -0700
Message-ID: <20250429154704.2613851-13-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnetlink has variety of ops with different fixed headers.
Detect that op fixed header is not the same as family one,
and use sizeof() directly. For reverse parsing we need to
pass the fixed header len along the policy (in the socket
state).

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.h          |  1 +
 tools/net/ynl/lib/ynl.c          |  8 ++++----
 tools/net/ynl/pyynl/ynl_gen_c.py | 17 ++++++++++++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 6b8a625aaa5f..32efeb224829 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -80,6 +80,7 @@ struct ynl_sock {
 
 	struct nlmsghdr *nlh;
 	const struct ynl_policy_nest *req_policy;
+	size_t req_hdr_len;
 	unsigned char *tx_buf;
 	unsigned char *rx_buf;
 	unsigned char raw_buf[];
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c16f01372ca3..d263f6f40ad5 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -191,12 +191,12 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		n = snprintf(bad_attr, sizeof(bad_attr), "%sbad attribute: ",
 			     str ? " (" : "");
 
-		start = ynl_nlmsg_data_offset(ys->nlh, ys->family->hdr_len);
+		start = ynl_nlmsg_data_offset(ys->nlh, ys->req_hdr_len);
 		end = ynl_nlmsg_end_addr(ys->nlh);
 
 		off = ys->err.attr_offs;
 		off -= sizeof(struct nlmsghdr);
-		off -= ys->family->hdr_len;
+		off -= ys->req_hdr_len;
 
 		n += ynl_err_walk(ys, start, end, off, ys->req_policy,
 				  &bad_attr[n], sizeof(bad_attr) - n, NULL);
@@ -216,14 +216,14 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		n = snprintf(miss_attr, sizeof(miss_attr), "%smissing attribute: ",
 			     bad_attr[0] ? ", " : (str ? " (" : ""));
 
-		start = ynl_nlmsg_data_offset(ys->nlh, ys->family->hdr_len);
+		start = ynl_nlmsg_data_offset(ys->nlh, ys->req_hdr_len);
 		end = ynl_nlmsg_end_addr(ys->nlh);
 
 		nest_pol = ys->req_policy;
 		if (tb[NLMSGERR_ATTR_MISS_NEST]) {
 			off = ynl_attr_get_u32(tb[NLMSGERR_ATTR_MISS_NEST]);
 			off -= sizeof(struct nlmsghdr);
-			off -= ys->family->hdr_len;
+			off -= ys->req_hdr_len;
 
 			n += ynl_err_walk(ys, start, end, off, ys->req_policy,
 					  &miss_attr[n], sizeof(miss_attr) - n,
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1dd9580086cd..09b87c9a6908 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1311,8 +1311,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.op = op
 
         self.fixed_hdr = None
+        self.fixed_hdr_len = 'ys->family->hdr_len'
         if op and op.fixed_header:
             self.fixed_hdr = 'struct ' + c_lower(op.fixed_header)
+            if op.fixed_header != family.fixed_header:
+                if family.is_classic():
+                    self.fixed_hdr_len = f"sizeof({self.fixed_hdr})"
+                else:
+                    raise Exception(f"Per-op fixed header not supported, yet")
+
 
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
@@ -1799,6 +1806,11 @@ _C_KW = {
         if ri.fixed_hdr:
             local_vars += ['void *hdr;']
         iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
+        if ri.op.fixed_header != ri.family.fixed_header:
+            if ri.family.is_classic():
+                iter_line = f"ynl_attr_for_each(attr, nlh, sizeof({ri.fixed_hdr}))"
+            else:
+                raise Exception(f"Per-op fixed header not supported, yet")
 
     array_nests = set()
     multi_attrs = set()
@@ -2016,6 +2028,7 @@ _C_KW = {
         ri.cw.p(f"nlh = ynl_gemsg_start_req(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
     ri.cw.p(f"ys->req_policy = &{ri.struct['request'].render_name}_nest;")
+    ri.cw.p(f"ys->req_hdr_len = {ri.fixed_hdr_len};")
     if 'reply' in ri.op[ri.op_mode]:
         ri.cw.p(f"yrs.yarg.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
     ri.cw.nl()
@@ -2095,6 +2108,7 @@ _C_KW = {
 
     if "request" in ri.op[ri.op_mode]:
         ri.cw.p(f"ys->req_policy = &{ri.struct['request'].render_name}_nest;")
+        ri.cw.p(f"ys->req_hdr_len = {ri.fixed_hdr_len};")
         ri.cw.nl()
         for _, attr in ri.struct["request"].member_list():
             attr.attr_put(ri, "req")
@@ -2914,7 +2928,8 @@ _C_KW = {
         cw.p(f'.is_classic\t= true,')
         cw.p(f'.classic_id\t= {family.get("protonum")},')
     if family.is_classic():
-        cw.p(f'.hdr_len\t= sizeof(struct {c_lower(family.fixed_header)}),')
+        if family.fixed_header:
+            cw.p(f'.hdr_len\t= sizeof(struct {c_lower(family.fixed_header)}),')
     elif family.fixed_header:
         cw.p(f'.hdr_len\t= sizeof(struct genlmsghdr) + sizeof(struct {c_lower(family.fixed_header)}),')
     else:
-- 
2.49.0


