Return-Path: <netdev+bounces-75108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E58682E6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE391F26BB6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECB132496;
	Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAqZglSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72508132492
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982432; cv=none; b=JgMPJx7HpAz084DWMKHkpBmEED2guzX8uiWE5JSxH2fBHvwCRvqzPZzeanTd9bDKEYPkosKcwM2ZJCuA5zb3jYbbD4xWlP+79rgUxIFUMP1OfeArMtfF2fnaOoDPN4ckHvftirPbmHQCLYQwfu1EwcDa0kYiWCqQbSYy5HfIDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982432; c=relaxed/simple;
	bh=4FabDURe3ntQWAuyxcLjrVcZ4MxY8gqndiSSoEAy3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJRtmGj4jk4a9Kk0VYVh/YGF5ZOGMZ+j4le6w4JKi+79YJhHdLr7xBfi5ER8ICvwyN38oKkJNhSpOaRwFFMv2tVcovM3xOivvW/99o8hKxIhDiyk+FOhoqi0ewjlEPQxafU3CCG8w83qNAp3cwrrHwHJBeWDSq73kD0HAvQimU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAqZglSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04165C43399;
	Mon, 26 Feb 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982432;
	bh=4FabDURe3ntQWAuyxcLjrVcZ4MxY8gqndiSSoEAy3N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAqZglSP+kikXyBpsdV5PHe6yAaAs5K/jUR0Nhx+3lxkvGLsnjTdPNS9N7eHJbG3i
	 7+WuSwvtIQ00ikV5OvbREgx4KbTHUqOQKoyNa0+LLA+M7J78XRM/BVdlLxDgiBo7h/
	 zRhKGd2Ze4OSy591cdtR6WSEbJHiAjgW6G8VSdPartokNDqM4WPhL1Y0ZLi+ybSJG9
	 6dRfoVjkXduzl+UUqc0CExpg0GnCjdj0lHONlVo5w7MPcTTvTY7floiM5aERSCABcC
	 XqwdjQOWoDBBCvezmfbpaUsiHbpdDHbNj2lhzmI3aNoEXlF/bW/8OSAxRfLc4XK5Wu
	 3LfOC8VokDvLA==
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
Subject: [PATCH net-next v2 09/15] tools: ynl: use ynl_sock_read_msgs() for ACK handling
Date: Mon, 26 Feb 2024 13:20:15 -0800
Message-ID: <20240226212021.1247379-10-kuba@kernel.org>
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

ynl_recv_ack() is simple and it's the only user of mnl_cb_run().
Now that ynl_sock_read_msgs() exists it's actually less code
to use ynl_sock_read_msgs() instead of being special.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h |  3 ---
 tools/net/ynl/lib/ynl.c      | 34 ++++++++++++++--------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 59e9682ce2a9..310302e48f61 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -90,9 +90,6 @@ ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 
 int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
 
-int ynl_recv_ack(struct ynl_sock *ys, int ret);
-int ynl_cb_null(const struct nlmsghdr *nlh, void *data);
-
 /* YNL specific helpers used by the auto-generated code */
 
 struct ynl_req_state {
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 7c0f404526a0..f830990b3f4a 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -462,26 +462,7 @@ ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version)
 			       cmd, version);
 }
 
-int ynl_recv_ack(struct ynl_sock *ys, int ret)
-{
-	struct ynl_parse_arg yarg = { .ys = ys, };
-
-	if (!ret) {
-		yerr(ys, YNL_ERROR_EXPECT_ACK,
-		     "Expecting an ACK but nothing received");
-		return -1;
-	}
-
-	ret = mnl_socket_recvfrom(ys->sock, ys->rx_buf, MNL_SOCKET_BUFFER_SIZE);
-	if (ret < 0) {
-		perr(ys, "Socket receive failed");
-		return ret;
-	}
-	return mnl_cb_run(ys->rx_buf, ret, ys->seq, ys->portid,
-			  ynl_cb_null, &yarg);
-}
-
-int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
+static int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
 {
 	struct ynl_parse_arg *yarg = data;
 
@@ -504,6 +485,19 @@ static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
 			   cb, yarg, ynl_cb_array, NLMSG_MIN_TYPE);
 }
 
+static int ynl_recv_ack(struct ynl_sock *ys, int ret)
+{
+	struct ynl_parse_arg yarg = { .ys = ys, };
+
+	if (!ret) {
+		yerr(ys, YNL_ERROR_EXPECT_ACK,
+		     "Expecting an ACK but nothing received");
+		return -1;
+	}
+
+	return ynl_sock_read_msgs(&yarg, ynl_cb_null);
+}
+
 /* Init/fini and genetlink boiler plate */
 static int
 ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
-- 
2.43.2


