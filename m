Return-Path: <netdev+bounces-74196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A906C86072E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103D7B23137
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF64140382;
	Thu, 22 Feb 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIDoYULS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD6140376
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646187; cv=none; b=h3gOdmxSumlnDCJqIH/1o56wwb/2C9F9n5erwlRJkJQ4+UOgxy2zAdlGx84Mb/36DyW3LsFlTShFOK6UoTBuIMDp8JPTfTFXS45dUk5DO1i9gQ1aMHlRmEhg79Mvi7n1rfhBeQ/tAYIkDxrpPyGGKytn30wlD1Wl6seSGFFAc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646187; c=relaxed/simple;
	bh=a9uq0t0SxpIlO3fpp/JDbqQFWVu3rlBIBiiyNKzUOtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAg5EIYlITpd3EjMDmlGGq3nM2UkmOtUpYwC4Bji85x3qAyN9Wt2UurXbcCwFOLWc+RhHB5qz6Imd1uYkT7YiHPmiB+Ml+9KIUod+ATF9eMYY+IibvBX+b5AT75CwUZYXGvFbrXzDsOSo5Im2rYWTR6gb0Q/YiHtj+Rih+2k8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIDoYULS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D6AC43330;
	Thu, 22 Feb 2024 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646187;
	bh=a9uq0t0SxpIlO3fpp/JDbqQFWVu3rlBIBiiyNKzUOtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIDoYULSMAF+SHvSpAQfzwLl82jYebI7S7bEJFXyqlwg/AmAx3eEbyxW5JRYAnCiz
	 E6UEkUFTNOnq+zaJPFvtKbxoGNqVRds3Z0qG1GdEFZ8Cf2cJf9/atVWIdZ16cyPzlM
	 oZsawiW9S9H51e8GhwAvwMahzp98aAz9aqnQnJ/XnZ0DtvGz9caXq+tbZH/KIHh0ok
	 MwcWVMOSVF30Dx8lwndR8PeFG4Dts78Fidgi9MRaslaRCYD9a1t6Swut0TjQ1Enmwf
	 wLoYM/qedrJz1j/FUcEFBqG/+0GPP9Uj2SlTwt2nQp9mNRZyndcupRzsTXCBVtdHaZ
	 oF/wzGHmW5H8A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/15] tools: ynl: create local for_each helpers
Date: Thu, 22 Feb 2024 15:56:02 -0800
Message-ID: <20240222235614.180876-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
References: <20240222235614.180876-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create ynl_attr_for_each*() iteration helpers.
Use them instead of the mnl ones.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 47 ++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.c      | 12 ++++-----
 tools/net/ynl/ynl-gen-c.py   |  8 +++---
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index b5f99521fd8d..1d658897cceb 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -147,6 +147,53 @@ static inline void *ynl_attr_data(const struct nlattr *attr)
 	return (unsigned char *)attr + NLA_ALIGN(sizeof(struct nlattr));
 }
 
