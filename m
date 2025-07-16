Return-Path: <netdev+bounces-207435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71764B0735C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8493F1776D3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AEE2F4A0E;
	Wed, 16 Jul 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtCCEsGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7192F4A0B;
	Wed, 16 Jul 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661708; cv=none; b=RpqqW1Jaf0EFmTNrLxs187UBOVA38mLaKSESaBsXOKL7tnqCp65LQ/5htO/qWggdwq0zooQQLX3nsU1tv9M9nkxJ36Sh6CuwkJqNNil9pKij1ExGY7to+opgg+dfWfESQKk/XOICgKbAUMHIO27TQa8QH6jxJY1tpHDPVeX2BmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661708; c=relaxed/simple;
	bh=481cka8erGmjKbyjTt7K9jn11qoN9jnG5VVx4IklCeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpTvC7T748hvF+M31NW5IlZ+m8mZP1ngTIpVFxmcihfa+yi6xOYXq4eSc4dfocjB2Qy12kSQxhLvrAXr30UIgC6TTZ2of09PfeVF253oYAs3L1WEGlgdz8OvFSKSiLyPPvVn5XFZeyG59OQZL4X7tw+zkRYWli3G6GrcXMPi7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtCCEsGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A6AC4CEF0;
	Wed, 16 Jul 2025 10:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661707;
	bh=481cka8erGmjKbyjTt7K9jn11qoN9jnG5VVx4IklCeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BtCCEsGTgsQwGuMt35pKV0JZkMensIQODAfEWoU6GiwPYYVZWiu8InG57PLetPinG
	 Ehl4vZ9xfQGXWHG2dG7OQ2q9VfxuT5X6QkL3DnAi7HGLsT6hjRcv0hUFP/8XLq5apT
	 WolbfftPuYhEqndSfxeS+ERvz5YbNIuRxloEuAnu/DG8uP7JPijApc7fzaqr7RNPNw
	 kqFkWeSz4OlXlAfuX02R5LOl54cmwJQW6mPK6pjTlSxSIf8T+mSKBhLDTALDTw09Op
	 EmFC/EwXKTwR8eA5Xd+DqAl7FNBTg4WZve8RqbDlcczIOB0Muw4VeTBy6ShKEd7L9b
	 3bAkY8Yv0YWAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Jul 2025 12:28:05 +0200
Subject: [PATCH net-next 3/4] mptcp: add TCP_MAXSEG sockopt support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-net-next-mptcp-tcp_maxseg-v1-3-548d3a5666f6@kernel.org>
References: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
In-Reply-To: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qOHsJBqU1N3UcL7j8IzEZR4JZWaMj7+gDpL8lzuOm88=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLK6/Zn7Yk+O3vm5zQu1+LG3pWHrifsYn4wQ3+rZsS9n
 csMNnkndpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk9yAjw47j5nsi/Mp0vtV1
 OJ851LEp8NJmo2ksnbvFWm8XStmaOzH8FROT0N6XNv+jT/P8B3su9fp8Csw78yr9YNXGsPQ5TwK
 1uAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
because it has never been requested before. But there are still valid
use-cases, e.g. with HAProxy.

This patch adds its support in MPTCP by propagating the value to all
subflows. The get part looks at the value on the first subflow, to be as
closed as possible to TCP. Only one value can be returned for the cached
MSS, so this can come only from one subflow.

Similar to mptcp_setsockopt_first_sf_only(), a generic helper
mptcp_setsockopt_all_subflows() is added to set sockopt for each
subflows of the mptcp socket.

Add a new member for struct mptcp_sock to store the TCP_MAXSEG value,
and return this value in getsockopt.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3dd11dd3ba16e8c1d3741b6eb5b526bb4beae15b..9c43a1f037e71243e202f907608ad42086dbde4b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -326,6 +326,7 @@ struct mptcp_sock {
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
+	int		maxseg;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index afa54fba51e215bc2efb21f16ed7d0a0fb120972..379a02a46b7bf706480cf66a88c6cf2357d2a62b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -798,6 +798,23 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret = 0;
+
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -859,6 +876,11 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 &msk->keepalive_cnt,
 						 val);
 		break;
+	case TCP_MAXSEG:
+		msk->maxseg = val;
+		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
+					      optlen);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1406,6 +1428,9 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_MAXSEG:
+		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1552,6 +1577,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
 	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
+	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));

-- 
2.48.1


