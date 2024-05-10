Return-Path: <netdev+bounces-95412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91958C22F9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185231C21305
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7F16F8E9;
	Fri, 10 May 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlwjDlj5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE316F84A;
	Fri, 10 May 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339941; cv=none; b=ieY/Hr+iKdFUe5Nz41smoYb9faTgCdalCOm8qw01Erob6jml4+2r9VnFe+Mpp/dgSFifq+r3LDzFoM2akPmbHLP98XRiMM5/z5vT/YtxE0bUm0HWMaaOmC9c0vkF5EbylGxnfESjJPD6NH7lGPpK4Wf7OrhE+uFJZZ9gAdZt6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339941; c=relaxed/simple;
	bh=gx0qqngzRCb+X3NtTvf6ue9ZR5QeWwvf6CM1qbMEY0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzYQzjpNsmtZEMRdLsVufcPYtIjvXHlryfRyJ5zerEsMXphHQIO8/cDg63UaIdduESvb+foO4KA44NsZzj6HNK/y1jSwL5MBN5MS1WXO1fICC7+UMOLbe25jQoByPC9BaTEFM0CBPJV6WqeQ9gUvqs1zUcwG+t3+gohADGVIwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlwjDlj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C990BC32782;
	Fri, 10 May 2024 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339941;
	bh=gx0qqngzRCb+X3NtTvf6ue9ZR5QeWwvf6CM1qbMEY0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BlwjDlj5ydEfEtgpMuQ0zKPg8vS3jGRtZiXFy/sBwZyFiStJ9FOldjUmK2+61bWE9
	 2EJ1EDdfIIuhsLWHdHLH7EFS+7TI9aStB7rykzinR9ZxtFJi5GEfHWZOlWegJclnFT
	 C3PQiCC/UAwYwYGqCGhTX663TTZ5NH0LPVryzThWf6lzfZFXoXzRKSdhJKd56s+jdf
	 BCDtv6MaXEEQIXVYRXjPFELXIORmxDBVWq5Qfwrxgvc3EoLjDw3qyK/frlFnzKc39z
	 rvl4CLXL6hpVihQWGx+7RIhCR+s/hYWZ8DI7nHo8AexPEI/sSwZO7hLw1H77DWYgYK
	 cTZMBECpgEA9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:32 +0200
Subject: [PATCH net-next 2/8] mptcp: fix full TCP keep-alive support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-2-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5443; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gx0qqngzRCb+X3NtTvf6ue9ZR5QeWwvf6CM1qbMEY0Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcIc9HwzMrvpi3OdLqtATyRjcLlX+1i7ZJA
 zezNGV2ThSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c1gZD/9CVUD5Ahvb5u7TKpKWBK6tGP8WSjoXhtb4JldU0AzwxL2B3srufsfMRs/0REPrvMrNKmx
 gmG1KylIFd4aypwO5UxCNRVttOD6fA9WtZfPs25dmpuMBd/FpMwca1o8PGndXK64YX1g5foG6os
 jt2n8vqB27dLGYbIq7/4uk69+C8tQAQkTIkZMI9blJYFW88wLiazyQt3WddAPqb8AiJ8LN48ryO
 WkAE27A0Y3er5LmCqbf//MzVrikPyt0STNTLHxJxc0YVeKAyGWhgD78zJkgoXEA3QvjqDh5uCCt
 gd5y5K8OLm4nkMOrAbYg6ItTBhNH3zgDewcPOUXLlUBeU57+4pXXSfs2HY1XcXlQc4oM4pBx456
 gOUSL32Lj/36MwCCC/5bxuwPFZYCRp06+GLPZVML/59rzE+WWMHRHmbE1RW8WsRIAH6/5okf3ai
 2AACTrIFYAPtgA59igPLp9+BP+dMUScSx48QcWiqCzyqW9A4hfEm+EqM5td7NaJWzayRXcmN2V8
 E5YZAutEIgE8szAPl8Ox/Zno18Xm/5lH/txuJ7ocDbss3OzJzNX2+0BvFHSwiSSeojllRCxhGmP
 ib+NRl+ACfxZFBQJChk+NkIIWxKjxtPN4zgq9fNfwuLbXQ6BTdGT1eNMogGNvN0BMHLiCqDE3GR
 WfgFhGrWazRPerg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SO_KEEPALIVE support has been added a while ago, as part of a series
"adding SOL_SOCKET" support. To have a full control of this keep-alive
feature, it is important to also support TCP_KEEP* socket options at the
SOL_TCP level.

Supporting them on the setsockopt() part is easy, it is just a matter of
remembering each value in the MPTCP sock structure, and calling
tcp_sock_set_keep*() helpers on each subflow. If the value is not
modified (0), calling these helpers will not do anything. For the
getsockopt() part, the corresponding value from the MPTCP sock structure
or the default one is simply returned. All of this is very similar to
other TCP_* socket options supported by MPTCP.

It looks important for kernels supporting SO_KEEPALIVE, to also support
TCP_KEEP* options as well: some apps seem to (wrongly) consider that if
the former is supported, the latter ones will be supported as well. But
also, not having this simple and isolated change is preventing MPTCP
support in some apps, and libraries like GoLang [1]. This is why this
patch is seen as a fix.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/383
Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Link: https://github.com/golang/go/issues/56539 [1]
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cfc5f9c3f113..4dcce3641d1d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -312,6 +312,9 @@ struct mptcp_sock {
 			free_first:1,
 			rcvspace_init:1;
 	u32		notsent_lowat;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 69fc584fc57e..63a3edc75857 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -622,6 +622,31 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				      int (*set_val)(struct sock *, int),
+				      int *msk_val, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	int err = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
+
+		lock_sock(ssk);
+		ret = set_val(ssk, val);
+		err = err ? : ret;
+		release_sock(ssk);
+	}
+
+	if (!err) {
+		*msk_val = val;
+		sockopt_seq_inc(msk);
+	}
+
+	return err;
+}
+
 static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
@@ -818,6 +843,22 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_NODELAY:
 		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
 		break;
+	case TCP_KEEPIDLE:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						 &tcp_sock_set_keepidle_locked,
+						 &msk->keepalive_idle, val);
+		break;
+	case TCP_KEEPINTVL:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						 &tcp_sock_set_keepintvl,
+						 &msk->keepalive_intvl, val);
+		break;
+	case TCP_KEEPCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						 &tcp_sock_set_keepcnt,
+						 &msk->keepalive_cnt,
+						 val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1326,6 +1367,8 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -1344,6 +1387,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_KEEPIDLE:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_idle ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
+	case TCP_KEEPINTVL:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_intvl ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
+	case TCP_KEEPCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_cnt ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
 	case TCP_NOTSENT_LOWAT:
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	}
@@ -1461,6 +1516,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 	__tcp_sock_set_cork(ssk, !!msk->cork);
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));

-- 
2.43.0


