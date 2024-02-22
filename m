Return-Path: <netdev+bounces-74203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F7D860735
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22278B227AC
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6547140E5C;
	Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYUtvU9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9E140E59
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646191; cv=none; b=Htp7lXJFXPe1WCxAqw+MOqDwp+rKif2cE7VbGmKL6VTVFGALVT6J5VOOJXSsqiZ2SqPIhCscl9wGd3oXI+u4HCPV6SpKPInx3Mqq+Euao2P7zExuv32mB+IdLInUevxXRqikIXKePBJJgaMAIOeNjnkWf56EzJ0LPf34YoHMF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646191; c=relaxed/simple;
	bh=/yyWZjSQ4l8tgRxGmfFjGr+AM1NQrdOV6WHonUz82aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LI5+J0Yb4RJJ4mCOAkwKBZTYIEIeaLxqSk5t1Z545qBkcoexO7LlEaiQ9WmiFZv1tPuAZ5JCGWvdIBdqOEMk22+VfV9QvEb6ZjCqTnb2eTnAshPOtCd8ciAxbUYSq0gY/k7NfaoW7mP8SXhF4TcaIGSHy1RKq/rR+q8pxoeucCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYUtvU9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB00C433F1;
	Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646190;
	bh=/yyWZjSQ4l8tgRxGmfFjGr+AM1NQrdOV6WHonUz82aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYUtvU9XyPYDCzYTOAk6IZMBX0eu9ayWaVBqJ854QmQNEUVvcqasB5ljNxAg/t1GD
	 zXJGKaXuUDliQnOPYI6N3Pwuz6WnUiPyFMNK3RKLcWUro6kAF4b/UTm2JjhW3o4cfh
	 zG56wHeHSfJ0GqHiVa3jjjP3BTVV7rGuajv2rEZKuHltriG7koJNb7nS3Eye3OZwhx
	 63jpsOZCQ3bFgNwuIx6ukQ44GfR31Deqv9RjI719YEgLphJgsqTY2o9k4SqVLJuMwP
	 KrRtF5eM/Fe0efVD9/mzI6OImGmmpXgdQBmUCJzqbHkKP9Fj2jCJ50kj2SUQd4Ywqf
	 ZHPPNGs5i2kJQ==
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
Subject: [PATCH net-next 09/15] tools: ynl: use ynl_sock_read_msgs() for ACK handling
Date: Thu, 22 Feb 2024 15:56:08 -0800
Message-ID: <20240222235614.180876-10-kuba@kernel.org>
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

ynl_recv_ack() is simple and it's the only user of mnl_cb_run().
Now that ynl_sock_read_msgs() exists it's actually less code
to use ynl_sock_read_msgs() instead of being special.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h |  3 ---
 tools/net/ynl/lib/ynl.c      | 34 ++++++++++++++--------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 653119c9f47c..65880f879447 100644
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
index 96a209773ace..c01a971c251e 100644
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


