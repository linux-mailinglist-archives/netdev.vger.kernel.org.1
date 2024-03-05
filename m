Return-Path: <netdev+bounces-77631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7F8726E7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C7B1C23086
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B3199B9;
	Tue,  5 Mar 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZA8P3K1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCA17997
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664608; cv=none; b=RRgiparOALC1UvAiRprqY+3yfSWRpg8NgiEqkVnfqJOfzWdKsXF5Z742yt4bmJuFELoMcqVkDmSkDLFPBs5ld7Czt/gDsv4eN8JLJSmBL6NPtOeR+YO9xHO1eC1AwLS+eSUtuld337JpfqWnaROfzGFqAgvFrtzNgwlWBj/wXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664608; c=relaxed/simple;
	bh=o99UXVElGQz8yNLk68PD2sr9EcYVUfPsnmz5pK5jFGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFrms1MhDjRICzSqShI0SxulnKOY2sAmc/89f/1qjxRdU9dp7SD+/wHdNLX3+xFGbDosCPatPz0s9vUXAqN1uMSHyjyj+SM2A7Ol3nkzLOJEeuIgygv/2z0s8K7EJCJZnRGanMbrY8ev03bc1NH9qZMLI8ba5EMyH1GXjtQ4vHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZA8P3K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B3C43390;
	Tue,  5 Mar 2024 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664608;
	bh=o99UXVElGQz8yNLk68PD2sr9EcYVUfPsnmz5pK5jFGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PZA8P3K1UiorKf9mEaqp2KPLNJAJpLTxsBTzt++WSt6gJuQI08fxM0hJpuGRHcnLg
	 Iw9x4N2eE4s53b9flHn79RgD7rGR9TatcGn1YWDuVffO7bxFv9iE3Sxd2ZQRJFcgBj
	 pVuLns3Zxw4+zIc4cQFG6/w0wQlClVvT+oW3/Ak9P5+ga2smW5HcTFWkcD/eIjD3vZ
	 YwfRwZYpzY1FZrumY/EGdIc16TSLy9VxCzUw8dkhf2ECjwxyQxHLMVGjDs1Fa+ut/s
	 OWb3zcPu1cmSU1k0jz5wZ0woIWivov4wk44vHb/juWzBYaNWeL104BzuibgIdFUS5o
	 xW599bsaoUklA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl: check for overflow of constructed messages
Date: Tue,  5 Mar 2024 10:50:00 -0800
Message-ID: <20240305185000.964773-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Donald points out that we don't check for overflows.
Stash the length of the message on nlmsg_pid (nlmsg_seq would
do as well). This allows the attribute helpers to remain
self-contained (no extra arguments). Also let the put
helpers continue to return nothing. The error is checked
only in (newly introduced) ynl_msg_end().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This was first discussed when I posted the libmnl replacement:
https://lore.kernel.org/all/CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com/
---
 tools/net/ynl/lib/ynl-priv.h | 34 ++++++++++++++++++++++++++++++----
 tools/net/ynl/lib/ynl.c      | 36 ++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.h      |  2 ++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index a8099fab035d..6cf890080dc0 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -135,6 +135,8 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
 /* Netlink message handling helpers */
 
+#define YNL_MSG_OVERFLOW	1
+
 static inline struct nlmsghdr *ynl_nlmsg_put_header(void *buf)
 {
 	struct nlmsghdr *nlh = buf;
@@ -239,11 +241,29 @@ ynl_attr_first(const void *start, size_t len, size_t skip)
 	return ynl_attr_if_good(start + len, attr);
 }
 
