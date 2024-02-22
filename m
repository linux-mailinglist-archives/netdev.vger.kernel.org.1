Return-Path: <netdev+bounces-74201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE367860733
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652191F21CCB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17894140E43;
	Thu, 22 Feb 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD1dtn+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885D140E40
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646190; cv=none; b=XqZwON7kgv7Run4spL9IaLYj8uEpAHp1vmwvVUnzfdKtbdk9gEAlCRqb+GNFpO/wxu6jsfBYdLagVFFPPV6ZNKXeKupYnnWQDjJaX+yd9h8JQGiiuwmwyUQ8Sacq2HCeH4QzoDmDmwW9YnABG395JcdGA0vW/ByPyxObk+dC9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646190; c=relaxed/simple;
	bh=LVx0jWVal3fpCmsWd9WgXsvP4ShpxUynDMYfNdt9GMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh2wGsFsrLCIOgzTDWqrgS417EXZ8u7DgYFZFd/6auyZ+wfcqoohWn5+UwnrSt37OY4XIJOvWM0DXz5tPQNu7PEvme2DP061Eo8LZmH3SUNtb5CVpJnTJxYqavk5HCRpROFHeKrYUDDRxphXemmH6YaehatvGIfTXby9dVxSFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD1dtn+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6017FC43399;
	Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646189;
	bh=LVx0jWVal3fpCmsWd9WgXsvP4ShpxUynDMYfNdt9GMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oD1dtn+lREoOBkTfwAcDco050gPeggGI6BgSWrSs5ZEcYV3dMrP7KilrLGEWlZ9wA
	 PjfPWxLckni0UFfV4xo9UgRN2fcmrZNkUev5g1Yxn38P6BG82Ty3kNaWZOAxWwAnMq
	 /zkhaIlvqgq6nMbXGWBg45OGONZvX4wx2K1WbZ3V2mJOikY2yJlJqxHqMUZuKnVSeJ
	 JFX1NU55yxut7cq9kzmxT6ToCpwdbNfE49m664gWNbgvbGm1ZLjilkPKkZE6HvZ/C9
	 aPD+8DOd2VL+sTRNDP0wqaZGDrig2DY2XrDawk8L77GjGYPPkeQVDSxAbiY6Tlcm+0
	 RzUBI6KrrkZyw==
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
Subject: [PATCH net-next 08/15] tools: ynl: wrap recv() + mnl_cb_run2() into a single helper
Date: Thu, 22 Feb 2024 15:56:07 -0800
Message-ID: <20240222235614.180876-9-kuba@kernel.org>
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

All callers to mnl_cb_run2() call mnl_socket_recvfrom() right before.
Wrap the two in a helper, take typed arguments (struct ynl_parse_arg),
instead of hoping that all callers remember that parser error handling
requires yarg.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.c | 56 +++++++++++++----------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c9790257189c..96a209773ace 100644
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


