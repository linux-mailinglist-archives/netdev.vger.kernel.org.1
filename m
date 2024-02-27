Return-Path: <netdev+bounces-75495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD686A282
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15FF287CEF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836C56740;
	Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STgJXBVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FB56473
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073049; cv=none; b=bvis4V0RoO6b4ijIfxA1KQTdmmH3agclud5zCyc7e/Amtl6FH9LFdp6L7crAM+wbB54d+86R8/QlSNnvFnLr86JDAb84kNSHcfBICzyc4ct6TsJIxJtU4heYxk03MBHg+fV/pwpQj83llAf81Y9EeaXbLx0QKZx/nl7xxOBtrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073049; c=relaxed/simple;
	bh=04JrzH1vHBNf4f/z4e++KWVJoTtYOV/RnToAuokunpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoJlmoj4MYnTGcc8+5PCo5PfyG5mZWK21u0EBg8tm+/j3ZuH81GXnWjW3BNc8MprZ5zq3cnT7j/e28eZFSYvt6AYiyQ8Qs6T+NYNcLT3zK0ULJkMsHl6YGy86V9d64jGPROaOPXTecD5Tb3wKKEzudMG8fgT207A6tOWhRBZNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgJXBVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1DAC433F1;
	Tue, 27 Feb 2024 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073049;
	bh=04JrzH1vHBNf4f/z4e++KWVJoTtYOV/RnToAuokunpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STgJXBVi9bGgCigmilUzm8LkYw5y05z2lQfitrauYbF9ryYEgnsl9C3cQi3Em68lN
	 PxxL4qi3ZpX+YBU4xnMR1Crt22k3m5MWAZ2VHlYz0APkoK0qK5q8HEQ+7rPAhrutp4
	 CAkTh/pP3qtwPV7mA+LAaB855zzA+z2fC7o9n7/0AZCNXaLEjxmkO0YsxBrdwM+43y
	 IH7CrX+OxRAl2ueLw1rK1HZGCm158X7HkQxXuP0O7JsQZSSgUvVHL0W5ZP6bSXJywS
	 nEduHcf76aDYdOCYChm93KXnDRjA9vCt4u+IryWN5+zgH1pgcYWsl6/ToKduywyBO/
	 dwCv0cPCMAJhQ==
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
Subject: [PATCH net-next v3 09/15] tools: ynl: use ynl_sock_read_msgs() for ACK handling
Date: Tue, 27 Feb 2024 14:30:26 -0800
Message-ID: <20240227223032.1835527-10-kuba@kernel.org>
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
index ef16fcbd9f68..42f7d29fbee0 100644
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