+static inline bool
+__ynl_attr_put_overflow(struct nlmsghdr *nlh, size_t size)
+{
+	bool o;
+
+	/* ynl_msg_start() stashed buffer length in nlmsg_pid. */
+	o = nlh->nlmsg_len + NLA_HDRLEN + NLMSG_ALIGN(size) > nlh->nlmsg_pid;
+	if (o)
+		/* YNL_MSG_OVERFLOW is < NLMSG_HDRLEN, all subsequent checks
+		 * are guaranteed to fail.
+		 */
+		nlh->nlmsg_pid = YNL_MSG_OVERFLOW;
+	return o;
+}
+
 static inline struct nlattr *
 ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
 {
 	struct nlattr *attr;
 
+	if (__ynl_attr_put_overflow(nlh, 0))
+		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;
+
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type | NLA_F_NESTED;
 	nlh->nlmsg_len += NLA_HDRLEN;
@@ -263,6 +283,9 @@ ynl_attr_put(struct nlmsghdr *nlh, unsigned int attr_type,
 {
 	struct nlattr *attr;
 
+	if (__ynl_attr_put_overflow(nlh, size))
+		return;
+
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 	attr->nla_len = NLA_HDRLEN + size;
@@ -276,14 +299,17 @@ static inline void
 ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
 {
 	struct nlattr *attr;
-	const char *end;
+	size_t len;
+
+	len = strlen(str);
+	if (__ynl_attr_put_overflow(nlh, len))
+		return;
 
 	attr = ynl_nlmsg_end_addr(nlh);
 	attr->nla_type = attr_type;
 
-	end = stpcpy(ynl_attr_data(attr), str);
-	attr->nla_len =
-		NLA_HDRLEN + NLA_ALIGN(end - (char *)ynl_attr_data(attr));
+	strcpy(ynl_attr_data(attr), str);
+	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
 
 	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
 }
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 484070492b17..5c9d955d0f22 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -404,9 +404,33 @@ struct nlmsghdr *ynl_msg_start(struct ynl_sock *ys, __u32 id, __u16 flags)
 	nlh->nlmsg_flags = flags;
 	nlh->nlmsg_seq = ++ys->seq;
 
+	/* This is a local YNL hack for length checking, we put the buffer
+	 * length in nlmsg_pid, since messages sent to the kernel always use
+	 * PID 0. Message needs to be terminated with ynl_msg_end().
+	 */
+	nlh->nlmsg_pid = YNL_SOCKET_BUFFER_SIZE;
+
 	return nlh;
 }
 
+static int ynl_msg_end(struct ynl_sock *ys, struct nlmsghdr *nlh)
+{
+	/* We stash buffer length in nlmsg_pid. */
+	if (nlh->nlmsg_pid == 0) {
+		yerr(ys, YNL_ERROR_INPUT_INVALID,
+		     "Unknwon input buffer length");
+		return -EINVAL;
+	}
+	if (nlh->nlmsg_pid == YNL_MSG_OVERFLOW) {
+		yerr(ys, YNL_ERROR_INPUT_TOO_BIG,
+		     "Constructred message longer than internal buffer");
+		return -EMSGSIZE;
+	}
+
+	nlh->nlmsg_pid = 0;
+	return 0;
+}
+
 struct nlmsghdr *
 ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
 		__u8 cmd, __u8 version)
@@ -607,6 +631,10 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 	nlh = ynl_gemsg_start_req(ys, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 1);
 	ynl_attr_put_str(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
 
+	err = ynl_msg_end(ys, nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, nlh, nlh->nlmsg_len, 0);
 	if (err < 0) {
 		perr(ys, "failed to request socket family info");
@@ -868,6 +896,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
+	err = ynl_msg_end(ys, req_nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
@@ -921,6 +953,10 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
+	err = ynl_msg_end(ys, req_nlh);
+	if (err < 0)
+		return err;
+
 	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index dbeeef8ce91a..9842e85a8c57 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -20,6 +20,8 @@ enum ynl_error_code {
 	YNL_ERROR_ATTR_INVALID,
 	YNL_ERROR_UNKNOWN_NTF,
 	YNL_ERROR_INV_RESP,
+	YNL_ERROR_INPUT_INVALID,
+	YNL_ERROR_INPUT_TOO_BIG,
 };
 
 /**
-- 
2.44.0


