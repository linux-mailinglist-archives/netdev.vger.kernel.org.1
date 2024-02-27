Return-Path: <netdev+bounces-75494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589C86A281
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC0A1F27023
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F25646B;
	Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWun5V/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8C56468
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073049; cv=none; b=kWOBEg2JZmVcJ/3jKXFh2WasjbKqNgohPmQqH8kP0MX9z8/nw0w60Y++yuQD9Vb5K+CAQulPQspdpn3dk1Zpr/NPQigkLUPGEkldW3DzX7DTWhz4KMcioKX9VjNn454xpJz7GgtYGpORzIQ2I6+ocud6h+iO8UXfRLLWI6QGc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073049; c=relaxed/simple;
	bh=GtjLjx6SZ/9eaipV6ebGcwwaL8JzxnI0O7X7WKXdXaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksFnhsF2vlveAuz+HGmGgdCr5w4YTinXhCLVe+qOCFzIyAoReX9XTyqUUtRByWhYSTNo/ncYC+kTfG9yOCyBG9jG3UN5eQlyGfWbR+v7IULkBEdFLJ7CDPFnE74Mu560/PLTaSSZjxNntxK067WJFmJIxY0qH+jwmMLb2Az8opA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWun5V/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD39C43399;
	Tue, 27 Feb 2024 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073048;
	bh=GtjLjx6SZ/9eaipV6ebGcwwaL8JzxnI0O7X7WKXdXaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWun5V/D9RBb+VbRmpwpdEUjhGy1tO/+jcpgu/2tRRtKSvU8v0jktQsHtSstWX5B1
	 RC45A0wKu7vnk9Yd53kDTCkX4agrFkPuZj2EIsYD/BvuxfIkovKKvxZfnPlMSeSRNz
	 VckvRaOHbt8uLYtyBoRGajZdLhk42efGyhMLDff3/nxMtXCbWMMjVAm8lOg/hkI8Ki
	 h7JBc1YGWbKIoEs5JLyhx4YLxEW4C6Q1qVWECnvFvqoaXnMSkzuLDJCA3Pm9A0OdOw
	 r7n2QL6n2REif4nmt2YIuoFBoY+LwgAPmYI+8wQ9MEcL5BE9MDIRHVdQoaismDVRnP
	 b9diAfKWA2oXA==
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
Subject: [PATCH net-next v3 08/15] tools: ynl: wrap recv() + mnl_cb_run2() into a single helper
Date: Tue, 27 Feb 2024 14:30:25 -0800
Message-ID: <20240227223032.1835527-9-kuba@kernel.org>
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

All callers to mnl_cb_run2() call mnl_socket_recvfrom() right before.
Wrap the two in a helper, take typed arguments (struct ynl_parse_arg),
instead of hoping that all callers remember that parser error handling
requires yarg.

In case of ynl_sock_read_family() we will no longer check for kernel
returning no data, but that would be a kernel bug, not worth complicating
the code to catch this. Calling mnl_cb_run2() on an empty buffer
is legal and results in STOP (1).

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - extend commit message
---
 tools/net/ynl/lib/ynl.c | 56 +++++++++++++----------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index ad77ce6a1128..7c0f404526a0 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -491,6 +491,19 @@ int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_ERROR;
 }
 
+static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
+{
+	struct ynl_sock *ys = yarg->ys;
+	ssize_t len;
+
+	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
+	if (len < 0)
+		return len;
+
+	return mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
+			   cb, yarg, ynl_cb_array, NLMSG_MIN_TYPE);
+}
+
 /* Init/fini and genetlink boiler plate */
 static int
 ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
@@ -572,14 +585,7 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 		return err;
 	}
 
-	err = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
-	if (err <= 0) {
-		perr(ys, "failed to receive the socket family info");
-		return err;
-	}
-	err = mnl_cb_run2(ys->rx_buf, err, ys->seq, ys->portid,
-			  ynl_get_family_info_cb, &yarg,
-			  ynl_cb_array, ARRAY_SIZE(ynl_cb_array));
+	err = ynl_sock_read_msgs(&yarg, ynl_get_family_info_cb);
 	if (err < 0) {
 		free(ys->mcast_groups);
 		perr(ys, "failed to receive the socket family info - no such family?");
@@ -755,7 +761,6 @@ static int ynl_ntf_trampoline(const struct nlmsghdr *nlh, void *data)
 int ynl_ntf_check(struct ynl_sock *ys)
 {
 	struct ynl_parse_arg yarg = { .ys = ys, };
-	ssize_t len;
 	int err;
 
 	do {
@@ -770,14 +775,7 @@ int ynl_ntf_check(struct ynl_sock *ys)
 		if (err < 1)
 			return err;
 
-		len = mnl_socket_recvfrom(ys->sock, ys->rx_buf,
-					  MNL_SOCKET_BUFFER_SIZE);
-		if (len < 0)
-			return len;
-
-		err = mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-				  ynl_ntf_trampoline, &yarg,
-				  ynl_cb_array, NLMSG_MIN_TYPE);
+		err = ynl_sock_read_msgs(&yarg, ynl_ntf_trampoline);
 		if (err < 0)
 			return err;
 	} while (err > 0);
@@ -834,7 +832,6 @@ static int ynl_req_trampoline(const struct nlmsghdr *nlh, void *data)
 int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 	     struct ynl_req_state *yrs)
 {
-	ssize_t len;
 	int err;
 
 	err = mnl_socket_sendto(ys->sock, req_nlh, req_nlh->nlmsg_len);
@@ -842,19 +839,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 		return err;
 
 	do {
-		len = mnl_socket_recvfrom(ys->sock, ys->rx_buf,
-					  MNL_SOCKET_BUFFER_SIZE);
-		if (len < 0)
-			return len;
-
-		err = mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-				  ynl_req_trampoline, yrs,
-				  ynl_cb_array, NLMSG_MIN_TYPE);
-		if (err < 0)
-			return err;
+		err = ynl_sock_read_msgs(&yrs->yarg, ynl_req_trampoline);
 	} while (err > 0);
 
-	return 0;
+	return err;
 }
 
 static int ynl_dump_trampoline(const struct nlmsghdr *nlh, void *data)
@@ -896,7 +884,6 @@ static void *ynl_dump_end(struct ynl_dump_state *ds)
 int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 		  struct ynl_dump_state *yds)
 {
-	ssize_t len;
 	int err;
 
 	err = mnl_socket_sendto(ys->sock, req_nlh, req_nlh->nlmsg_len);
@@ -904,14 +891,7 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 		return err;
 
 	do {
-		len = mnl_socket_recvfrom(ys->sock, ys->rx_buf,
-					  MNL_SOCKET_BUFFER_SIZE);
-		if (len < 0)
-			goto err_close_list;
-
-		err = mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-				  ynl_dump_trampoline, yds,
-				  ynl_cb_array, NLMSG_MIN_TYPE);
+		err = ynl_sock_read_msgs(&yds->yarg, ynl_dump_trampoline);
 		if (err < 0)
 			goto err_close_list;
 	} while (err > 0);
-- 
2.43.2


