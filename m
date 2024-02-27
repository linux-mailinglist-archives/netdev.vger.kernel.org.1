Return-Path: <netdev+bounces-75499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE186A285
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209D81C243EA
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CC57322;
	Tue, 27 Feb 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXTNRcCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6C56472
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073051; cv=none; b=G0fThu/dz2vRJG8B1iZXOBkCrwU0U5Zt23bsYiNcrE6nCoJZsMZODEtCJKO63IO2JWMnmOrfMYcWrD046+nlen3Y/BevclWK4pHFh99prIVrW9lecXyPkAg9t/ZCDt7TvdxpUNe3bN+BlxMOl3PKqJvbGJSKyTZxXwWQdxIOBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073051; c=relaxed/simple;
	bh=9XNaBv6G6jwYM7zdHFiBcGwiwSPXhj+ZftS/LKStD88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojJf9XSJCn0+iUTjYWVkKCxZ1xG1m7ChuaJdRISNi4v0gvRbInOiIG87+xWW2Vkg3RByZifsAEB/w+VNXF3lP9sREp5mIb8FJDGT1Now56EN2LqVxv/hRiBDBKTgTaIQpwXBNcln5NycA9SGoG86Z1z1hThTQ7MUKrM+476WxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXTNRcCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D81BC43609;
	Tue, 27 Feb 2024 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073051;
	bh=9XNaBv6G6jwYM7zdHFiBcGwiwSPXhj+ZftS/LKStD88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXTNRcCu4nqe9Taq+lTOr/+RCreyaXly3MM8C6AREyxzGKjj8fTaj10duR/PGN7df
	 M0mzTR/cGU3Fy9DrUz2M8JUbigv/N6pM9tiEYVAJBrQcJx9g4X23oTwDXgxjKwUfTm
	 KnXEM1GIUg6yPECuc9B4Ag/c8TXLVT2nqoAjgD3dafc9yOGAlAONoKH4DeLBBLtHYR
	 c9URfRY+JU73fyCg1MH0Ir/F6Jbef91Vg5fTTVODHKdBJL7VnSsVm2RljGX9OtzkjU
	 lJqHZB/xuhDhp8ekQN15a7OFSl8HgKlNpJJDgyR7yEdxllub37SQYteHRZtNcIUybO
	 5amWNguMK6yhw==
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
Subject: [PATCH net-next v3 13/15] tools: ynl: stop using mnl socket helpers
Date: Tue, 27 Feb 2024 14:30:30 -0800
Message-ID: <20240227223032.1835527-14-kuba@kernel.org>
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

Most libmnl socket helpers can be replaced by direct calls to
the underlying libc API. We need portid, the netlink manpage
suggests we bind() address of zero.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h |  2 ++
 tools/net/ynl/lib/ynl.c      | 60 +++++++++++++++++++++++-------------
 tools/net/ynl/lib/ynl.h      |  2 +-
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index a3a9367aacbe..5150ef1dacda 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -35,6 +35,8 @@ enum ynl_parse_result {
 	YNL_PARSE_CB_OK = 1,
 };
 
+#define YNL_SOCKET_BUFFER_SIZE		(1 << 17)
+
 #define YNL_ARRAY_SIZE(array)	(sizeof(array) ?			\
 				 sizeof(array) / sizeof(array[0]) : 0)
 
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 968ab679b5e3..9d028929117a 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -3,10 +3,12 @@
 #include <poll.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
 #include <linux/types.h>
-
 #include <libmnl/libmnl.h>
 #include <linux/genetlink.h>
+#include <sys/socket.h>
 
 #include "ynl.h"
 
@@ -464,7 +466,7 @@ static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
 	ssize_t len, rem;
 	int ret;
 
-	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
+	len = recv(ys->socket, ys->rx_buf, YNL_SOCKET_BUFFER_SIZE, 0);
 	if (len < 0)
 		return len;
 
