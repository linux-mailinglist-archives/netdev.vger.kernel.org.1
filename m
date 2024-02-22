Return-Path: <netdev+bounces-74208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AF86073A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18C1B22585
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C538143C4B;
	Thu, 22 Feb 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmmvWict"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E6143C45
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646194; cv=none; b=hiTfzmSJYhyr9QOVi+Yw6lFSaBPBJvrVWTDrnj1nw/tm1nq837+guDJ3Gobs8qZ4Ke/9c1YYfpDkHVh/C5kAuXt8HQWWiMplFoII3Q3N/xces7eB3/VAS/RRxta4ZKom5ntC1pnQciOTtj1AYIo5Uv80jFARBeAQfvUXbgeAwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646194; c=relaxed/simple;
	bh=2Nr3sX3WW4Ei1V5lHE0bN7951V8MhqkFVl2WId39FOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFxfUlC4YUY+7JInwfJeNZs4jBi5Aa36fQ8eg52TpgjtGoBZQIdmN6SQTBiYJCzxzL9gje6mI5A+09/s3WVSBzYAieiglQbsFb+6gbLumgFZEUvA9IoBXwZrrD1mGB46q6gNneh4w0moJwkgGWoaqsgwrtUrrVdZh+acbZfk//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmmvWict; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F76C433B1;
	Thu, 22 Feb 2024 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646193;
	bh=2Nr3sX3WW4Ei1V5lHE0bN7951V8MhqkFVl2WId39FOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmmvWictPSA/Z9S6nRBr/SLDA5vPTMLRCVGRqrS4m3PaLPHbVNvU+N/YinyvuBypX
	 8vzQt22pkv9AjjqhFyMjWAOrNA2h9mCZ4SbmyGjGJ/e99KACFEeC2Wn7c+YHda/VP2
	 O4ZLsjV12rYEBFTIyOOItG35xJUvwmctKPqctWIu3XI4oyxdCAp1QW4ixml1jy1z2m
	 tjURH+8xS5SthTqkTRTRWqK1ZN6B2vZ770pECdQWqGifZ6OFqVup+M/L897S9sXmEX
	 yNgILpaUoGaVGEPA2tnEty+q46RNZBdurru8SPRiJo0DAG9vOlyX4yDu+LlwAUgPB+
	 z+x0ADOw5kc5A==
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
Subject: [PATCH net-next 15/15] tools: ynl: use MSG_DONTWAIT for getting notifications
Date: Thu, 22 Feb 2024 15:56:14 -0800
Message-ID: <20240222235614.180876-16-kuba@kernel.org>
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

To stick to libmnl wrappers in the past we had to use poll()
to check if there are any outstanding notifications on the socket.
This is no longer necessary, we can use MSG_DONTWAIT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index e9631226cd8d..1739db19a37c 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -458,15 +458,19 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 	return YNL_PARSE_CB_ERROR;
 }
 
-static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
+static int
+__ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb, int flags)
 {
 	struct ynl_sock *ys = yarg->ys;
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
 	for (rem = len; rem > 0;) {
@@ -512,6 +516,11 @@ static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
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
@@ -800,18 +809,8 @@ int ynl_ntf_check(struct ynl_sock *ys)
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