+static inline void *ynl_attr_data_end(const struct nlattr *attr)
+{
+	return ynl_attr_data(attr) + ynl_attr_data_len(attr);
+}
+
+#define ynl_attr_for_each(attr, nlh, fixed_hdr_sz)			\
+	for ((attr) = ynl_attr_first(nlh, (nlh)->nlmsg_len,		\
+				     NLMSG_HDRLEN + fixed_hdr_sz); attr; \
+	     (attr) = ynl_attr_next(ynl_nlmsg_end_addr(nlh), attr))
+
+#define ynl_attr_for_each_nested(attr, outer)				\
+	for ((attr) = ynl_attr_first(outer, outer->nla_len,		\
+				     sizeof(struct nlattr)); attr;	\
+	     (attr) = ynl_attr_next(ynl_attr_data_end(outer), attr))
+
+#define ynl_attr_for_each_payload(start, len, attr)			\
+	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
+	     (attr) = ynl_attr_next(start + len, attr))
+
+static inline struct nlattr *
+ynl_attr_if_good(const void *end, struct nlattr *attr)
+{
+	if (attr + 1 > (const struct nlattr *)end)
+		return NULL;
+	if (ynl_attr_data_end(attr) > end)
+		return NULL;
+	return attr;
+}
+
+static inline struct nlattr *
+ynl_attr_next(const void *end, const struct nlattr *prev)
+{
+	struct nlattr *attr;
+
+	attr = (void *)((char *)prev + NLA_ALIGN(prev->nla_len));
+	return ynl_attr_if_good(end, attr);
+}
+
+static inline struct nlattr *
+ynl_attr_first(const void *start, size_t len, size_t skip)
+{
+	struct nlattr *attr;
+
+	attr = (void *)((char *)start + NLMSG_ALIGN(skip));
+	return ynl_attr_if_good(start + len, attr);
+}
+
 static inline struct nlattr *
 ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
 {
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index f16297713c0e..614aa3736d84 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -92,7 +92,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	data_len = end - start;
 
-	mnl_attr_for_each_payload(start, data_len) {
+	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
 		aend_off = astart_off + ynl_attr_data_len(attr);
 		if (aend_off <= off)
@@ -150,7 +150,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		return MNL_CB_OK;
 	}
 
-	mnl_attr_for_each(attr, nlh, hlen) {
+	ynl_attr_for_each(attr, nlh, hlen) {
 		unsigned int len, type;
 
 		len = ynl_attr_data_len(attr);
@@ -500,7 +500,7 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 	const struct nlattr *entry, *attr;
 	unsigned int i;
 
-	mnl_attr_for_each_nested(attr, mcasts)
+	ynl_attr_for_each_nested(attr, mcasts)
 		ys->n_mcast_groups++;
 
 	if (!ys->n_mcast_groups)
@@ -512,8 +512,8 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 		return MNL_CB_ERROR;
 
 	i = 0;
-	mnl_attr_for_each_nested(entry, mcasts) {
-		mnl_attr_for_each_nested(attr, entry) {
+	ynl_attr_for_each_nested(entry, mcasts) {
+		ynl_attr_for_each_nested(attr, entry) {
 			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_ID)
 				ys->mcast_groups[i].id = ynl_attr_get_u32(attr);
 			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_NAME) {
@@ -535,7 +535,7 @@ static int ynl_get_family_info_cb(const struct nlmsghdr *nlh, void *data)
 	const struct nlattr *attr;
 	bool found_id = true;
 
-	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+	ynl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
 		if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GROUPS)
 			if (ynl_get_family_info_mcast(ys, attr))
 				return MNL_CB_ERROR;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 4f19c959ee7e..01380e6d2881 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -650,7 +650,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
         get_lines = [f'attr_{self.c_name} = attr;',
-                     'mnl_attr_for_each_nested(attr2, attr)',
+                     'ynl_attr_for_each_nested(attr2, attr)',
                      f'\t{var}->n_{self.c_name}++;']
         return get_lines, None, local_vars
 
@@ -1612,11 +1612,11 @@ _C_KW = {
 
 def _multi_parse(ri, struct, init_lines, local_vars):
     if struct.nested:
-        iter_line = "mnl_attr_for_each_nested(attr, nested)"
+        iter_line = "ynl_attr_for_each_nested(attr, nested)"
     else:
         if ri.fixed_hdr:
             local_vars += ['void *hdr;']
-        iter_line = "mnl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
+        iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
 
     array_nests = set()
     multi_attrs = set()
@@ -1679,7 +1679,7 @@ _C_KW = {
         ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
-        ri.cw.block_start(line=f"mnl_attr_for_each_nested(attr, attr_{aspec.c_name})")
+        ri.cw.block_start(line=f"ynl_attr_for_each_nested(attr, attr_{aspec.c_name})")
         ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
         ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
         ri.cw.p('return MNL_CB_ERROR;')
-- 
2.43.2