@@ -596,7 +598,7 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 	nlh = ynl_gemsg_start_req(ys, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 1);
 	ynl_attr_put_str(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
 
-	err = mnl_socket_sendto(ys->sock, nlh, nlh->nlmsg_len);
+	err = send(ys->socket, nlh, nlh->nlmsg_len, 0);
 	if (err < 0) {
 		perr(ys, "failed to request socket family info");
 		return err;
@@ -621,38 +623,54 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
 struct ynl_sock *
 ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 {
+	struct sockaddr_nl addr;
 	struct ynl_sock *ys;
+	socklen_t addrlen;
 	int one = 1;
 
-	ys = malloc(sizeof(*ys) + 2 * MNL_SOCKET_BUFFER_SIZE);
+	ys = malloc(sizeof(*ys) + 2 * YNL_SOCKET_BUFFER_SIZE);
 	if (!ys)
 		return NULL;
 	memset(ys, 0, sizeof(*ys));
 
 	ys->family = yf;
 	ys->tx_buf = &ys->raw_buf[0];
-	ys->rx_buf = &ys->raw_buf[MNL_SOCKET_BUFFER_SIZE];
+	ys->rx_buf = &ys->raw_buf[YNL_SOCKET_BUFFER_SIZE];
 	ys->ntf_last_next = &ys->ntf_first;
 
-	ys->sock = mnl_socket_open(NETLINK_GENERIC);
-	if (!ys->sock) {
+	ys->socket = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (ys->socket < 0) {
 		__perr(yse, "failed to create a netlink socket");
 		goto err_free_sock;
 	}
 
-	if (mnl_socket_setsockopt(ys->sock, NETLINK_CAP_ACK,
-				  &one, sizeof(one))) {
+	if (setsockopt(ys->socket, SOL_NETLINK, NETLINK_CAP_ACK,
+		       &one, sizeof(one))) {
 		__perr(yse, "failed to enable netlink ACK");
 		goto err_close_sock;
 	}
-	if (mnl_socket_setsockopt(ys->sock, NETLINK_EXT_ACK,
-				  &one, sizeof(one))) {
+	if (setsockopt(ys->socket, SOL_NETLINK, NETLINK_EXT_ACK,
+		       &one, sizeof(one))) {
 		__perr(yse, "failed to enable netlink ext ACK");
 		goto err_close_sock;
 	}
 
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family = AF_NETLINK;
+	if (bind(ys->socket, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		__perr(yse, "unable to bind to a socket address");
+		goto err_close_sock;;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addrlen = sizeof(addr);
+	if (getsockname(ys->socket, (struct sockaddr *)&addr, &addrlen) < 0) {
+		__perr(yse, "unable to read socket address");
+		goto err_close_sock;;
+	}
+	ys->portid = addr.nl_pid;
 	ys->seq = random();
-	ys->portid = mnl_socket_get_portid(ys->sock);
+
 
 	if (ynl_sock_read_family(ys, yf->name)) {
 		if (yse)
@@ -663,7 +681,7 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	return ys;
 
 err_close_sock:
-	mnl_socket_close(ys->sock);
+	close(ys->socket);
 err_free_sock:
 	free(ys);
 	return NULL;
@@ -673,7 +691,7 @@ void ynl_sock_destroy(struct ynl_sock *ys)
 {
 	struct ynl_ntf_base_type *ntf;
 
-	mnl_socket_close(ys->sock);
+	close(ys->socket);
 	while ((ntf = ynl_ntf_dequeue(ys)))
 		ynl_ntf_free(ntf);
 	free(ys->mcast_groups);
@@ -700,9 +718,9 @@ int ynl_subscribe(struct ynl_sock *ys, const char *grp_name)
 		return -1;
 	}
 
-	err = mnl_socket_setsockopt(ys->sock, NETLINK_ADD_MEMBERSHIP,
-				    &ys->mcast_groups[i].id,
-				    sizeof(ys->mcast_groups[i].id));
+	err = setsockopt(ys->socket, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
+			 &ys->mcast_groups[i].id,
+			 sizeof(ys->mcast_groups[i].id));
 	if (err < 0) {
 		perr(ys, "Subscribing to multicast group failed");
 		return -1;
@@ -713,7 +731,7 @@ int ynl_subscribe(struct ynl_sock *ys, const char *grp_name)
 
 int ynl_socket_get_fd(struct ynl_sock *ys)
 {
-	return mnl_socket_get_fd(ys->sock);
+	return ys->socket;
 }
 
 struct ynl_ntf_base_type *ynl_ntf_dequeue(struct ynl_sock *ys)
@@ -785,7 +803,7 @@ int ynl_ntf_check(struct ynl_sock *ys)
 		 */
 		struct pollfd pfd = { };
 
-		pfd.fd = mnl_socket_get_fd(ys->sock);
+		pfd.fd = ys->socket;
 		pfd.events = POLLIN;
 		err = poll(&pfd, 1, 1);
 		if (err < 1)
@@ -851,7 +869,7 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
-	err = mnl_socket_sendto(ys->sock, req_nlh, req_nlh->nlmsg_len);
+	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
 
@@ -904,7 +922,7 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 {
 	int err;
 
-	err = mnl_socket_sendto(ys->sock, req_nlh, req_nlh->nlmsg_len);
+	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
 	if (err < 0)
 		return err;
 
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 4849c142fce0..dbeeef8ce91a 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -59,7 +59,7 @@ struct ynl_sock {
 
 /* private: */
 	const struct ynl_family *family;
-	struct mnl_socket *sock;
+	int socket;
 	__u32 seq;
 	__u32 portid;
 	__u16 family_id;
-- 
2.43.2


