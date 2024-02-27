Return-Path: <netdev+bounces-75496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C286A29B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D49AB25C13
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD456744;
	Tue, 27 Feb 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOa3JeiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50385647B
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073049; cv=none; b=fnR43FrhhHnEI1y8lucQfY/NeLHHqyOah1lPqKNMpD+Kf9TPf8cfQgJ20uPkj7sN2/l9/iRz2VXD8L64MGr7smdLpzy3h+P3Yi+TkytAjocPOAyvLbAJ7R3K/c4gDl9/rEQYeBPYeB3hEQ6BoN/iuK4dkNM0Puv+mv0epsycxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073049; c=relaxed/simple;
	bh=aVP/g1/9C1Aul8mcAwsKyZeqKojXdpUCbBNdJQ+pbOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0KocxShEEwKGg5tybalJIL3Vs50iPSpRc/SJlB+8bmf+UfFcbsdVqK+FTTq0J9uZvkglBichFmNksTAe4D40Kgluq+rxVX2qZ0hkARqL7jGACjtHgzU2ZAf+hbuVnrOeQUCAtynO/fC/MvXkJyefXz+a97RtDYwVVlKRycN8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOa3JeiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E84C43399;
	Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073049;
	bh=aVP/g1/9C1Aul8mcAwsKyZeqKojXdpUCbBNdJQ+pbOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOa3JeiVNLw/HnARD72DGy+iyxyMk7F6BeCdDoSoEB58OeFNroo2ddfr3zclkEKC0
	 Y8maVsRo8rU/e2vHfMbYDu+arOIH1zxFDi4Gu+rJx66i43MWCuCOSLny0ZWKahpQdK
	 2cnqmND2z+ZL4zCqKJgfh+uG/hmJ0YuWrYd0iqT+4CuA+yZF8T3DooBF/vbhcRZ/ha
	 EhVUEovcUdRMwi65j/blUiA/BjOpn4Ctk8jW/CezfPCbmAkgW8OCEnFRfGE7qtYTHm
	 Twd+4FApVhpbOpKGQgc9c3Z3UW/5PJZ5vGefYuUNysdnscsZIskxa5iUr+RHFeVHHa
	 7UXTz9navxtlg==
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
Subject: [PATCH net-next v3 10/15] tools: ynl: stop using mnl_cb_run2()
Date: Tue, 27 Feb 2024 14:30:27 -0800
Message-ID: <20240227223032.1835527-11-kuba@kernel.org>
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

There's only one set of callbacks in YNL, for netlink control
messages, and most of them are trivial. So implement the message
walking directly without depending on mnl_cb_run2().

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
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


