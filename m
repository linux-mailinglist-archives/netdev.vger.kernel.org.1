Return-Path: <netdev+bounces-74202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21717860734
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DB3B223EB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053B140E54;
	Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obke/p04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD08140E52
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646191; cv=none; b=Zhio2MsmO9elhuEmCQ0fnmF+1PF/1UDiGe2xwaXaQHgaW7RDxiLo32rimMoODVUmDvYu4ywqY+oAmww9gcu1jiuPT3D62wkXdarayFq/I4BBuWWRCHxvJ9z3HNyqJi+bc5ZA4jCSgYDN1VjLhWsit9ue+44mtnNUwCTuB5xndVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646191; c=relaxed/simple;
	bh=ozpLYkVvSBT+ZaUqeHbq5QrmXICLCjOV9D/nWlNIEco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTo+9v/M/9sN0ytPzVEBjDSxeNXOZlXbkOSqjJqbrdvsvoLxgOWscbw1pMRncfNYhQEMghisE7a1pHK0qtSh2ICEtYRndZOvPkq0nAth+gOrs6ZHXFum7cfInogopChz4nhXiZ/4unkWasij9o6dyM2pXn/6ELzcgkDk07OFh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obke/p04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84548C43394;
	Thu, 22 Feb 2024 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646190;
	bh=ozpLYkVvSBT+ZaUqeHbq5QrmXICLCjOV9D/nWlNIEco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Obke/p046Yh8uHWJe56UjKTXxEIoHWCbxaTU5qSkxtFugvXgvf0rNfA0CO6P+LWdO
	 oO1/wy0cVGGo2MQzAN5yFBerolH7hL1mUofxwgcV+Sh1pvGqiMCT4fRHcNmsnoD7ju
	 p2bhVCa8z+PSek43rnUsIIyTPJFbe8/BXa8vBtNPsyUao88jArCUMnvoYQHtiGNEKG
	 TtQMCIZZYa72GH5ug2oRulSIhct7pxvFmvIixTeZfz4msJO6fQGw9KPJ2r8/t+wme+
	 RjGDmuVzfjT8IT885Z2ok5TiRuotKQtpXpYvRa51YzmPx0kWib46sN44PBv32HXhD3
	 bI4oKeOH8IxUw==
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
Subject: [PATCH net-next 10/15] tools: ynl: stop using mnl_cb_run2()
Date: Thu, 22 Feb 2024 15:56:09 -0800
Message-ID: <20240222235614.180876-11-kuba@kernel.org>
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

There's only one set of callbacks in YNL, for netlink control
messages, and most of them are trivial. So implement the message
walking directly without depending on mnl_cb_run2().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.c | 66 +++++++++++++++++++++++++++++------------
 tools/net/ynl/lib/ynl.h |  1 +
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c01a971c251e..0f96ce948f75 100644
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
@@ -475,14 +462,55 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
 static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
 {
 	struct ynl_sock *ys = yarg->ys;
-	ssize_t len;
+	ssize_t len, rem;
+	int ret;
 
 	len = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
 	if (len < 0)
 		return len;
 
-	return mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-			   cb, yarg, ynl_cb_array, NLMSG_MIN_TYPE);
+	ret = MNL_CB_STOP;
+	for (rem = len; rem > 0;) {
+		const struct nlmsghdr *nlh;
+
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
+
+		NLMSG_NEXT(nlh, rem);
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


