Return-Path: <netdev+bounces-74197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E986072F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F451F218C0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31899140397;
	Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS2d2DYd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BA140392
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646188; cv=none; b=oYC+dnO1vobMgTN5SZfJLIcwoWPcHF2pqtd9ZGGRoqUVcH++/UPPndXRiFXxe6GpQPM7XQNOQoAMiYYrfQhG9Tn8KMw0VeY9agGjBBWMidgN336eZBwkN1qqJsHXte8Sh9+gofnoD2uCbKv1LvyrMJJ1INF/0QlC9WopJYOtF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646188; c=relaxed/simple;
	bh=FXFfk3CD4Yd0Ljo/JDNQ1xcVnY2K+4q7aZRJdg8wtD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIKhNifMtQwEdsV444MJn+pcarJ2LjU8m6VRLwNOofmuwO22hQouri96nQzHk0CEm355Ylzv+SxoNxqY4qlEJ4UC4L7vyBX7he13F+uCMF+QeukFBVwnir7dD7O1O5NAY3mcK14UpSGOYnNrxmxb+Gu8BekjkJaU9hS8J1jSJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS2d2DYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A91C433B1;
	Thu, 22 Feb 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646187;
	bh=FXFfk3CD4Yd0Ljo/JDNQ1xcVnY2K+4q7aZRJdg8wtD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS2d2DYdGpoYIjIkjH55huYlTtfSMMxdCS4gDV+ZTpnUtwaDa9T4Nj1JWWM2REd4j
	 YoK/YNj6JYm4xgfzhkaZ5fbPI0LOLr697BZzMbPYUvBDHy4vUAx3M+9FtT97kXXf9h
	 YkE/8iKmOqtH7+8Va7mXNFrrGx/pbOx+zv58yzolTbXaRchDJiQkckiKC9ii3vNsOU
	 t8qelx+jdwsAZ6fgs5W03vikJ0GAEk/WUhYPahG7zP2WC/zpnBVqPz8CaYw6B77QFT
	 8KVJGPLNJC2OEggeYrzxXM7MwDm62rynk3adxtHVYNCAN7r81+MMYa9Jrji/MQSZVh
	 jZNVnodAB6qLw==
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
Subject: [PATCH net-next 04/15] tools: ynl: create local nlmsg access helpers
Date: Thu, 22 Feb 2024 15:56:03 -0800
Message-ID: <20240222235614.180876-5-kuba@kernel.org>
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

Create helpers for accessing payloads of struct nlmsg.
Use them instead of the libmnl ones.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 39 +++++++++++++++++++++++++++++++++++-
 tools/net/ynl/lib/ynl.c      | 24 ++++++++++------------
 tools/net/ynl/ynl-gen-c.py   |  6 +++---
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 1d658897cceb..654d1e29c482 100644
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
index 614aa3736d84..39f7c7b23443 100644
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
index 01380e6d2881..7b5635bf4c04 100755
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


