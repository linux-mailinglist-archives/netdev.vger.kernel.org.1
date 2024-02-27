Return-Path: <netdev+bounces-75501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DE86A287
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0971F26389
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C005786A;
	Tue, 27 Feb 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE0ft+9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CC57864
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073052; cv=none; b=jKDHhq1/zsv9vkSfu/6MWp8E1QSMOGLrju8X6vOlnMlMYQXnDGV/k6sM4+xyfrEeWr3zLAElOV5sT+ej2Cn92NWSIadkW8oL2pnS7xztc0NBdEr6etBQ8aiuXVjFuIkhihtPUp+2wDPZyH58LFYLAZMcJkzytkb9Vsm0WP5Qdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073052; c=relaxed/simple;
	bh=Oidir/EiqU/gCD8RtUSNy0TdOX3xQOdb4sVV3N8ZZvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVH/rStuK+3ZAKfxrc1LLVnZ965e2H7zp3LZZRj5Gb9cEpw9CDRB+SFQ/Gn2fVeAq1Xo8YDL8K30BI2xVUUtNwS7Llg7ZQYr/bBLDmEFDopGGP6HwQIjj1MAVATobWQwfFBalyR082Al3LwhN/Htyz7jd3YldNFPeVCjx96nMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE0ft+9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB45C43394;
	Tue, 27 Feb 2024 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073052;
	bh=Oidir/EiqU/gCD8RtUSNy0TdOX3xQOdb4sVV3N8ZZvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vE0ft+9zlXek58ZxlCZGObg3AQ1bNc1wNhcIZpEc7mpYaBXpwNMuepsxlZgDPDbbP
	 R584AFeKEV9nSsGBobM0aivP5UVo3Aavnah+CtmaycR6zvCtRRAZt2t3mCP9MpOWS2
	 XRwIp3hsNvpPGHK9Dqi4qyWO97AXFn9oLusRe/YAiavvD1yi0mJNOq0QTxSW6ETH8+
	 gL0faZx9Q0bWCMrzu6/0wu71m9z0Xu2czXrV19CmmLmUhVy5BazCIVJYVgbt7qA6+q
	 CPt1LlUlKUl9aYYdRqX1O77AQm+sK4XkJX6VdXumlMiO2Gyz5yNKDLhviAquFv5I/x
	 sQOA0jHFosOHA==
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
Subject: [PATCH net-next v3 15/15] tools: ynl: use MSG_DONTWAIT for getting notifications
Date: Tue, 27 Feb 2024 14:30:32 -0800
Message-ID: <20240227223032.1835527-16-kuba@kernel.org>
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

To stick to libmnl wrappers in the past we had to use poll()
to check if there are any outstanding notifications on the socket.
This is no longer necessary, we can use MSG_DONTWAIT.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index f8a66ae88ba9..86729119e1ef 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -458,16 +458,20 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 	return YNL_PARSE_CB_ERROR;
 }
 
-static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
+static int
+__ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb, int flags)
 {
 	struct ynl_sock *ys = yarg->ys;
 	const struct nlmsghdr *nlh;
 	ssize_t len, rem;
 	int ret;
 
-	len = recv(ys->socket, ys->rx_buf, YNL_SOCKET_BUFFER_SIZE, 0);
-	if (len < 0)
+	len = recv(ys->socket, ys->rx_buf, YNL_SOCKET_BUFFER_SIZE, flags);
+	if (len < 0) {
+		if (flags & MSG_DONTWAIT && errno == EAGAIN)
+			return YNL_PARSE_CB_STOP;
 		return len;
+	}
 
 	ret = YNL_PARSE_CB_STOP;
 	for (rem = len; rem > 0; NLMSG_NEXT(nlh, rem)) {
@@ -509,6 +513,11 @@ static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
 	return ret;
 }
 
+static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
+{
+	return __ynl_sock_read_msgs(yarg, cb, 0);
+}
+
 static int ynl_recv_ack(struct ynl_sock *ys, int ret)
 {
 	struct ynl_parse_arg yarg = { .ys = ys, };
@@ -797,18 +806,8 @@ int ynl_ntf_check(struct ynl_sock *ys)
 	int err;
 
 	do {
-		/* libmnl doesn't let us pass flags to the recv to make
-		 * it non-blocking so we need to poll() or peek() :|
-		 */
-		struct pollfd pfd = { };
-
-		pfd.fd = ys->socket;
-		pfd.events = POLLIN;
-		err = poll(&pfd, 1, 1);
-		if (err < 1)
-			return err;
-
-		err = ynl_sock_read_msgs(&yarg, ynl_ntf_trampoline);
+		err = __ynl_sock_read_msgs(&yarg, ynl_ntf_trampoline,
+					   MSG_DONTWAIT);
 		if (err < 0)
 			return err;
 	} while (err > 0);
-- 
2.43.2


