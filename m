Return-Path: <netdev+bounces-75109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA58682E7
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93C228ED02
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06040132C05;
	Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ61sV2L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1913249E
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982432; cv=none; b=ny/9L/91nkvo+kPuHMoWEVKtYXRjiwr42nScFs2ar0IzFaF/0+l/K47JeYlpEjO2BgnvD4nmc1NhNCP4CmAnq0cvkxfpeBvG/LR1kjsGRaK6ljhZ9gN0FfuXmfD3a7KmljWu+YjtZd7gcJ30pBQbZsWgMyq1+VZ7IB8y/9xknCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982432; c=relaxed/simple;
	bh=PlfHzNmd4dYl4oxIug3qxbLXKp1/3CNg0f3QgWBvvEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9amc5LC99I/P1jFarstag4G7Z5kab71dio5KZHA9NHtfFXqQqo2hbTsglsafQYA54FGNFLRAMpYbaELggD8xCn09x0wTm5yJZxJ9sqYBpYe/IdO8G70xFrkfL7yBfwGpOwdTktuDuo0GxDsc4GEYpBuVqSH0LWT2pjrV3s8Ti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ61sV2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714CCC433A6;
	Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982432;
	bh=PlfHzNmd4dYl4oxIug3qxbLXKp1/3CNg0f3QgWBvvEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ61sV2LdHchmz7NxoFX7NYPcLnnozPNzmMkb3fq0vJpINszal6abEH+mZDWiZ9rp
	 4kfY62b4fi+j8k8M64YryA5L7fb7QW5GBX2EUz9IOoKpADuZDAPdXPxCjBV6n+cPQi
	 Mbzkukw8Gjkl8VlTk5tz+muZCgJCHsRYIa8pZjrmw59qSfinMkbBi20HuUXaelXHFU
	 NaGTu7RYQz/bsZAAxHW8p1oDsD/nRtSf5cZWZrGWXnZLyK5jWml8dlEZSZH9vMVZDI
	 iyA8KQkyTLJIKSswjiUCqJPzNZZ5i4NA78/cnuiT+pyC7GSIqATzr1YUqB6/eEjYAl
	 /ES8S8j5p2gRw==
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
Subject: [PATCH net-next v2 10/15] tools: ynl: stop using mnl_cb_run2()
Date: Mon, 26 Feb 2024 13:20:16 -0800
Message-ID: <20240226212021.1247379-11-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's only one set of callbacks in YNL, for netlink control
messages, and most of them are trivial. So implement the message
walking directly without depending on mnl_cb_run2().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v2:
 - fold NLMSG_NEXT(nlh, rem) into the for () statement
---
 tools/net/ynl/lib/ynl.c | 63 ++++++++++++++++++++++++++++-------------
 tools/net/ynl/lib/ynl.h |  1 +
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index f830990b3f4a..fd658aaff345 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -255,10 +255,10 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 	return MNL_CB_OK;
 }
 
-static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
+static int
+ynl_cb_error(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
 	const struct nlmsgerr *err = ynl_nlmsg_data(nlh);
-	struct ynl_parse_arg *yarg = data;
 	unsigned int hlen;
 	int code;
 
@@ -275,9 +275,8 @@ static int ynl_cb_error(const struct nlmsghdr *nlh, void *data)
 	return code ? MNL_CB_ERROR : MNL_CB_STOP;
 }
 
-static int ynl_cb_done(const struct nlmsghdr *nlh, void *data)
+static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_parse_arg *yarg = data;
 	int err;
 
 	err = *(int *)NLMSG_DATA(nlh);
@@ -292,18 +291,6 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_STOP;
 }
 
-static int ynl_cb_noop(const struct nlmsghdr *nlh, void *data)
-{
-	return MNL_CB_OK;
-}
-
-static mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
-	[NLMSG_NOOP]	= ynl_cb_noop,
-	[NLMSG_ERROR]	= ynl_cb_error,
-	[NLMSG_DONE]	= ynl_cb_done,
-	[NLMSG_OVERRUN]	= ynl_cb_noop,
-};
-
 /* Attribute validation */
 
 int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
@@ -475,14 +462,52 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
 static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
 {
 	struct ynl_sock *ys = yarg->ys;
-	ssize_t len;
+	const struct nlmsghdr *nlh;
+	ssize_t len, rem;
+	int ret;
 
 	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
 	if (len < 0)
 		return len;
 
-	return mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-			   cb, yarg, ynl_cb_array, NLMSG_MIN_TYPE);
+	ret = MNL_CB_STOP;
+	for (rem = len; rem > 0; NLMSG_NEXT(nlh, rem)) {
+		nlh = (struct nlmsghdr *)&ys->rx_buf[len - rem];
+		if (!NLMSG_OK(nlh, rem)) {
+			yerr(yarg->ys, YNL_ERROR_INV_RESP,
+			     "Invalid message or trailing data in the response.");
+			return MNL_CB_ERROR;
+		}
+
+		if (nlh->nlmsg_flags & NLM_F_DUMP_INTR) {
+			/* TODO: handle this better */
+			yerr(yarg->ys, YNL_ERROR_DUMP_INTER,
+			     "Dump interrupted / inconsistent, please retry.");
+			return MNL_CB_ERROR;
+		}
+
+		switch (nlh->nlmsg_type) {
+		case 0:
+			yerr(yarg->ys, YNL_ERROR_INV_RESP,
+			     "Invalid message type in the response.");
+			return MNL_CB_ERROR;
+		case NLMSG_NOOP:
+		case NLMSG_OVERRUN ... NLMSG_MIN_TYPE - 1:
+			ret = MNL_CB_OK;
+			break;
+		case NLMSG_ERROR:
+			ret = ynl_cb_error(nlh, yarg);
+			break;
+		case NLMSG_DONE:
+			ret = ynl_cb_done(nlh, yarg);
+			break;
+		default:
+			ret = cb(nlh, yarg);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 static int ynl_recv_ack(struct ynl_sock *ys, int ret)
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index ce77a6d76ce0..4849c142fce0 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -12,6 +12,7 @@ enum ynl_error_code {
 	YNL_ERROR_NONE = 0,
 	__YNL_ERRNO_END = 4096,
 	YNL_ERROR_INTERNAL,
+	YNL_ERROR_DUMP_INTER,
 	YNL_ERROR_EXPECT_ACK,
 	YNL_ERROR_EXPECT_MSG,
 	YNL_ERROR_UNEXPECT_MSG,
-- 
2.43.2


