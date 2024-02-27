Return-Path: <netdev+bounces-75490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C286A27E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D250D28596F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1355C15;
	Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDZvAQ+8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2F55C06
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073046; cv=none; b=ZCSLC7ghb5ZMDpn4xB0woCcmuVdDUWshKe1xjGF8QFcP2GHTYwEqjBRiC6TVgOdn9FIbkgWoY6LJhMuip/HU/qBIZ5sT3vHNzNF+En0aflrvXq34DYAvDb8OzFvlM9h9Px+LjwISo0Jk0xIySRM2zF9Lx9OAFgVYhX2H5B7jHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073046; c=relaxed/simple;
	bh=nIvk+GaTlReyp1E23/zt/zpPu8GEyvAHa263ey7QQoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1RfoxZU/t64ariwp+4kE346cnqjf2MaTjpWyt4Fh1pqCAErc+ohzCvJipLqrUpr2SfSbHSsJW1Azz+QDfXXy4EyHSAaPxtPEEYEcOkk6L7BxjiUI6d8ZMeKdZlvZJgJ0HD35o59fZ2uIFyI6IYD/Hxf+CR3Aue9Sm7fPdBua2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDZvAQ+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ADDC43390;
	Tue, 27 Feb 2024 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073046;
	bh=nIvk+GaTlReyp1E23/zt/zpPu8GEyvAHa263ey7QQoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDZvAQ+8HHqvyIvxT0aG10lqtAv1f5GsQlW8ZD0U7ZQjEMv7u8gHyOve/SnZJo+QW
	 VNyWr+1Ixy/yl40fHDdTVdBTMwjTIbtB+r53bCJ9fgsPtHjarozX7+3XJtm3oPm4oL
	 RekDfBaGJaWSxE09Wj50FYfjpXsKgwEAsmrF1ZuqFyvpM1tdfR/ik4sJ9NC0o4hu2/
	 kQ1CUxM/NElcPillaEMRpupdfNbgbJUFAmExZ4SYVFJTUdftqNWdAzEWGTEBR1iA/M
	 Cd00QeOFI+UNWr6IAhay9B+0kzBcrqGOrwkl5uTavWoUM6r07j8uRnERZK+i922Bx0
	 JTsGtxAvjyBRQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 04/15] tools: ynl: create local nlmsg access helpers
Date: Tue, 27 Feb 2024 14:30:21 -0800
Message-ID: <20240227223032.1835527-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create helpers for accessing payloads of struct nlmsg.
Use them instead of the libmnl ones.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 39 +++++++++++++++++++++++++++++++++++-
 tools/net/ynl/lib/ynl.c      | 24 ++++++++++------------
 tools/net/ynl/ynl-gen-c.py   |  6 +++---
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index a339732450c3..1dfa09497be8 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -125,13 +125,50 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
 int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
-/* Attribute helpers */
+/* Netlink message handling helpers */
+
+static inline struct nlmsghdr *ynl_nlmsg_put_header(void *buf)
+{
+	struct nlmsghdr *nlh = buf;
+
+	memset(nlh, 0, sizeof(*nlh));
+	nlh->nlmsg_len = NLMSG_HDRLEN;
+
+	return nlh;
+}
+
+static inline unsigned int ynl_nlmsg_data_len(const struct nlmsghdr *nlh)
+{
+	return nlh->nlmsg_len - NLMSG_HDRLEN;
+}
+
+static inline void *ynl_nlmsg_data(const struct nlmsghdr *nlh)
+{
+	return (unsigned char *)nlh + NLMSG_HDRLEN;
+}
+
+static inline void *
+ynl_nlmsg_data_offset(const struct nlmsghdr *nlh, unsigned int offset)
+{
+	return (unsigned char *)nlh + NLMSG_HDRLEN + offset;
+}
 
 static inline void *ynl_nlmsg_end_addr(const struct nlmsghdr *nlh)
 {
 	return (char *)nlh + nlh->nlmsg_len;
 }
 
