Return-Path: <netdev+bounces-96229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777508C4ACC
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8091F22F13
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C34817F6;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUZ8U8ZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DADA94B;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649223; cv=none; b=SejsbJ7M4xzuSiNZ1sFxzZHNMFAaIL/4rd4RPXKxIa4Sh4uJcEIgi9dThe+v4U4W4ENvVA6QudLO0tw6jWI/xlvXPttlWDUlfm5vJTWV07Wo4p1rzhERURNa7CqohpaatnDKUyBMGSI+28Q5jJIOTUhg7rvH7x8d5qGrNSwO5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649223; c=relaxed/simple;
	bh=gFakMct8wqfURtjlv4dVJOCOcVG3xoX/nIjOFY3vLYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeRh37CRI1mAVA1dUpPOsJDlaBnBbmB1EKM+V5vzq4eQlzdV5Bn0O288mPEOR1yVgNx4GXba49sILTeYD5nipKYjJ0vLk1FLAVJjYiLDt4e8FxrJI2Lp6lgG+STMmJrhUJJdvHspkU/NGU1+JYFdgRiJNNqOFLl/Lz3BgeygY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUZ8U8ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B28C4DDEA;
	Tue, 14 May 2024 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649223;
	bh=gFakMct8wqfURtjlv4dVJOCOcVG3xoX/nIjOFY3vLYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUZ8U8ZHaCczR6fkAeWWdG61qy5Qlc68EQ3UNDExq1KinGktXNHW12ftQQgLcLh59
	 xzq+q4j09ob5+tVIAdLFCDa6mUFxj5Xazg5K7GbSgJP4tE5AzqYMMscK4ohZeRxwxa
	 gwistGvddn8MTq/c8gNuOyeR5QcgkWUZeKTR+aJssiDaFDGtBPIWe6kQMNSV8nZHGc
	 /PB4utNpC+wWI3JNWTy9QFdo2sTPEBgCVY22y/Hsj2WNNTIh+6wWKe1J8X7Tpljypc
	 f4z0JMoHEyIlVzn5jht1l1dAFQialjm4p73l51Ap9Oig1sJXeRc4AVJmRf6Cgqretv
	 mSnyVq75NsbWQ==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 5/8] mptcp: prefer strscpy over strcpy
Date: Mon, 13 May 2024 18:13:29 -0700
Message-ID: <20240514011335.176158-6-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() [1].

This is in preparation of a possible future step where all strcpy() uses
will be removed in favour of strscpy() [2].

This fixes CheckPatch warnings:

  WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/ctrl.c     | 2 +-
 net/mptcp/protocol.c | 5 +++--
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 542555ba474c..98b1dd498ff6 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -92,7 +92,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
-	strcpy(pernet->scheduler, "default");
+	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 }
 
 #ifdef CONFIG_SYSCTL
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb8f96f2b86f..a42494d3a71b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2814,7 +2814,8 @@ static void mptcp_ca_reset(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_assign_congestion_control(sk);
-	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
+	strscpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name,
+		sizeof(mptcp_sk(sk)->ca_name));
 
 	/* no need to keep a reference to the ops, the name will suffice */
 	tcp_cleanup_congestion_control(sk);
@@ -4169,7 +4170,7 @@ int __init mptcp_proto_v6_init(void)
 	int err;
 
 	mptcp_v6_prot = mptcp_prot;
-	strcpy(mptcp_v6_prot.name, "MPTCPv6");
+	strscpy(mptcp_v6_prot.name, "MPTCPv6", sizeof(mptcp_v6_prot.name));
 	mptcp_v6_prot.slab = NULL;
 	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
 	mptcp_v6_prot.ipv6_pinfo_offset = offsetof(struct mptcp6_sock, np);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a77b33488176..f9a4fb17b5b7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -616,7 +616,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	}
 
 	if (ret == 0)
-		strcpy(msk->ca_name, name);
+		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
 	release_sock(sk);
 	return ret;
-- 
2.45.0