+static inline void *
+ynl_nlmsg_put_extra_header(struct nlmsghdr *nlh, unsigned int size)
+{
+	void *tail = ynl_nlmsg_end_addr(nlh);
+
+	nlh->nlmsg_len += NLMSG_ALIGN(size);
+	return tail;
+}
+
+/* Netlink attribute helpers */
+
 static inline unsigned int ynl_attr_type(const struct nlattr *attr)
 {
 	return attr->nla_type & NLA_TYPE_MASK;
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 0f71e69b70c0..5f303d6e751f 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -190,9 +190,8 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		n = snprintf(bad_attr, sizeof(bad_attr), "%sbad attribute: ",
 			     str ? " (" : "");
 
-		start = mnl_nlmsg_get_payload_offset(ys->nlh,
-						     ys->family->hdr_len);
-		end = mnl_nlmsg_get_payload_tail(ys->nlh);
+		start = ynl_nlmsg_data_offset(ys->nlh, ys->family->hdr_len);
+		end = ynl_nlmsg_end_addr(ys->nlh);
 
 		off = ys->err.attr_offs;
 		off -= sizeof(struct nlmsghdr);
@@ -216,9 +215,8 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		n = snprintf(miss_attr, sizeof(miss_attr), "%smissing attribute: ",
 			     bad_attr[0] ? ", " : (str ? " (" : ""));
 
-		start = mnl_nlmsg_get_payload_offset(ys->nlh,
-						     ys->family->hdr_len);
-		end = mnl_nlmsg_get_payload_tail(ys->nlh);
+		start = ynl_nlmsg_data_offset(ys->nlh, ys->family->hdr_len);
+		end = ynl_nlmsg_end_addr(ys->nlh);
 
 		nest_pol = ys->req_policy;
 		if (tb[NLMSGERR_ATTR_MISS_NEST]) {
@@ -259,7 +257,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 
 static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
 {
-	const struct nlmsgerr *err = mnl_nlmsg_get_payload(nlh);
+	const struct nlmsgerr *err = ynl_nlmsg_data(nlh);
 	struct ynl_parse_arg *yarg = data;
 	unsigned int hlen;
 	int code;
@@ -270,7 +268,7 @@ static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
 
 	hlen = sizeof(*err);
 	if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
-		hlen += mnl_nlmsg_get_payload_len(&err->msg);
+		hlen += ynl_nlmsg_data_len(&err->msg);
 
 	ynl_ext_ack_check(yarg->ys, nlh, hlen);
 
@@ -413,7 +411,7 @@ struct nlmsghdr *ynl_msg_start(struct ynl_sock *ys, __u32 id, __u16 flags)
 
 	ynl_err_reset(ys);
 
-	nlh = ys->nlh = mnl_nlmsg_put_header(ys->tx_buf);
+	nlh = ys->nlh = ynl_nlmsg_put_header(ys->tx_buf);
 	nlh->nlmsg_type	= id;
 	nlh->nlmsg_flags = flags;
 	nlh->nlmsg_seq = ++ys->seq;
@@ -435,7 +433,7 @@ ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
 	gehdr.cmd = cmd;
 	gehdr.version = version;
 
-	data = mnl_nlmsg_put_extra_header(nlh, sizeof(gehdr));
+	data = ynl_nlmsg_put_extra_header(nlh, sizeof(gehdr));
 	memcpy(data, &gehdr, sizeof(gehdr));
 
 	return nlh;
@@ -718,7 +716,7 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	struct genlmsghdr *gehdr;
 	int ret;
 
-	gehdr = mnl_nlmsg_get_payload(nlh);
+	gehdr = ynl_nlmsg_data(nlh);
 	if (gehdr->cmd >= ys->family->ntf_info_size)
 		return MNL_CB_ERROR;
 	info = &ys->family->ntf_info[gehdr->cmd];
@@ -808,13 +806,13 @@ ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
 {
 	struct genlmsghdr *gehdr;
 
-	if (mnl_nlmsg_get_payload_len(nlh) < sizeof(*gehdr)) {
+	if (ynl_nlmsg_data_len(nlh) < sizeof(*gehdr)) {
 		yerr(ys, YNL_ERROR_INV_RESP,
 		     "Kernel responded with truncated message");
 		return -1;
 	}
 
-	gehdr = mnl_nlmsg_get_payload(nlh);
+	gehdr = ynl_nlmsg_data(nlh);
 	if (gehdr->cmd != rsp_cmd)
 		return ynl_ntf_parse(ys, nlh);
 
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index eabce06f03d9..90d7bf4849fc 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1650,7 +1650,7 @@ _C_KW = {
         ri.cw.p(f'dst->{arg} = {arg};')
 
     if ri.fixed_hdr:
-        ri.cw.p('hdr = mnl_nlmsg_get_payload_offset(nlh, sizeof(struct genlmsghdr));')
+        ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
         ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({ri.fixed_hdr}));")
     for anest in sorted(all_multi):
         aspec = struct[anest]
@@ -1794,7 +1794,7 @@ _C_KW = {
 
     if ri.fixed_hdr:
         ri.cw.p("hdr_len = sizeof(req->_hdr);")
-        ri.cw.p("hdr = mnl_nlmsg_put_extra_header(nlh, hdr_len);")
+        ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
         ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
         ri.cw.nl()
 
@@ -1857,7 +1857,7 @@ _C_KW = {
 
     if ri.fixed_hdr:
         ri.cw.p("hdr_len = sizeof(req->_hdr);")
-        ri.cw.p("hdr = mnl_nlmsg_put_extra_header(nlh, hdr_len);")
+        ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
         ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
         ri.cw.nl()
 
-- 
2.43.2


